#include "unsecure_recorder.hpp"
#include "../managers/api_manager.hpp"
#include "Geode/loader/Log.hpp"
#include <optional>
#include <random>

void UnsecureRecorder::onStartLevel(int levelID, int levelVersion,
                                    bool isPlatformer,
                                    const std::string &modVersion,
                                    const std::string &gdVersion) {
  log::info("Starting an unsecure recording.");
  replay = ShowcaseBotReplay();
  replay->levelInfo.id = levelID;
  replay->levelVersion = levelVersion;
  replay->modVersion = modVersion;
  replay->gdVersion = gdVersion;
  replay->platformer = isPlatformer;
}

void UnsecureRecorder::onInput(int frame, bool down, int button, bool player1) {
  if (!replay.has_value()) {
    return;
  }
  if (button < 0 || button > 3) {
    return;
  }
  replay->inputs.push_back(gdr::Input<>(frame, button, !player1, down));
}

void removeKeysSinceFrame(ShowcaseBotReplay &replay, int frame) noexcept {
  for (auto it = replay.inputs.begin(); it != replay.inputs.end();) {
    if (it->frame >= frame) {
      it = replay.inputs.erase(it);
    } else {
      ++it;
    }
  }
}

void UnsecureRecorder::onReset(int frame) {
  if (!replay.has_value()) {
    return;
  }

  if (frame < 2) {
    replay->inputs.clear();
    return;
  }

  removeKeysSinceFrame(replay.value(), frame + 1);

  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Jump, false, false));
  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Jump, true, false));
  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Left, false, false));
  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Left, true, false));
  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Right, false, false));
  replay->inputs.push_back(
      gdr::Input<>(frame + 1, (int)PlayerButton::Right, true, false));
}

void UnsecureRecorder::onComplete() {
  if (!replay.has_value()) {
    return;
  }

  const std::string fileName = std::to_string(std::random_device{}()) + ".gdr2.unsecured";

  const std::filesystem::path &uploadDir = APIManager::get().getUploadDir();

  std::error_code ec;

  if (!std::filesystem::exists(uploadDir, ec)) {
    if (ec)
      return;
    if (!std::filesystem::create_directories(uploadDir, ec) || ec)
      return;
  }

  auto exportResult = replay->exportData(uploadDir / fileName);
  if (exportResult.isErr()) {
    log::error("Error while saving GDR2: {}", exportResult.unwrapErr());
    return;
  }

  replay = std::nullopt;
}

void UnsecureRecorder::onStopLevel() {
  if (!replay.has_value()) {
    return;
  }

  replay = std::nullopt;
}