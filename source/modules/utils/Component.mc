import Toybox.Time;
import Toybox.Lang;

module Utils {
  module Component {
    function getUpdateInterval(updateInterval as Number?) as Time.Duration {
      if (updateInterval == null || updateInterval <= 0) {
        return new Time.Duration(0);
      }

      return new Time.Duration(updateInterval - 1);
    }
  }
}
