#include "get_upload_submissions_left.hpp"
#include "Geode/utils/web.hpp"
#include "../managers/api_manager.hpp"

GetUploadSubmissionsLeftTask
getUploadSubmissionsLeft(const GetUploadSubmissionsLeftInput &input) {
  web::WebRequest req = web::WebRequest();

  matjson::Value inputJson = input;
  req.bodyJSON(inputJson);
  req.header("Content-Type", "application/json");

  req.timeout(std::chrono::seconds(5));

  return req.post(APIManager::get().getEndpoint("v3/getSubmissionsLeft"))
      .map(
          [](web::WebResponse *result) -> GetUploadSubmissionsLeftTask::Value {
            GEODE_UNWRAP_INTO(matjson::Value json, result->json());
            GEODE_UNWRAP_INTO(UploadSubmissionsLeftResponse data,
                              json.as<UploadSubmissionsLeftResponse>());
            return Ok(data);
          },
          [](web::WebProgress *progress)
              -> GetUploadSubmissionsLeftTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}
