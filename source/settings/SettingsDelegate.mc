import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsDelegate extends WatchUi.Menu2InputDelegate {
  function initialize() {
    Menu2InputDelegate.initialize();
  }

  // Currently, this function only handles changes in boolean MenuItems
  function onSelect(item as WatchUi.MenuItem) {
    var itemId = item.getId() as String;
    var previousValue = Application.Properties.getValue(itemId) as Boolean;
    Application.Properties.setValue(itemId, !previousValue);
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_RIGHT);
  }
}
