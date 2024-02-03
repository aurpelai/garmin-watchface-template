import Toybox.Lang;
import Toybox.Time;

class CurrentTimeController {
  public function getValue() as String {
    return Utils.Time.getFormattedTimeFromMoment(Time.now());
  }
}
