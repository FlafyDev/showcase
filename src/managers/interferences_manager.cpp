#include "interferences_manager.hpp"
#include "replay_manager.hpp"

bool InterferencesManager::init() {
  if (m_initialized) {
    return true;
  }

  auto _ = loadState();

  m_isEnabled = true;
  toggle(false);

  m_initialized = true;
  return true;
}

Result<> InterferencesManager::saveState() {
  Mod::get()->setSavedValue("interferencesState", m_interferenceStates);

  return Ok();
}

Result<> InterferencesManager::loadState() {
  m_interferenceStates =
      Mod::get()->getSavedValue<std::unordered_map<std::string, bool>>(
          "interferencesState", {});

  return Ok();
}

void InterferencesManager::handleInterference(
    const std::string &id, bool disableInterference,
    std::function<bool()> isEnabledFn, std::function<void(bool)> setEnabledFn) {
  if (disableInterference) {
    if (m_interferenceStates.contains(id)) {
      return;
    }

    bool originallyEnabled = isEnabledFn();
    if (!originallyEnabled) {
      return;
    }
    m_interferenceStates[id] = originallyEnabled;
    log::debug("Changing {}'s state to false.", id);
    setEnabledFn(false);
  } else {
    if (!m_interferenceStates.contains(id)) {
      return;
    }

    bool originallyEnabled = m_interferenceStates[id];

    m_interferenceStates.erase(id);
    log::debug("Restoring {}'s state to {}.", id,
              originallyEnabled ? "true" : "false");
    setEnabledFn(originallyEnabled);
  }
}

void InterferencesManager::toggle(bool enable) {
  if (m_isEnabled == enable)
    return;
  m_isEnabled = enable;

  Mod *cbf =
      geode::Loader::get()->getInstalledMod("syzzi.click_between_frames");
  if (cbf) {
    handleInterference(
        "cbf", enable,
        [cbf]() { return !cbf->getSettingValue<bool>("soft-toggle"); },
        [cbf](bool enabled) {
          cbf->setSettingValue<bool>("soft-toggle", !enabled);
        });
  }

  // TODO: Add Click on Steps mod

  if (!enable) {
    m_interferenceStates.clear();
  }

  Result<> _ = saveState();
}

bool InterferencesManager::shouldRecordGameplay() {
  if (ReplayManager::get().isReplayActive()) {
    return false;
  }

  Mod *cbf = geode::Loader::get()->getLoadedMod("syzzi.click_between_frames");
  if (cbf && !cbf->getSettingValue<bool>("soft-toggle")) {
    return false;
  }

  return true;
}

bool InterferencesManager::isLevelEligible(GJGameLevel *level) {
  if (level == nullptr) {
    return false;
  }

  std::optional<int> stars = level->m_stars.value() == 0
                                 ? std::nullopt
                                 : std::optional(level->m_stars.value());
  int downloads = level->m_downloads;

  bool isAuto = level->m_starsRequested == 1 || level->m_autoLevel ||
                (stars.has_value() && stars == 1);

  return !isAuto && level->m_levelID.value() >= 4000 &&
         (stars.has_value() || downloads >= 4000);
}