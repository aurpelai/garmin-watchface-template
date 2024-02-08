import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsDelegate extends WatchUi.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  hidden function toggleBooleanSetting(id as String) as Void {
    var prevState = Application.Properties.getValue(id) as Boolean;
    Application.Properties.setValue(id, !prevState);
  }

  hidden function openSubMenu(id as String, title as Symbol) as Void {
    WatchUi.pushView(
      new SettingsSelectOptionView(id, title),
      new SettingsSelectOptionDelegate(id),
      WatchUi.SLIDE_LEFT
    );
  }

  function onSelect(item as WatchUi.MenuItem) {
    var id = item.getId();

    if (id == null) {
      return;
    }

    switch (id) {
      case "UpdateIntervalSetting":
        openSubMenu(id.toString(), Rez.Strings.UpdateIntervalSettingKey);
        return;
      default:
        toggleBooleanSetting(id.toString());
        return;
    }
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_RIGHT);
  }
}
