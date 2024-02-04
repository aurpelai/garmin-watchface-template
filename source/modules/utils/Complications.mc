import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;

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
      callback as Types.ComplicationCallbackFunction
    ) as Void {
      if (gCallbacks.hasKey(type)) {
        return;
      }

      gCallbacks.put(type, callback);
    }
  }
}
