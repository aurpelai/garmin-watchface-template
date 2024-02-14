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
    return Application.loadResource(Rez.Strings.StepsLabel) as String;
  }

  public function getProgress() as Numeric? {
    var stepsInfo = Utils.Data.getStepsInfo();
    return (1.0 * stepsInfo[0]) / stepsInfo[1];
  }

  public function getValue() as String or Numeric {
    var stepsInfo = Utils.Data.getStepsInfo();
    return stepsInfo[0];
  }
}
