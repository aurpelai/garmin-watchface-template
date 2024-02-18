import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

class CurrentTimeController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Number {
    var midnight = Time.today();
    var now = Time.now();
    var progress = now.subtract(midnight).value();

    return Utils.Conversion.progressToAngle(progress, {
      :min => Constants.Values.DEFAULT_MIN_PROGRESS,
      :max => Time.Gregorian.SECONDS_PER_DAY,
    });
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.CurrentTimeLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.CurrentTimeLabel) as String;
  }

  public function getProgress() as Number? {
    return System.getClockTime().hour / 24;
  }

  public function getValue() as String or Number {
    var options =
      ({
        :showSeconds => Application.Properties.getValue("ShowSecondsSetting") as Boolean,
      }) as Types.Utils.FormatTimeOptions;

    return Utils.Time.getFormattedTimeFromMoment(Time.now(), options);
  }
}
