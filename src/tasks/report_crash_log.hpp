#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <cstdint>
#include <optional>

struct ReportCrashLogInput {
  int64_t crashTime;
  const std::string rawCrashLog;
  const std::string token;
};

using ReportCrashLogTask = Task<Result<>, float>;

template <> struct matjson::Serialize<ReportCrashLogInput> {
  static matjson::Value toJson(const ReportCrashLogInput &input) {
    return matjson::makeObject({
        {"crashTime", input.crashTime},
        {"rawCrashLog", input.rawCrashLog},
        {"token", input.token},
    });
  }
};

ReportCrashLogTask reportCrashLog(const ReportCrashLogInput &input);
