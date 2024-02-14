import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Time;

class LegacyCaloriesController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Numeric {
    return Utils.Conversion.progressToAngle(ActivityMonitor.getInfo().calories, {
      :min => Constants.Value.DEFAULT_MIN_PROGRESS,
      :max => Utils.Energy.getCalorieTarget(),
    });
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.CaloriesLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  public function getProgress() as Numeric? {
    return Utils.Energy.getCalorieProgress(ActivityMonitor.getInfo().calories);
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
