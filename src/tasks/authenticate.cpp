#include "authenticate.hpp"
#include "../managers/api_manager.hpp"
#include <dashauth.hpp>

AuthenticateTask authenticateTask(const std::optional<std::string> token) {
  if (GJAccountManager::sharedState()->m_accountID == 0) {
    co_return Err("No GD account logged in.");
  }

  if (token.has_value() && !token->empty()) {
    web::WebRequest req = web::WebRequest();

    req.bodyString(token.value());

    req.timeout(std::chrono::seconds(5));

    auto response =
        co_await req.get(APIManager::get().getEndpoint("v3/checkToken"));
    int responseCode = response.code();
    if (responseCode == 200) {
      co_return Ok(token.value());
    } else if (responseCode != 401) {
      co_return Err("Unexpected response code from server.");
    }
  }

  co_return co_await AuthenticateTask::runWithCallback(
      [](auto finish, auto progress, auto hasBeenCancelled) {
        dashauth::DashAuthRequest()
            .getToken(Mod::get(),
                      APIManager::get().getEndpoint("v3/dashAuth/api/v1"))
            ->except(
                [finish](const std::string &reason) { finish(Err(reason)); })
            ->then([finish](const std::string &token) {
              if (token == "uh oh") { // TODO: Why is it like this...
                finish(Err("Unknown authentication failure."));
                return;
              }
              log::info("got DashAuth token from server.");
              finish(Ok(token));
            });
      });
}
