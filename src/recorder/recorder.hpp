#pragma once

class IRecorder {
public:
  virtual ~IRecorder() = default;
  IRecorder() = default;
  IRecorder(const IRecorder &) = delete;
  IRecorder(IRecorder &&) = delete;

  IRecorder &operator=(const IRecorder &) = delete;
  IRecorder &operator=(IRecorder &&) = delete;

  virtual void onStartLevel(int levelID, int levelVersion, bool isPlatformer,
                            const std::string &modVersion,
                            const std::string &gdVersion) = 0;

  virtual void onInput(int frame, bool down, int button, bool player1) = 0;

  virtual void onReset(int frame) = 0;

  virtual void onComplete() = 0;

  virtual void onStopLevel() = 0;
};
