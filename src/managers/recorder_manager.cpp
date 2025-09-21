#include "recorder_manager.hpp"
#include "../recorder/unsecure_recorder.hpp"
#include "interferences_manager.hpp"

bool RecorderManager::init() {
  if (m_initialized) {
    return true;
  }

  m_recorder = std::make_unique<UnsecureRecorder>();

  return true;
}

std::optional<std::reference_wrapper<IRecorder>>
RecorderManager::getRecorder() const {
  if (m_recorder) {
    return std::ref(*m_recorder);
  }
  return std::nullopt;
}

struct SCRecorderBaseGameLayer
    : geode::Modify<SCRecorderBaseGameLayer, GJBaseGameLayer> {
  void destructor() {
    GJBaseGameLayer::~GJBaseGameLayer();

    if (auto recorder = RecorderManager::get().getRecorder()) {
      recorder->get().onStopLevel();
    }
  }

  void handleButton(bool down, int button, bool player1) {
    if (auto recorder = RecorderManager::get().getRecorder()) {
      recorder->get().onInput(this->m_gameState.m_currentProgress, down, button,
                              player1);
    }

    GJBaseGameLayer::handleButton(down, button, player1);
  }
};

struct SCRecorderPlayLayer : geode::Modify<SCRecorderPlayLayer, PlayLayer> {
  bool init(GJGameLevel *level, bool useReplay, bool dontCreateObjects) {
    if (!PlayLayer::init(level, useReplay, dontCreateObjects))
      return false;

    bool eligible = InterferencesManager::isLevelEligible(m_level);

    if (eligible && InterferencesManager::get().shouldRecordGameplay()) {
      if (auto recorder = RecorderManager::get().getRecorder()) {
        recorder->get().onStartLevel(
            m_level->m_levelID.value(), m_level->m_levelVersion,
            m_level->isPlatformer(), Mod::get()->getVersion().toVString(),
            GEODE_GD_VERSION_STRING);
      }
    }

    return true;
  }

  void levelComplete() {
    if (auto recorder = RecorderManager::get().getRecorder()) {
      recorder->get().onComplete();
    }

    PlayLayer::levelComplete();
  }

  void resetLevel() {
    PlayLayer::resetLevel();

    if (auto recorder = RecorderManager::get().getRecorder()) {
      recorder->get().onReset(this->m_gameState.m_currentProgress);
    }
  }
};
