import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class LegacyStepsController extends BaseController {
  function initialize() {
    BaseController.initialize();
  }

  hidden function getStepsInfo() as Array<Numeric> {
    var info = ActivityMonitor.getInfo();
    var target = info[:stepGoal];
    var current = info[:steps];

    if (target == null || current == null) {
      return [0, 100] as Array<Numeric>;
    }

    return [current, target] as Array<Numeric>;
  }

  public function getAngle() as Numeric {
    var stepsInfo = getStepsInfo();

    if (stepsInfo.size() != 2) {
      throw new Exceptions.InvalidTupleSizeException(stepsInfo.size());
    }

    return Utils.Controller.getAngleByProgress(stepsInfo[0], stepsInfo[1]);
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.StepsLabel) as String;
  }

  public function getProgress() as Numeric? {
    var stepsInfo = getStepsInfo();

    if (stepsInfo.size() != 2) {
      throw new Exceptions.InvalidTupleSizeException(stepsInfo.size());
    }

    return (1.0 * stepsInfo[0]) / stepsInfo[1];
  }

  public function getValue() as String or Number {
    var stepCount = ActivityMonitor.getInfo().steps;

    if (stepCount == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return stepCount;
  }
}
