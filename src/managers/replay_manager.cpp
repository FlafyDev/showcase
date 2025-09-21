#include "replay_manager.hpp"
#include "interferences_manager.hpp"

bool ReplayManager::init() {
  if (m_initialized) {
    return true;
  }

  m_initialized = true;
  return true;
}

void ReplayManager::startReplay(const ShowcaseBotReplay &replay) {
  m_replay = replay; // Copy
  InterferencesManager::get().toggle(true);
}

bool ReplayManager::isReplayActive() { return m_replay.has_value(); }

std::optional<int> ReplayManager::getReplayLevel() {
  if (!m_replay.has_value()) {
    return 0;
  }

  return m_replay->levelInfo.id;
}

const std::vector<gdr::Input<>> ReplayManager::getInputs(int frame) {
  if (!m_replay.has_value()) {
    return {};
  }

  std::vector<gdr::Input<>> result;
  std::copy_if(this->m_replay->inputs.begin(), this->m_replay->inputs.end(),
               std::back_inserter(result), [frame](const gdr::Input<> &input) {
                 return input.frame == frame;
               });
  return result;
}

void ReplayManager::stopReplay() {
  m_replay = std::nullopt;
  InterferencesManager::get().toggle(false);
}

struct SCReplayBaseGameLayer
    : geode::Modify<SCReplayBaseGameLayer, GJBaseGameLayer> {
  void processCommands(float dt) {
    GJBaseGameLayer::processCommands(dt);

    if (ReplayManager::get().isReplayActive()) {
      int currentFrame = this->m_gameState.m_currentProgress;

      const std::vector<gdr::Input<>> inputs =
          ReplayManager::get().getInputs(currentFrame);
      for (const gdr::Input<> &input : inputs) {
        this->handleButton(input.down, static_cast<int>(input.button) + 60,
                           !input.player2);
      }
    }
  }

  bool init() {
    if (!GJBaseGameLayer::init())
      return false;

    return true;
  }

  void destructor() {
    GJBaseGameLayer::~GJBaseGameLayer();

    ReplayManager::get().stopReplay();
  }

  void handleButton(bool down, int button, bool player1) {
    if (ReplayManager::get().isReplayActive()) {
      if (button < 30) {
        return;
      }
      GJBaseGameLayer::handleButton(down, button - 30, player1);
      return;
    }
    log::debug("Input: down={}, button={}, player1={}", down, button, player1);

    GJBaseGameLayer::handleButton(down, button, player1);
  }
};

struct SCReplayPlayLayer : geode::Modify<SCReplayPlayLayer, PlayLayer> {
  // TODO test this
  void destroyPlayer(PlayerObject *player, GameObject *object) {
    if (object != m_anticheatSpike && ReplayManager::get().isReplayActive()) {
      PlayLayer::resetLevel();
      return;
    }

    PlayLayer::destroyPlayer(player, object);
  }

  void levelComplete() {
    if (ReplayManager::get().isReplayActive()) {
      PlayLayer::resetLevel();
      return;
    }

    PlayLayer::levelComplete();
  }

  void onQuit() {
    ReplayManager::get().stopReplay();

    PlayLayer::onQuit();
  }
};