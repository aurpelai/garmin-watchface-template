import Toybox.ActivityMonitor;
import Toybox.Lang;

module Utils {
  module Steps {
    // Gets the user's step progress as percentage
    // @return Numeric or null
    function getStepProgress(current as Number?) as Numeric? {
      var target = ActivityMonitor.getInfo()[:stepGoal];

      if (current == null || target == null) {
        return null;
      }

      return (1.0 * current) / target;
    }
  }
}
