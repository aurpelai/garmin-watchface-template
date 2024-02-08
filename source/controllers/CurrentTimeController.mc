import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

class CurrentTimeController {
  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.CurrentTimeLabel) as String;
  }

  public function getValue() as String {
    var options =
      ({
        :showSeconds => Application.Properties.getValue("ShowSecondsSetting") as Boolean,
      }) as Types.Utils.FormatTimeOptions;

    return Utils.Time.getFormattedTimeFromMoment(Time.now(), options);
  }
}
