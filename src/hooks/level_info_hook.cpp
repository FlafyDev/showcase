#include "../includes/geode.hpp"
#include "../managers/api_manager.hpp"
#include "../managers/interferences_manager.hpp"
#include "../managers/replay_manager.hpp"
#include "../tasks/get_level_replay_status.hpp"
#include "../tasks/get_replay.hpp"
#include "Geode/loader/Loader.hpp"
#include <dashauth.hpp>
#include <optional>

struct SBLevelInfoLayer : geode::Modify<SBLevelInfoLayer, LevelInfoLayer> {
  struct Fields {
    EventListener<GetLevelReplayStatusTask> m_getLevelReplayStatusTaskListener;
    EventListener<GetReplayTask> m_getReplayListener;
    CCMenuItemSpriteExtra *m_clapperBtn;
    std::optional<LevelReplayStatus> m_levelReplayStatus;
    std::optional<ShowcaseBotReplay> m_replay;
  };

  bool init(GJGameLevel *level, bool challenge) {
    if (!LevelInfoLayer::init(level, challenge)) {
      return false;
    }

    NodeIDs::provideFor(this);

    auto playMenu = static_cast<CCMenu *>(this->getChildByID("play-menu"));

    if (playMenu == nullptr) {
      log::debug("play menu not found!");
      return true;
    }

    APIManager::get().tryUpload();

    auto sprite = CircleButtonSprite::createWithSprite("clapper.png"_spr);

    sprite->setScale(0.5f);

    auto btn = CCMenuItemSpriteExtra::create(
        sprite, this, menu_selector(SBLevelInfoLayer::onButton));
    m_fields->m_clapperBtn = btn;
    btn->setID("play-replay-button");
    btn->setPosition({27.f, 27.f});
    btn->setZOrder(-2);
    btn->setVisible(false);
    CCMenu *menu = CCMenu::create();
    menu->setTouchPriority(playMenu->getTouchPriority() - 1);
    menu->setPosition(playMenu->getPosition());
    menu->setContentSize(playMenu->getContentSize());
    menu->setAnchorPoint(playMenu->getAnchorPoint());
    menu->setZOrder(playMenu->getZOrder() + 1);
    menu->addChild(btn);
    this->addChild(menu);

    bool eligible = InterferencesManager::isLevelEligible(m_level);

    m_fields->m_getLevelReplayStatusTaskListener.bind(
        [this](GetLevelReplayStatusTask::Event *event) {
          if (GetLevelReplayStatusTask::Value *result = event->getValue()) {
            if (result->isErr())
              return;
            m_fields->m_levelReplayStatus = result->ok();
            queueInMainThread([this] { updateButtonVisibility(); });
          }
        });

    m_fields->m_getReplayListener.bind([this](GetReplayTask::Event *event) {
      if (GetReplayTask::Value *result = event->getValue()) {
        if (result->isErr())
          return;
        m_fields->m_replay = result->unwrap();
        queueInMainThread([this] {
          updateButtonVisibility();
          playReplay();
        });
      }
    });

    if (eligible) {
      m_fields->m_getLevelReplayStatusTaskListener.setFilter(
          getLevelReplayStatus({
              m_level->m_levelID,
              m_level->m_levelVersion,
              GEODE_GD_VERSION_STRING,
              Mod::get()->getVersion().toVString(),
              APIManager::get().getDashAuthToken(),
          }));
    }

    return true;
  }

  void updateButtonVisibility() {
    if (m_fields->m_levelReplayStatus &&
        m_fields->m_levelReplayStatus->replayID) {
      m_fields->m_clapperBtn->setVisible(true);
    }
  }

  void onButton(CCObject *sender) {
    if (!m_fields->m_levelReplayStatus &&
        m_fields->m_levelReplayStatus->replayID.has_value())
      return;

    if (m_fields->m_replay.has_value()) {
      playReplay();
    }

    m_fields->m_getReplayListener.setFilter(getReplay(
        GetReplayInput{m_fields->m_levelReplayStatus->replayID.value()}));
  }

  void playReplay() {
    if (!m_fields->m_replay.has_value()) {
      return;
    }
    ReplayManager::get().startReplay(m_fields->m_replay.value());
    this->onPlay(nullptr);
  }

  void onBack(CCObject *sender) {
    ReplayManager::get().stopReplay();
    LevelInfoLayer::onBack(sender);
  }
};