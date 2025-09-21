#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <optional>

struct LevelReplayStatus {
  std::optional<std::string> replayID;
};

struct LevelReplayStatusInput {
  std::intmax_t levelID;
  int levelVersion;
  const std::string gdVersion;
  const std::string modVersion;
  const std::string token;
};

using GetLevelReplayStatusTask = Task<Result<LevelReplayStatus>, float>;

template <> struct matjson::Serialize<LevelReplayStatus> {
  static geode::Result<LevelReplayStatus>
  fromJson(const matjson::Value &value) {
    if (value["replayID"].isNull()) {
      return geode::Ok(LevelReplayStatus{
          std::nullopt,
      });
    }
    GEODE_UNWRAP_INTO(std::string replayID, value["replayID"].asString());
    return geode::Ok(LevelReplayStatus{
        replayID,
    });
  }
};

template <> struct matjson::Serialize<LevelReplayStatusInput> {
  static matjson::Value toJson(const LevelReplayStatusInput &input) {
    return matjson::makeObject({
        {"levelID", input.levelID},
        {"levelVersion", input.levelVersion},
        {"gdVersion", input.gdVersion},
        {"modVersion", input.modVersion},
        {"token", input.token},
    });
  }
};

GetLevelReplayStatusTask
getLevelReplayStatus(const LevelReplayStatusInput &input);
