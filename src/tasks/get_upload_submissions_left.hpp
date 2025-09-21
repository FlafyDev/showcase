#pragma once
#include "../includes/geode.hpp"
#include <Geode/Result.hpp>
#include <Geode/utils/web.hpp>
#include <cstddef>
#include <optional>

struct UploadSubmissionsLeftResponse {
    int submissionsLeft;
};

struct GetUploadSubmissionsLeftInput {
    const std::string token;
};

using GetUploadSubmissionsLeftTask = Task<Result<UploadSubmissionsLeftResponse>, float>;

template <>
struct matjson::Serialize<UploadSubmissionsLeftResponse> {
    static geode::Result<UploadSubmissionsLeftResponse> fromJson(const matjson::Value& value) {
        GEODE_UNWRAP_INTO(int submissionsLeft, value["submissionsLeft"].asInt());
        return geode::Ok(UploadSubmissionsLeftResponse {
            submissionsLeft,
        });
    }
};

template <>
struct matjson::Serialize<GetUploadSubmissionsLeftInput> {
    static matjson::Value toJson(const GetUploadSubmissionsLeftInput& input) {
        return matjson::makeObject({
            { "token", input.token },
        });
    }
};

GetUploadSubmissionsLeftTask getUploadSubmissionsLeft(const GetUploadSubmissionsLeftInput& input);
