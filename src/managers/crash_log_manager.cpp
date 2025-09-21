#include "crash_log_manager.hpp"
#include "../recorder/unsecure_recorder.hpp"
#include "Geode/utils/general.hpp"
#include "api_manager.hpp"
#include "interferences_manager.hpp"
#include <filesystem>
#include <regex>
#include <stdexcept>

bool CrashLogManager::init() {
  if (m_initialized) {
    return true;
  }

  try {
    reportLatestCrashLog();
  } catch (const std::exception& e) {
    log::error("Unreportable error has occured in Showcase mod. Please manually report this error: {}.", e.what());
  } catch (...) {
    log::error("An unknown and unreportable error has occured in Showcase mod.");
  }

  return true;
}

Result<std::time_t> parse_logname_to_epoch(const std::string &fname) {
  std::regex filename_re(
      R"((\d{4})-(\d{2})-(\d{2})_(\d{2})-(\d{2})-(\d{2})\.log)");
  std::smatch match;

  if (std::regex_match(fname, match, filename_re) && match.length() >= 7) {
    std::tm tm{};
    tm.tm_year = GEODE_UNWRAP(numFromString<int>(match[1].str(), 10)) - 1900;
    tm.tm_mon = GEODE_UNWRAP(numFromString<int>(match[2].str(), 10)) - 1;
    tm.tm_mday = GEODE_UNWRAP(numFromString<int>(match[3].str(), 10));
    tm.tm_hour = GEODE_UNWRAP(numFromString<int>(match[4].str(), 10));
    tm.tm_min = GEODE_UNWRAP(numFromString<int>(match[5].str(), 10));
    tm.tm_sec = GEODE_UNWRAP(numFromString<int>(match[6].str(), 10));
    return Ok(std::mktime(&tm));
  }
  return Err("Invalid log filename format: " + fname);
}

std::optional<std::tuple<std::filesystem::path, std::time_t>>
getLatestLog(const std::filesystem::path &dir) {
  std::optional<std::filesystem::path> latest_file;
  std::time_t latest_time;

  std::error_code ec;

  if (!std::filesystem::is_directory(dir, ec) || ec) {
    return std::nullopt;
  }

  std::regex filename_re(
      R"((\d{4})-(\d{2})-(\d{2})_(\d{2})-(\d{2})-(\d{2})\.log)");

  for (auto const &entry : std::filesystem::directory_iterator(dir, ec)) {
    if (ec)
      break;

    if (!entry.is_regular_file(ec) || ec)
      continue;

    Result<std::time_t> epochRes =
        parse_logname_to_epoch(entry.path().filename().string());
    if (epochRes.isErr())
      continue;

    if (!latest_file || epochRes.unwrap() > latest_time) {
      latest_file = entry.path();
      latest_time = epochRes.unwrap();
    }
  }

  if (!latest_file) {
    return std::nullopt;
  }

  return std::tuple<std::filesystem::path, std::time_t>(latest_file.value(),
                                                        latest_time);
}

Result<std::string> extractNeededInfo(const std::filesystem::path &file) {
  std::ifstream in(file);
  if (!in)
    return Err("Failed to open file: " + file.string());

  std::ostringstream result;
  std::string line;
  bool in_section = false;

  while (std::getline(in, line)) {
    if (line.starts_with("== Stack Trace ==")) {
      in_section = true;
      continue;
    }
    if (line.starts_with("== Installed Mods ==")) {
      break;
    }
    if (in_section || line.starts_with("Faulty Mod:") ||
        line.starts_with("Exception Code:") ||
        line.starts_with("Exception Flags:") ||
        line.starts_with("Exception Details:") ||
        line.starts_with("Crashed thread:")
    ) {
      result << line << '\n';
    }
  }

  return Ok(result.str());
}

void CrashLogManager::reportLatestCrashLog() {
  auto latestCrashLogOpt = getLatestLog("./geode/crashlogs");
  if (!latestCrashLogOpt.has_value())
    return;

  auto rawCrashLogRes =
      extractNeededInfo(std::get<0>(latestCrashLogOpt.value()));
  if (rawCrashLogRes.isErr())
    return;

  const std::string rawCrashLog = rawCrashLogRes.unwrap();

  if (rawCrashLog.find("flafy.showcase") == std::string::npos) {
    return;
  }

  m_reportCrashLogListener.setFilter(reportCrashLog({
    std::get<1>(latestCrashLogOpt.value()),
    fmt::format("{}\n\n{}", Mod::get()->getVersion().toVString(), rawCrashLog),
    APIManager::get().getDashAuthToken(),
  }));
}
