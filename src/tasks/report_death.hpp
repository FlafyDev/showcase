#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <cstdint>
#include <optional>

struct ReportDeathInput {
  int64_t levelID;
  int32_t levelVersion;
  int64_t frame;
  float percent;
  const std::string token;
};

using ReportDeathTask = Task<Result<>, float>;

template <> struct matjson::Serialize<ReportDeathInput> {
  static matjson::Value toJson(const ReportDeathInput &input) {
    return matjson::makeObject({
        {"levelID", input.levelID},
        {"levelVersion", input.levelVersion},
        {"frame", input.frame},
        {"percent", input.percent},
        {"token", input.token},
    });
  }
};

ReportDeathTask reportDeath(const ReportDeathInput &input);
