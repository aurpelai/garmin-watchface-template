import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsView extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize({
      :title => Application.loadResource(Rez.Strings.SettingsLabel) as String
    });

    var menuItems = [
      {
        :id => "DisplaySecondsInCurrentTime",
        :label => Application.loadResource(Rez.Strings.DisplaySecondsInCurrentTime) as String,
        :type => Types.MENU_ITEM_TOGGLE,
      },
    ] as Array<Types.MenuItemParams>;

    for (var i = 0; i < menuItems.size(); i++) {
      var menuItem = Utils.Settings.generateToggleMenuItem(menuItems[i][:id] as String, menuItems[i][:label] as String) as WatchUi.MenuItem;
      Menu2.addItem(menuItem);
    }
  }
}
