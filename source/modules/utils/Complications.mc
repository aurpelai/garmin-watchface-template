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
      complicationId as Complications.Id,
      callback as Types.ComplicationCallbackFunction
    ) as Void {
      var app = Application.getApp();

      if (app has :mCallbacks) {
        app.mCallbacks.put(complicationId.getType(), callback);
      }
    }
  }
}
