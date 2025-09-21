#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <cstdint>
#include <optional>

struct AuthenticateInput {
  std::string token;
};

using AuthenticateTask = Task<Result<std::string>, float>;

template <> struct matjson::Serialize<AuthenticateInput> {
  static matjson::Value toJson(const AuthenticateInput &input) {
    return matjson::makeObject({
        {"token", input.token},
    });
  }
};

AuthenticateTask authenticateTask(const std::optional<std::string> token);
