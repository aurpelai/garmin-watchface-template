import Toybox.Application;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Position;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Weather;

module Utils {
  module Time {
    //! Return a formatted string representation of an hour, with a leading zero or not.
    //! @param _hours the current clock hour value
    //! @return Hour value
    function formatHours(_hours as Number) as String {
      var is12Hour = !System.getDeviceSettings().is24Hour;
      var hours = _hours;

      if (is12Hour) {
        if (hours > 12) {
          hours = hours - 12;
        } else if (hours == 0) {
          hours = 12;
        }
      }

      return hours.format("%02d");
    }

    //! Return a string representation of a moment that might have a leading zero and/or a 12 hour label
    //! @param _moment a Moment that is being considered
    //! @param _show12HourLabel a boolean value to decide whether to show a 12 hour label or not
    //! @return Formatted time string
    function getFormattedTimeFromMoment(_moment as Time.Moment, _show12HourLabel as Boolean) as String {
      var momentInfo = Gregorian.info(_moment, Time.FORMAT_MEDIUM);
      var formattedTime = Lang.format(
        "$1$:$2$",
        [formatHours(momentInfo.hour), momentInfo.min.format("%02d")]
      );

      return formattedTime;
    }
  }
}
