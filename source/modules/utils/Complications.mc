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
      callback as Types.Controllers.ComplicationCallbackFunction
    ) as Void {
      if (gCallbacks.hasKey(type)) {
        return;
      }

      gCallbacks.put(type, callback);
    }

    function getUnitByEnumValue(index as Complications.Unit?) as String? {
      if (index == null) {
        return Application.loadResource(Rez.Strings.UnknownUnit) as String;
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

      return Application.loadResource(units[index as Number]) as String;
    }
  }
}
