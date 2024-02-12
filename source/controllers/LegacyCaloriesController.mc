import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Time;

class LegacyCaloriesController extends BaseController {
  function initialize() {
    BaseController.initialize();
  }

  public function getAngle() as Numeric {
    return Utils.Controller.getAngleByProgress(
      ActivityMonitor.getInfo().calories,
      Utils.Data.getCalorieTarget()
    );
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  public function getProgress() as Numeric? {
    var value = ActivityMonitor.getInfo().calories;

    if (value == null) {
      value = 0;
    }

    return value / Utils.Data.getCalorieTarget();
  }

  public function getUnit() as String? {
    return Application.loadResource(Rez.Strings.EnergyUnit) as String;
  }

  public function getValue() as String or Numeric {
    var calories = ActivityMonitor.getInfo().calories;

    if (calories == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return calories;
  }
}
