import Toybox.Time;
import Toybox.Lang;

module Utils {
  module Component {
    function getUpdateInterval(updateInterval as Number?) as Time.Duration {
      var duration =
        updateInterval != null && updateInterval > 0
          ? new Time.Duration(updateInterval - 1)
          : new Time.Duration(0);

      return duration;
    }
  }
}
