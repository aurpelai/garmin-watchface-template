import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Lang;

class LegacyCaloriesController {
  function getLabel() as String {
    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  function getUnit() as String {
    return Application.loadResource(Rez.Strings.CaloriesUnit) as String;
  }

  function getValue() as String {
    var calories = ActivityMonitor.getInfo().calories;

    if (calories == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return calories.format("%i");
  }
}
