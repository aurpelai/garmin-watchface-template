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
      callback as (Method(complicationId as Complications.Id) as Void)
    ) as Void {
      Complications.registerComplicationChangeCallback(callback);
      Complications.subscribeToUpdates(new Complications.Id(type));
    }
  }
}
