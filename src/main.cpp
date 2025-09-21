#include "managers/api_manager.hpp"
#include "managers/crash_log_manager.hpp"
#include "managers/interferences_manager.hpp"
#include "managers/recorder_manager.hpp"
#include "managers/replay_manager.hpp"

$execute {
  CrashLogManager::get().init();
  InterferencesManager::get().init();
  RecorderManager::get().init();
  ReplayManager::get().init();
  APIManager::get().init();
}