#include "get_replay.hpp"
#include "Geode/utils/web.hpp"
#include "../managers/api_manager.hpp"

GetReplayTask getReplay(const GetReplayInput& input) {
  web::WebRequest req = web::WebRequest();

  matjson::Value inputJson = input;
  req.bodyJSON(inputJson);
  req.header("Content-Type", "application/json");

  req.timeout(std::chrono::seconds(5));

  return req.post(APIManager::get().getEndpoint("v3/getReplay"))
      .map(
          [](web::WebResponse *result) -> GetReplayTask::Value {
            ByteVector gdr2Raw = result->data();
            std::span<uint8_t> gdr2RawSpan(gdr2Raw);
            GEODE_UNWRAP_INTO(ShowcaseBotReplay gdr2, ShowcaseBotReplay::importData(gdr2RawSpan));
            return Ok(gdr2);
          },
          [](web::WebProgress *progress) -> GetReplayTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}

