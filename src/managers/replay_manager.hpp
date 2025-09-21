#pragma once

#include "../includes/geode.hpp"
#include "../includes/showcase_bot.hpp"

class ReplayManager {
protected:
  ReplayManager() = default;
  ReplayManager(const ReplayManager &) = delete;
  ReplayManager(ReplayManager &&) = delete;

  ReplayManager &operator=(const ReplayManager &) = delete;
  ReplayManager &operator=(ReplayManager &&) = delete;

  bool m_initialized = false;
  std::optional<ShowcaseBotReplay> m_replay = std::nullopt;

public:
  bool init();

  void startReplay(const ShowcaseBotReplay &replay);
  bool isReplayActive();
  void stopReplay();
  const std::vector<gdr::Input<>> getInputs(int frame);
  std::optional<int> getReplayLevel();

  static ReplayManager &get() {
    static ReplayManager instance;
    return instance;
  }
};
