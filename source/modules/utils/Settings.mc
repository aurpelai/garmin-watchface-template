import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module Utils {
  module Settings {
    function generateToggleMenuItem(id as String, label as String) as WatchUi.MenuItem {
      var item = new WatchUi.ToggleMenuItem(
        label,
        {
          :enabled => Application.loadResource(Rez.Strings.SettingsToggleEnabled) as String,
          :disabled => Application.loadResource(Rez.Strings.SettingsToggleDisabled) as String,
        },
        id,
        Application.Properties.getValue(id) as Boolean,
        null
      );

      return item;
    }
  }
}
