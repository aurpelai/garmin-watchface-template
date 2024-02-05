import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

module Utils {
  module Controller {
    function getController(
      controller as Types.Controllers.Id
    ) as Types.Controllers.LayoutController {
      switch (controller) {
        case Types.Controllers.BLUETOOTH_STATUS:
          return new BluetoothStatusController();
        case Types.Controllers.CALORIES:
          if (!gDeviceSupportsComplications) {
            return new LegacyCaloriesController();
          }
          return new ComplicationsController(Complications.COMPLICATION_TYPE_CALORIES);
        case Types.Controllers.CURRENT_TIME:
          return new CurrentTimeController();
        case Types.Controllers.SECONDS:
          return new SecondsController();
        case Types.Controllers.STEPS:
          if (!gDeviceSupportsComplications) {
            return new LegacyStepsController();
          }
          return new ComplicationsController(Complications.COMPLICATION_TYPE_STEPS);
        default:
          throw new Exceptions.InvalidIdentifierException(controller as String);
      }
    }

    function shouldUpdate(lastUpdate as Time.Moment, updateInterval as Time.Duration) as Boolean {
      var nextUpdate = lastUpdate.add(updateInterval);
      return Time.now().greaterThan(nextUpdate);
    }
  }
}
