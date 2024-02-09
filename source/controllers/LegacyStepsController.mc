import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class LegacyStepsController {
  function getLabel() as String {
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
