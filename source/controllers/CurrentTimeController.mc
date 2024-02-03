import Toybox.Lang;
import Toybox.Time;

class CurrentTimeController {
  public function getValue() as String {
    var options = {
      :showSeconds => true,
    };

    return Utils.Time.getFormattedTimeFromMoment(Time.now(), options);
  }
}
