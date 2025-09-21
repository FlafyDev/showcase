#include "get_level_replay_status.hpp"
#include "../managers/api_manager.hpp"
#include "Geode/utils/web.hpp"

GetLevelReplayStatusTask
getLevelReplayStatus(const LevelReplayStatusInput &input) {
  web::WebRequest req = web::WebRequest();

  matjson::Value inputJson = input;
  req.bodyJSON(inputJson);
  req.header("Content-Type", "application/json");

  req.timeout(std::chrono::seconds(5));
  return req
      .post(APIManager::get().getEndpoint("v3/getReplayStatus"))
      .map(
          [](web::WebResponse *result) -> GetLevelReplayStatusTask::Value {
            GEODE_UNWRAP_INTO(matjson::Value json, result->json());
            GEODE_UNWRAP_INTO(LevelReplayStatus data,
                              json.as<LevelReplayStatus>());
            return Ok(data);
          },
          [](web::WebProgress *progress) -> GetLevelReplayStatusTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}
