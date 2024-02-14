import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;

module Constants {
  module Colors {
    const ACCENT as Graphics.ColorValue = Graphics.COLOR_YELLOW;
    const ATTENTION as Graphics.ColorValue = Graphics.COLOR_RED;
    const ATTENTION_BACKGROUND as Graphics.ColorValue = Graphics.COLOR_DK_RED;
    const BACKGROUND as Graphics.ColorValue = Graphics.COLOR_BLACK;
    const GOLD as Number = 0xffeeaa;
    const PRIMARY as Graphics.ColorValue = Graphics.COLOR_WHITE;
    const SECONDARY as Graphics.ColorValue = Graphics.COLOR_LT_GRAY;
    const TERTIARY as Graphics.ColorValue = Graphics.COLOR_DK_GRAY;
  }

  module Fonts {
    const CURRENT_TIME_FONT as Graphics.FontDefinition = Graphics.FONT_NUMBER_MEDIUM;
    const LABEL_FONT as Graphics.FontDefinition = Graphics.FONT_XTINY;
    const UNIT_FONT as Graphics.FontDefinition = Graphics.FONT_XTINY;
    const VALUE_FONT as Graphics.FontDefinition = Graphics.FONT_TINY;
  }

  module Users {
    const ACTIVITY_CLASS_SEDENTARY = 1.2;
    const ACTIVITY_CLASS_LIGHTLY_ACTIVE = 1.375;
    const ACTIVITY_CLASS_MODERATELY_ACTIVE = 1.55;
    const ACTIVITY_CLASS_ACTIVE = 1.725;
    const ACTIVITY_CLASS_VERY_ACTIVE = 1.9;

    const DEFAULT_FEMALE_DAILY_CALORIES = 2000;
    const DEFAULT_GENERIC_DAILY_CALORIES = 2250;
    const DEFAULT_MALE_DAILY_CALORIES = 2500;

    const MALE_BMR_SCALING_VALUE = 5;
    const FEMALE_BMR_SCALING_VALUE = -161;
  }

  module Values {
    const DEFAULT_MIN_PROGRESS = 0;
    const DEFAULT_MAX_PROGRESS = 100;
    const PROGRESS_BAR_LABEL_VERTICAL_OFFSET = 4;

    const UPDATE_INTERVAL_UNLIMITED as Number = 1;
    const UPDATE_INTERVAL_REALLY_SHORT as Number = Time.Gregorian.SECONDS_PER_MINUTE / 12;
    const UPDATE_INTERVAL_SHORT as Number = Time.Gregorian.SECONDS_PER_MINUTE / 4;
    const UPDATE_INTERVAL_MEDIUM as Number = Time.Gregorian.SECONDS_PER_MINUTE / 2;
    const UPDATE_INTERVAL_LONG as Number = Time.Gregorian.SECONDS_PER_MINUTE;
    const UPDATE_INTERVAL_REALLY_LONG as Number = Time.Gregorian.SECONDS_PER_MINUTE * 5;
  }
}
