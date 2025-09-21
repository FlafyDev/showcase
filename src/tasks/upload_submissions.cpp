#include "upload_submissions.hpp"
#include "Geode/utils/web.hpp"
#include <matjson.hpp>
#include "../managers/api_manager.hpp"

UploadSubmissionsTask
uploadSubmissions(const UploadSubmissionsInput &input,
                  const std::vector<std::vector<uint8_t>> &submissions) {

  web::WebRequest req = web::WebRequest();
  matjson::Value inputJson = input;

  web::MultipartForm form;
  form.param("metadata", inputJson.dump(matjson::NO_INDENTATION));
  for (const std::vector<uint8_t>& submissionData : submissions) {
    form.file("submissions", submissionData, "submission", "application/octet-stream");
  }

  req.bodyMultipart(form);
  req.header("Content-Type", form.getHeader());

  req.timeout(std::chrono::seconds(5));

  return req.post(APIManager::get().getEndpoint("v3/submit"))
      .map(
          [](web::WebResponse *result) -> UploadSubmissionsTask::Value {
            if (result->ok()) {
                return Ok();
            }
            return Err("Not submitted with code {}.", result->code());
          },
          [](web::WebProgress *progress)
              -> UploadSubmissionsTask::Progress {
            auto p = progress->downloadProgress();
            if (p.has_value()) {
              return p.value();
            } else {
              return 0.f;
            }
          });
}
