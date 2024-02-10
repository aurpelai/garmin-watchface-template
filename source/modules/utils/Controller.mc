import Toybox.Application;
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
          throw new Exceptions.InvalidControllerIdException(controller);
      }
    }

    function getAngleByProgress(value as Numeric, target as Numeric) as Numeric {
      // The additive inverse of the angle makes our indicator travel in the correct direction.
      var STEP_ANGLE = -360.0 / target;

      // Make sure the position value adheres to the dc.drawArc() specs so that our
      // indicator is positioned correctly:
      //     0 deg:  3 o'clock.
      //    90 deg: 12 o'clock.
      //   180 deg:  9 o'clock.
      //   270 deg:  6 o'clock.
      //
      // The -270 degree offset assures that all angles are consistently negative.
      // This makes counting and handling the angles elsewhere more consistent.
      var angle = value * STEP_ANGLE - 270;

      return angle;
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
      if (!dismissUpdateIntervalSetting && !isAllowedToUpdate()) {
        return false;
      }

      var nextUpdate = lastUpdate.add(updateInterval);
      return Time.now().greaterThan(nextUpdate);
    }
  }
}
