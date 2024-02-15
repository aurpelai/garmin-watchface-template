import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

module Utils {
  module Controller {
    function getController(
      controller as Types.Controllers.Id
    ) as Types.Controllers.EverythingController {
      switch (controller) {
        case Types.Controllers.BATTERY:
          return gIsLegacyDevice
            ? new LegacyBatteryController(controller)
            : new ComplicationsController(Complications.COMPLICATION_TYPE_BATTERY);
        case Types.Controllers.BLUETOOTH_STATUS:
          return new BluetoothStatusController(controller);
        case Types.Controllers.CALORIES:
          return gIsLegacyDevice
            ? new LegacyCaloriesController(controller)
            : new ComplicationsController(Complications.COMPLICATION_TYPE_CALORIES);
        case Types.Controllers.CURRENT_TIME:
          return new CurrentTimeController(controller);
        case Types.Controllers.HEART_RATE:
          return gIsLegacyDevice
            ? new LegacyHeartRateController(controller)
            : new ComplicationsController(Complications.COMPLICATION_TYPE_HEART_RATE);
        case Types.Controllers.SECONDS:
          return new SecondsController(controller);
        case Types.Controllers.STEPS:
          return gIsLegacyDevice
            ? new LegacyStepsController(controller)
            : new ComplicationsController(Complications.COMPLICATION_TYPE_STEPS);
        default:
          throw new Exceptions.InvalidControllerIdException(controller);
      }
    }

    function isAllowedToUpdate() as Boolean {
      var divisor = Application.Properties.getValue("UpdateIntervalSetting") as Number?;

      // The user hasn't set a limit for update interval in watch face settings
      if (divisor == null || divisor <= 1) {
        return true;
      }

      if (System.getClockTime().sec % divisor == 0) {
        return true;
      }

      return false;
    }

    function shouldUpdate(
      lastUpdate as Time.Moment,
      updateInterval as Time.Duration,
      dismissUpdateIntervalSetting as Boolean
    ) as Boolean {
      if (gForceRedraw) {
        return true;
      }

      if (!dismissUpdateIntervalSetting && !isAllowedToUpdate()) {
        return false;
      }

      var nextUpdate = lastUpdate.add(updateInterval);
      return Time.now().greaterThan(nextUpdate);
    }
  }
}
