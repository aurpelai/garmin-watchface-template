import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class SecondsController {

  public function getAngle() as Numeric {
    return Utils.Controller.getAngleByProgress(System.getClockTime().sec, 60);
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.SecondsLabel) as String;
  }

  public function getUnit() as String {
    return "";
  }

  public function getValue() as String {
    return System.getClockTime().sec.toString();
  }

  public function shouldDraw() as Boolean {
    return Application.Storage.getValue("HighPowerMode") as Boolean;
  }
}
