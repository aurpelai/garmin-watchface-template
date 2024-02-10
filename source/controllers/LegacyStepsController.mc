import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class LegacyStepsController {
  public function getAngle() as Numeric {
    var info = ActivityMonitor.getInfo();
    var target = info[:stepGoal];
    var current = info[:steps];

    if (target == null || current == null) {
      return Utils.Controller.getAngleByProgress(0, 100);
    }

    return Utils.Controller.getAngleByProgress(current, target);
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.StepsLabel) as String;
  }

  function getUnit() as String {
    return "";
  }

  function getValue() as String {
    var stepCount = ActivityMonitor.getInfo().steps;

    if (stepCount == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return stepCount.format("%i");
  }
}
