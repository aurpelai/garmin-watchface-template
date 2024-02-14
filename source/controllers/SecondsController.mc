import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class SecondsController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Numeric {
    return Utils.Conversion.progressToAngle(System.getClockTime().sec, {
      :min => Constants.Value.DEFAULT_MIN_PROGRESS,
      :max => 60,
    });
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.SecondsLabel) as String;
  }

  public function getProgress() as Numeric? {
    return System.getClockTime().sec / 60.0;
  }

  public function getValue() as String or Numeric {
    return System.getClockTime().sec;
  }

  public function shouldDraw() as Boolean {
    return Application.Storage.getValue("HighPowerMode") as Boolean;
  }
}
