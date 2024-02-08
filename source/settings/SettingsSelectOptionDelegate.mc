import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsSelectOptionDelegate extends WatchUi.Menu2InputDelegate {
  hidden var propertyKey as String;

  function initialize(id as String) {
    propertyKey = id;
    Menu2InputDelegate.initialize();
  }

  function onSelect(item as WatchUi.MenuItem) {
    var id = item.getId();

    if (id == null) {
      return;
    }

    Application.Properties.setValue(propertyKey, Application.Properties.getValue(id.toString()));
    onBack();
  }

  function onBack() {
    WatchUi.popView(WatchUi.SLIDE_RIGHT);
  }
}
