import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

module Utils {
  module Complications {
    var gCallbacks as
    Dictionary<Complications.Id, (Method(complicationId as Complications.Id) as Void)> = {};

    var gUsedComplications as Array<Complications.Type> = [
      Complications.COMPLICATION_TYPE_CALORIES,
      Complications.COMPLICATION_TYPE_STEPS,
    ];

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
      callback as (Method(complicationId as Complications.Id) as Void)
    ) as Void {
      var app = Application.getApp();
      if (app has :mCallbacks) {
        app.mCallbacks.put(complicationId.getType(), callback);
      }
    }
  }
}
