#include "report_death.hpp"
#include "Geode/utils/web.hpp"
#include <matjson.hpp>
#include "../managers/api_manager.hpp"

ReportDeathTask
reportDeath(const ReportDeathInput &input) {
  web::WebRequest req = web::WebRequest();

  matjson::Value inputJson = input;
  req.bodyJSON(inputJson);
  req.header("Content-Type", "application/json");

  req.timeout(std::chrono::seconds(5));

  return req.post(APIManager::get().getEndpoint("v3/reportDeath"))
      .map(
          [](web::WebResponse *result) -> ReportDeathTask::Value {
            if (result->ok()) {
                return Ok();
            }
            return Err("Not reported death with code {}.", result->code());
          },
          [](web::WebProgress *progress)
              -> ReportDeathTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}

