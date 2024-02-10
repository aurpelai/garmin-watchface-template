import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Lang;

class LegacyCaloriesController extends BaseController {
  function initialize() {
    BaseController.initialize();
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  public function getUnit() as String? {
    return Application.loadResource(Rez.Strings.EnergyUnit) as String;
  }

  public function getValue() as String or Number {
    var calories = ActivityMonitor.getInfo().calories;

    if (calories == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return calories;
  }
}
