import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Time;
import Toybox.UserProfile;

class LegacyCaloriesController extends BaseController {
  function initialize() {
    BaseController.initialize();
  }

  hidden function getCalorieTarget() as Numeric {
    var profile = UserProfile.getProfile();

    if (
      [profile.weight, profile.height, profile.birthYear, profile.activityClass].indexOf(null) >= 0
    ) {
      var ruleOfThumbDailyCalories = [2000, 2500, 2250] as Array<Number>;
      var gender = profile.gender != null ? profile.gender : 2;
      return ruleOfThumbDailyCalories[gender];
    }

    var bodyMetabolicRate =
      10 * ((profile.weight as Numeric) / 1000) +
      6.25 * (profile.height as Numeric) -
      5 * (Utils.Time.getCurrentYear() - (profile.birthYear as Numeric));

    var exerciseMultiplierClasses = [1.2, 1.375, 1.55, 1.725, 1.9] as Array<Numeric>;
    var index = Math.floor((profile.activityClass as Numeric) / 20.0).toNumber();

    var activeMetabolicRate = Math.round(bodyMetabolicRate * exerciseMultiplierClasses[index]);

    return activeMetabolicRate;
  }

  public function getAngle() as Numeric {
    return Utils.Controller.getAngleByProgress(
      ActivityMonitor.getInfo().calories,
      getCalorieTarget()
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

    return value / getCalorieTarget();
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
