import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class SecondsController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Number {
    return Utils.Conversion.progressToAngle(System.getClockTime().sec, {
      :min => Constants.Values.DEFAULT_MIN_PROGRESS,
      :max => Time.Gregorian.SECONDS_PER_MINUTE,
    });
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.SecondsLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.SecondsLabel) as String;
  }

  public function getProgress() as Number? {
    return (100 * System.getClockTime().sec) / Time.Gregorian.SECONDS_PER_MINUTE;
  }

  public function getValue() as String or Number {
    return System.getClockTime().sec;
  }

  public function shouldDraw() as Boolean {
    return Application.Storage.getValue("HighPowerMode") as Boolean;
  }
}
