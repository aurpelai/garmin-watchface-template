import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsView extends WatchUi.Menu2 {
  function initialize() {
    Menu2.initialize({ :title => Rez.Strings.SettingsTitle });
    generateMenuItems();
  }

  hidden const MENU_ITEMS =
    [
      {
        :id => "ShortLabelsSetting",
        :label => Rez.Strings.ShortLabelsSettingKey,
        :type => Types.Settings.TOGGLE_MENU_ITEM,
      },
      {
        :id => "HideUnitsSetting",
        :label => Rez.Strings.HideUnitsSettingKey,
        :type => Types.Settings.TOGGLE_MENU_ITEM,
      },
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

  hidden function generateMenuItems() as Void {
    for (var i = 0; i < MENU_ITEMS.size(); i++) {
      switch (MENU_ITEMS[i][:type] as Types.Settings.PropertyType) {
        case Types.Settings.TOGGLE_MENU_ITEM:
          Menu2.addItem(
            new WatchUi.ToggleMenuItem(
              MENU_ITEMS[i][:label] as Symbol,
              null,
              MENU_ITEMS[i][:id] as String,
              Application.Properties.getValue(MENU_ITEMS[i][:id] as String) as Boolean,
              null
            )
          );
          break;
        default:
          Menu2.addItem(
            new WatchUi.MenuItem(
              MENU_ITEMS[i][:label] as Symbol,
              null,
              MENU_ITEMS[i][:id] as String,
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

    if (
      value == null ||
      value < (Application.Properties.getValue("UpdateIntervalEverySecond") as Number)
    ) {
      return null;
    }

    switch (value) {
      case Application.Properties.getValue("UpdateIntervalEvery30Seconds"):
        return Rez.Strings.UpdateIntervalSettingValueEvery30Seconds;
      case Application.Properties.getValue("UpdateIntervalEvery15Seconds"):
        return Rez.Strings.UpdateIntervalSettingValueEvery15Seconds;
      case Application.Properties.getValue("UpdateIntervalEvery5Seconds"):
        return Rez.Strings.UpdateIntervalSettingValueEvery5Seconds;
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
