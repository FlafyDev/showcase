#pragma once

#include "../includes/geode.hpp"
#include "../tasks/get_upload_submissions_left.hpp"
#include "../tasks/upload_submissions.hpp"
#include "../tasks/authenticate.hpp"

class APIManager {
protected:
  APIManager() = default;
  APIManager(const APIManager &) = delete;
  APIManager(APIManager &&) = delete;

  APIManager &operator=(const APIManager &) = delete;
  APIManager &operator=(APIManager &&) = delete;

  typedef std::vector<std::vector<uint8_t>> SubmissionsData;

  EventListener<AuthenticateTask> m_authenticateListener;

  bool m_initialized = false;
  bool m_authenticated = false;

  std::filesystem::path m_uploadDir;
  std::string m_baseURL = "http://showcase.flafy.dev";
  EventListener<GetUploadSubmissionsLeftTask> m_getUploadSubmissionsLeftListener;
  EventListener<UploadSubmissionsTask> m_uploadSubmissionsListener;

  void onSubmissionLeft(const int submissionsLeft);
  void setDashAuthToken(const std::optional<std::string> &token);
  void authenticate();

public:
  bool init();

  void tryUpload();
  std::filesystem::path getUploadDir() const;
  std::string getBaseURL() const;
  std::string getEndpoint(const std::string &endpoint) const;
  bool isAuthenticated();
  // Returns the authenticated token. If not authenticated then the result is a valid token / invalid token / empty string
  std::string getDashAuthToken();

  static APIManager &get() {
    static APIManager instance;
    return instance;
  }
};

