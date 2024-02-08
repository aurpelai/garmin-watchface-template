import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsView extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize({ :title => Rez.Strings.SettingsTitle });
    generateMenuItems();
  }

  hidden function generateMenuItems() as Void {
    var properties =
      [
        {
          :id => "ShowSecondsSetting",
          :label => Rez.Strings.ShowSecondsSettingKey,
          :type => Types.Settings.TOGGLE_MENU_ITEM,
        },
        {
          :id => "UpdateIntervalSetting",
          :label => Rez.Strings.UpdateIntervalSettingKey,
          :type => Types.Settings.MENU_ITEM,
        },
      ] as Array<Types.Settings.SettingProperty>;

    for (var i = 0; i < properties.size(); i++) {
      switch (properties[i][:type] as Types.Settings.PropertyType) {
        case Types.Settings.TOGGLE_MENU_ITEM:
          Menu2.addItem(
            new WatchUi.ToggleMenuItem(
              properties[i][:label] as Symbol,
              null,
              properties[i][:id] as String,
              Application.Properties.getValue(properties[i][:id] as String) as Boolean,
              null
            )
          );
          break;
        default:
          Menu2.addItem(
            new WatchUi.MenuItem(
              properties[i][:label] as Symbol,
              null,
              properties[i][:id] as String,
              null
            )
          );
      }
    }
  }

  hidden function updateSubLabel(
    id as String,
    callback as Types.Settings.SetSubLabelCallback
  ) as Void {
    var index = findItemById(id);

    if (index == -1) {
      return;
    }

    var menuItem = getItem(index) as MenuItem;
    var value = callback.invoke();

    if (value == null) {
      return;
    }

    menuItem.setSubLabel(value);
    updateItem(menuItem, index);
  }

  function getUpdateInterval() as Symbol? {
    var value = Application.Properties.getValue("UpdateIntervalSetting") as Number?;
    var MINIMUM_VALUE = Application.Properties.getValue("UpdateIntervalEverySecond") as Number;

    if (value == null || value < MINIMUM_VALUE) {
      return null;
    }

    switch (value) {
      case Application.Properties.getValue("UpdateIntervalEvery30Seconds"):
        return Rez.Strings.UpdateIntervalSettingValueEvery30Seconds;
      case Application.Properties.getValue("UpdateIntervalEvery15Seconds"):
        return Rez.Strings.UpdateIntervalSettingValueEvery15Seconds;
      case Application.Properties.getValue("UpdateIntervalEverySecond"):
        return Rez.Strings.UpdateIntervalSettingValueEverySecond;
      default:
        return Rez.Strings.Unknown;
    }
  }

  function onShow() {
    updateSubLabel("UpdateIntervalSetting", self.method(:getUpdateInterval));
  }
}
