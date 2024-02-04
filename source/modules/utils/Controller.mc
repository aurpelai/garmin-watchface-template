import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

module Utils {
  module Controller {
    function getController(controller as Controllers.Identifier) as Types.Controller {
      switch (controller) {
        case Controllers.BLUETOOTH_STATUS:
          return new BluetoothStatusController();
        case Controllers.CALORIES:
          return new CaloriesController();
        case Controllers.CURRENT_TIME:
          return new CurrentTimeController();
        case Controllers.SECONDS:
          return new SecondsController();
        case Controllers.STEPS:
          return new StepsController();
        default:
          throw new Exceptions.InvalidControllerIdentifierException(controller as String);
      }
    }

    function shouldUpdate(lastUpdate as Time.Moment, updateInterval as Time.Duration) as Boolean {
      var nextUpdate = lastUpdate.add(updateInterval);
      return Time.now().greaterThan(nextUpdate);
    }
  }
}
