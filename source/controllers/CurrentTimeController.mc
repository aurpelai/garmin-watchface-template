import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

class CurrentTimeController {
  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.CurrentTimeLabel) as String;
  }

  public function getValue() as String {
    var options = {
      :showSeconds => Application.Properties.getValue("DisplaySecondsInCurrentTime") as Boolean,
    };

    return Utils.Time.getFormattedTimeFromMoment(Time.now(), options);
  }
}
