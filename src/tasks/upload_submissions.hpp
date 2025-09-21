#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <cstdint>
#include <optional>

struct UploadSubmissionsInput {
  const std::string token;
};

using UploadSubmissionsTask = Task<Result<>, float>;

template <> struct matjson::Serialize<UploadSubmissionsInput> {
  static matjson::Value toJson(const UploadSubmissionsInput &input) {
    return matjson::makeObject({
        {"token", input.token},
    });
  }
};

UploadSubmissionsTask uploadSubmissions(const UploadSubmissionsInput &input, const std::vector<std::vector<uint8_t>>& submissions);
