#pragma once
#include "recorder.hpp"

class SecureRecorder : public IRecorder {
public:
    void onStartLevel(int levelID, int levelVersion,
                      const std::string &modVersion,
                      const std::string &gdVersion) override;

    void onInput(int frame, bool down, int button, bool player1) override;

    void onReset(int frame) override;

    void onComplete() override;
};

