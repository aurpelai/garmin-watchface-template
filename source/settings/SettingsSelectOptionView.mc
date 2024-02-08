import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SettingsSelectOptionView extends WatchUi.Menu2 {
  hidden var propertyKey as String;

  function initialize(id as String, title as Symbol) {
    propertyKey = id;
    Menu2.initialize({ :title => title });
  }

  hidden function isSelected(id as String) as Boolean {
    var value = Application.Properties.getValue(id);
    var selected = Application.Properties.getValue(propertyKey);

    if (selected == null || value == null) {
      return false;
    }

    return value.equals(selected);
  }

  hidden function getSelectedSubLabel(id as String) as Symbol? {
    var subLabel = isSelected(id) ? Rez.Strings.ValueSelected : null;

    return subLabel;
  }

  hidden function addOption(id as String, label as Symbol) as Void {
    Menu2.addItem(new WatchUi.MenuItem(label, getSelectedSubLabel(id), id, null));
  }

  hidden function focusCurrentlySelected(
    options as Array<Types.Settings.SettingPropertyOption>
  ) as Void {
    for (var i = 0; i < options.size(); i++) {
      var id = options[i][:id] as String;
      var selectedValue = Application.Properties.getValue(propertyKey);

      if (selectedValue == null) {
        return;
      }

      if (selectedValue.equals(Application.Properties.getValue(id))) {
        Menu2.setFocus(i);
        return;
      }
    }
  }

  hidden function addUpdateIntervalOptions() as Void {
    var options =
      [
        {
          :id => "UpdateIntervalEverySecond",
          :label => Rez.Strings.UpdateIntervalSettingValueEverySecond,
        },
        {
          :id => "UpdateIntervalEvery15Seconds",
          :label => Rez.Strings.UpdateIntervalSettingValueEvery15Seconds,
        },
        {
          :id => "UpdateIntervalEvery30Seconds",
          :label => Rez.Strings.UpdateIntervalSettingValueEvery30Seconds,
        },
      ] as Array<Types.Settings.SettingPropertyOption>;

    for (var i = 0; i < options.size(); i++) {
      Menu2.addItem(
        new WatchUi.MenuItem(
          options[i][:label] as Symbol,
          getSelectedSubLabel(options[i][:id] as String),
          options[i][:id] as String,
          null
        )
      );
    }

    focusCurrentlySelected(options);
  }

  function onShow() {
    switch (propertyKey) {
      case "UpdateIntervalSetting":
        addUpdateIntervalOptions();
        break;
      default:
        throw new Exceptions.InvalidPropertyIdException(propertyKey);
    }
  }
}
