import Toybox.ActivityMonitor;
import Toybox.Lang;

module Utils {
  module Steps {
    // Gets the user's step progress as percentage
    // @return Number or null
    function getStepProgress(current as Number?) as Number? {
      var target = ActivityMonitor.getInfo()[:stepGoal] as Number?;

      if (current == null || target == null) {
        return null;
      }

      return (100 * current) / target;
    }
  }
}
