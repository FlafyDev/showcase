#pragma once
#include "../includes/showcase_bot.hpp"
#include "recorder.hpp"

class UnsecureRecorder : public IRecorder {
private:
  std::optional<ShowcaseBotReplay> replay;

public:
  void onStartLevel(int levelID, int levelVersion, bool isPlatformer,
                    const std::string &modVersion,
                    const std::string &gdVersion) override;

  void onInput(int frame, bool down, int button, bool player1) override;

  void onReset(int frame) override;

  void onComplete() override;

  void onStopLevel() override;
};
