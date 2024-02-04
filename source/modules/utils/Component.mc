import Toybox.Time;
import Toybox.Lang;

module Utils {
  module Component {
    function getComponentUpdateInterval(
      params as Types.ComponentParams
    ) as Time.Duration {
      return params[:updateInterval] != null
        ? new Time.Duration((params[:updateInterval] as Number) - 1)
        : new Time.Duration(0);
    }
  }
}
