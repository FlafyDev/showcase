#include "api_manager.hpp"
#include "../tasks/authenticate.hpp"
#include <dashauth.hpp>

bool APIManager::init() {
  if (m_initialized) {
    return true;
  }

  m_uploadDir = Mod::get()->getSaveDir() / "upload_gdr2_v3";

  m_getUploadSubmissionsLeftListener.bind(
      [this](GetUploadSubmissionsLeftTask::Event *event) {
        if (GetUploadSubmissionsLeftTask::Value *result = event->getValue()) {
          if (result->isErr())
            return;
          log::debug("Have {} submissions left to upload",
                    result->unwrap().submissionsLeft);
          onSubmissionLeft(result->unwrap().submissionsLeft);
        }
      });

  m_authenticateListener.bind([this](AuthenticateTask::Event *event) {
    if (AuthenticateTask::Value *result = event->getValue()) {
      if (result->isErr()) {
        log::error("Failed to authenticate: {}", result->unwrapErr());
        return;
      }
      log::info("Verified token.");
      setDashAuthToken(result->unwrap());

      tryUpload();
    }
  });

  authenticate();

  m_initialized = true;
  return true;
}

std::filesystem::path APIManager::getUploadDir() const { return m_uploadDir; }

std::string APIManager::getBaseURL() const { return m_baseURL; };
std::string APIManager::getEndpoint(const std::string &endpoint) const {
  return std::format("{}/{}", m_baseURL, endpoint);
};

void APIManager::setDashAuthToken(const std::optional<std::string> &token) {
  Mod::get()->setSavedValue<std::optional<std::string>>("dashauth-token",
                                                        token);
}

std::string APIManager::getDashAuthToken() {
  if (!Mod::get()->hasSavedValue("dashauth-token")) {
    return "";
  }

  return Mod::get()
      ->getSavedValue<std::optional<std::string>>("dashauth-token")
      .value_or("");
}

void APIManager::authenticate() {
  if (GJAccountManager::sharedState()->m_accountID == 0) {
    return;
  }

  auto savedToken = getDashAuthToken();

  m_authenticateListener.setFilter(authenticateTask(savedToken));
}

bool APIManager::isAuthenticated() { return m_authenticated; }

void APIManager::tryUpload() {
  if (m_authenticated) {
    log::debug("Can't upload while not authenticated.");
    return;
  }

  if (m_getUploadSubmissionsLeftListener.getFilter().isPending() ||
      m_uploadSubmissionsListener.getFilter().isPending()) {
    log::debug("Can't upload. Another upload is currently pending...");
    return;
  }

  GetUploadSubmissionsLeftTask leftTask = getUploadSubmissionsLeft({
      getDashAuthToken(),
  });

  m_getUploadSubmissionsLeftListener.setFilter(leftTask);
}

void APIManager::onSubmissionLeft(const int submissionsLeft) {
  if (m_getUploadSubmissionsLeftListener.getFilter().isPending() ||
      m_uploadSubmissionsListener.getFilter().isPending()) {
    return;
  }

  SubmissionsData submissions;
  std::vector<std::filesystem::path> submissionPaths;

  int uploadsLeft = submissionsLeft;

  if (uploadsLeft <= 0) {
    return;
  }

  std::error_code ec;

  for (const auto &entry :
       std::filesystem::directory_iterator(m_uploadDir, ec)) {
    if (ec)
      break;

    if (uploadsLeft <= 0) {
      break;
    }

    if (entry.is_regular_file(ec) && !ec &&
        entry.path().filename().string().find(".gdr2") != std::string::npos) {

      std::ifstream file(entry.path(), std::ios::binary);

      if (!file || !file.is_open()) {
        continue;
      }

      file.seekg(0, std::ios::end);
      std::streamsize size = file.tellg();
      file.seekg(0, std::ios::beg);

      std::vector<uint8_t> buffer(size);
      if (!file.read(reinterpret_cast<char *>(buffer.data()), size)) {
        file.close();
        continue;
      }

      log::debug("Found submission");

      submissions.push_back(std::move(buffer));
      submissionPaths.push_back(entry.path());

      uploadsLeft -= 1;

      file.close();
    }
  }

  if (submissions.size() == 0) {
    return;
  }

  UploadSubmissionsTask uploadTask = uploadSubmissions(
      {
          getDashAuthToken(),
      },
      std::move(submissions));

  m_uploadSubmissionsListener.bind(
      [submissionPaths](UploadSubmissionsTask::Event *event) {
        if (UploadSubmissionsTask::Value *result = event->getValue()) {
          if (result->isErr())
            return;

          for (const auto subPath : submissionPaths) {
            std::filesystem::remove(subPath);
          }

          log::info("Showcase uploaded and deleted GDRs successfully.");
        }
      });

  m_uploadSubmissionsListener.setFilter(uploadTask);
}