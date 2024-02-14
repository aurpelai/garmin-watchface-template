import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class LegacyStepsController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Numeric {
    return Utils.Conversion.progressToAngle(
      Utils.Steps.getStepProgress(ActivityMonitor.getInfo().steps),
      {
        :min => Constants.Value.DEFAULT_MIN_PROGRESS,
        :max => Constants.Value.DEFAULT_MAX_PROGRESS,
      }
    );
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.StepsLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.StepsLabel) as String;
  }

  public function getProgress() as Numeric? {
    return Utils.Steps.getStepProgress(ActivityMonitor.getInfo().steps);
  }

  public function getValue() as String or Numeric {
    var current = ActivityMonitor.getInfo().steps;

    if (current == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return current;
  }
}
