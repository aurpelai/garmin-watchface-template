import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

class SecondsController {
  public function getAngle() as Number {
    // The additive inverse of the angle makes our indicator travel in the correct direction.
    var STEP_ANGLE = -360 / 60.0; // A one-second-wide angle

    var seconds = System.getClockTime().sec;

    // Make sure the position value adheres to the dc.drawArc() specs so that our
    // indicator is positioned correctly:
    //     0 deg:  3 o'clock.
    //    90 deg: 12 o'clock.
    //   180 deg:  9 o'clock.
    //   270 deg:  6 o'clock.
    //
    // The -270 degree offset assures that all angles are consistently negative.
    // This makes counting and handling the angles elsewhere more consistent.
    var angle = seconds * STEP_ANGLE - 270;

    return angle.toNumber();
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.SecondsLabel) as String;
  }

  public function getValue() as String {
    return System.getClockTime().sec.toString();
  }

  public function shouldDraw() as Boolean {
    return Application.Storage.getValue("HighPowerMode") as Boolean;
  }
}
