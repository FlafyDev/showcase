#include "report_crash_log.hpp"
#include "Geode/utils/web.hpp"
#include <matjson.hpp>
#include "../managers/api_manager.hpp"

ReportCrashLogTask
reportCrashLog(const ReportCrashLogInput &input) {
  web::WebRequest req = web::WebRequest();

  matjson::Value inputJson = input;
  req.bodyJSON(inputJson);
  req.header("Content-Type", "application/json");

  req.timeout(std::chrono::seconds(5));

  return req.post(APIManager::get().getEndpoint("v3/reportCrashLog"))
      .map(
          [](web::WebResponse *result) -> ReportCrashLogTask::Value {
            if (result->ok()) {
                return Ok();
            }
            return Err("Not reported crash log with code {}.", result->code());
          },
          [](web::WebProgress *progress)
              -> ReportCrashLogTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}

