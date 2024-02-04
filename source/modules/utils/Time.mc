import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

module Utils {
  module Time {
    // Return a formatted string representation of an hour, with a leading zero or not.
    // @param hours the current clock hour value
    // @return Hour value
    function formatHours(hours as Number) as String {
      var is12Hour = !System.getDeviceSettings().is24Hour;

      if (is12Hour) {
        if (hours > 12) {
          hours = hours - 12;
        } else if (hours == 0) {
          hours = 12;
        }
      }

      return hours.format("%02d");
    }

    // Return a string representation of a Moment
    // @param moment a Moment that is being considered
    // @return Formatted time string
    function getFormattedTimeFromMoment(
      moment as Time.Moment,
      options as Types.FormatTimeOptions
    ) as String {
      var momentInfo = Time.Gregorian.info(moment, Time.FORMAT_MEDIUM);

      var formattedTime = Lang.format("$1$:$2$", [
        formatHours(momentInfo.hour),
        momentInfo.min.format("%02d"),
      ]);

      if (options[:showSeconds]) {
        formattedTime += Lang.format(":$1$", [momentInfo.sec.format("%02d")]);
      }

      return formattedTime;
    }
  }
}
