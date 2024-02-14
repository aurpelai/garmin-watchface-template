import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;

module Utils {
  module Conversion {
    function progressToAngle(value as Numeric?, options as Types.Utils.MinMaxOptions) as Numeric {
      if (options[:min] == null) {
        throw new Exceptions.MissingDictionaryValueException("MinMaxOptions", ":min");
      }

      if (options[:max] == null) {
        throw new Exceptions.MissingDictionaryValueException("MinMaxOptions", ":max");
      }

      // The additive inverse of the angle makes our indicator travel in the correct direction.
      var STEP_ANGLE = -360.0 / ((options[:max] as Number) - (options[:min] as Number));

      if (value == null) {
        value = 0;
      }

      // Make sure the position value adheres to the dc.drawArc() specs so that our
      // indicator is positioned correctly:
      //     0 deg:  3 o'clock.
      //    90 deg: 12 o'clock.
      //   180 deg:  9 o'clock.
      //   270 deg:  6 o'clock.
      //
      // The -270 degree offset assures that all angles are consistently negative.
      // This makes counting and handling the angles elsewhere more consistent.
      var angle = value * STEP_ANGLE - 270;

      return angle;
    }

    function valueToKilos(value as Numeric) as Numeric {
      return value / 1000.0;
    }
  }
}
