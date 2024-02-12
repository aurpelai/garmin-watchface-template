import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class LegacyStepsController extends BaseController {
  function initialize() {
    BaseController.initialize();
  }

  public function getAngle() as Numeric {
    var stepsInfo = Utils.Data.getStepsInfo();
    return Utils.Controller.getAngleByProgress(stepsInfo[0], stepsInfo[1]);
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.StepsLabel) as String;
  }

  public function getProgress() as Numeric? {
    var stepsInfo = Utils.Data.getStepsInfo();
    return (1.0 * stepsInfo[0]) / stepsInfo[1];
  }

  public function getValue() as String or Numeric {
    var stepCount = ActivityMonitor.getInfo().steps;

    if (stepCount == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return stepCount;
  }
}
