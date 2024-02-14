import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

module Utils {
  module Complications {
    function hasComplicationSupport() as Boolean {
      if (
        Toybox has :Complications &&
        Toybox.Complications has :registerComplicationChangeCallback
      ) {
        return true;
      }

      return false;
    }

    function registerToComplicationChangeCallback(
      type as Complications.Type,
      callback as Types.Controllers.ComplicationUpdater
    ) as Void {
      if (gCallbacks.hasKey(type)) {
        return;
      }

      gCallbacks.put(type, callback);
    }

    function getUnitFromEnum(value as Complications.Unit or String or Null) as String? {
      if (value == null) {
        return Application.loadResource(Rez.Strings.UnknownUnit) as String;
      }

      if (value instanceof Lang.String) {
        return value;
      }

      var units =
        [
          Rez.Strings.UnknownUnit,
          Rez.Strings.DistanceUnit,
          Rez.Strings.ElevationUnit,
          Rez.Strings.HeightUnit,
          Rez.Strings.SpeedUnit,
          Rez.Strings.TemperatureUnit,
          Rez.Strings.WeightUnit,
        ] as Array<Symbol>;

      return Application.loadResource(units[value as Number]) as String;
    }
  }
}
