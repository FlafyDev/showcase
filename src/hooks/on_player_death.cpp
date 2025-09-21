#include "../includes/geode.hpp"
#include "../managers/api_manager.hpp"
#include "../managers/interferences_manager.hpp"
#include "../tasks/report_death.hpp"

struct SCOnDeathPlayLayer : geode::Modify<SCOnDeathPlayLayer, PlayLayer> {
  struct Fields {
    EventListener<ReportDeathTask> reportDeathListener;
  };

  static void onModify(auto &self) {
    if (!self.setHookPriorityPost("PlayLayer::destroyPlayer", Priority::Late)) {
      geode::log::error(
          "Failed to set hook priority for PlayLayer::destroyPlayer.");
    }
  }

  bool init(GJGameLevel *level, bool useReplay, bool dontCreateObjects) {
    if (!PlayLayer::init(level, useReplay, dontCreateObjects))
      return false;

    m_fields->reportDeathListener.bind([this](ReportDeathTask::Event *event) {
      if (ReportDeathTask::Value *result = event->getValue()) {
        if (result->isErr())
          return;
      }
    });

    return true;
  }

  void destroyPlayer(PlayerObject *player, GameObject *object) {
    PlayLayer::destroyPlayer(player, object);

    if (object == m_anticheatSpike)
      return;

    if (!InterferencesManager::isLevelEligible(m_level))
      return;

    if (m_level->isPlatformer())
      return;

    int currentFrame = this->m_gameState.m_currentProgress;
    float currentPercent = getCurrentPercent();

    m_fields->reportDeathListener.setFilter(reportDeath({
        m_level->m_levelID,
        m_level->m_levelVersion,
        currentFrame,
        currentPercent,
        APIManager::get().getDashAuthToken(),
    }));
  }
};
