import Toybox.Application;
import Toybox.Lang;
import Toybox.System;

class LegacyBatteryController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Numeric {
    return Utils.Conversion.progressToAngle(100 - System.getSystemStats().battery, {
      :min => Constants.Value.DEFAULT_MIN_PROGRESS,
      :max => Constants.Value.DEFAULT_MAX_PROGRESS,
    });
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.BatteryLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.BatteryLabel) as String;
  }

  public function getProgress() as Numeric? {
    return System.getSystemStats().battery / 100.0;
  }

  public function getUnit() as String? {
    return Application.loadResource(Rez.Strings.PercentUnit) as String;
  }

  public function getValue() as String or Numeric {
    return System.getSystemStats().battery;
  }
}
