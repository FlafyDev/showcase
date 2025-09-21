#pragma once
#include "../includes/geode.hpp"
#include "../includes/showcase_bot.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>

using GetReplayTask = Task<Result<ShowcaseBotReplay>, float>;

struct GetReplayInput {
  const std::string replayID;
};

template <> struct matjson::Serialize<GetReplayInput> {
  static matjson::Value toJson(const GetReplayInput &input) {
    return matjson::makeObject({
        {"replayID", input.replayID},
    });
  }
};

GetReplayTask getReplay(const GetReplayInput &input);
