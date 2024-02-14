import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.Math;
import Toybox.UserProfile;

module Utils {
  module Energy {
    function getActivityClassMultiplier(activityClass as Number) as Numeric {
      var exerciseMultiplierClasses =
        [
          Constants.Users.ACTIVITY_CLASS_SEDENTARY,
          Constants.Users.ACTIVITY_CLASS_LIGHTLY_ACTIVE,
          Constants.Users.ACTIVITY_CLASS_MODERATELY_ACTIVE,
          Constants.Users.ACTIVITY_CLASS_ACTIVE,
          Constants.Users.ACTIVITY_CLASS_VERY_ACTIVE,
        ] as Array<Numeric>;

      // We divide by 20 in order to normalize the 0-100 value provided by UserProfile.Profile.activityClass
      // into a value of 0-4 that matches the indices of the array exerciseMultiplierClasses.
      var index = Math.floor(activityClass / 20.0).toNumber();

      return exerciseMultiplierClasses[index];
    }

    function getCalorieTarget() as Number {
      var userProfile = UserProfile.getProfile();

      if (
        [
          userProfile.weight,
          userProfile.height,
          userProfile.birthYear,
          userProfile.activityClass,
        ].indexOf(null) >= 0
      ) {
        if (userProfile.gender == null) {
          return Constants.Users.DEFAULT_GENERIC_DAILY_CALORIES;
        }

        var ruleOfThumbDailyCalories =
          [
            Constants.Users.DEFAULT_FEMALE_DAILY_CALORIES,
            Constants.Users.DEFAULT_MALE_DAILY_CALORIES,
          ] as Array<Number>;

        return ruleOfThumbDailyCalories[userProfile.gender];
      }

      // The Mifflin St Jeor equation
      // https://en.wikipedia.org/wiki/Basal_metabolic_rate#BMR_estimation_formulas
      var scalingValue =
        userProfile.gender == 0
          ? Constants.Users.FEMALE_BMR_SCALING_VALUE
          : Constants.Users.MALE_BMR_SCALING_VALUE;

      var bodyMetabolicRate =
        10.0 * Utils.Conversion.valueToKilos(userProfile.weight as Number) +
        6.25 * (userProfile.height as Number) -
        5.0 * (Utils.Time.getCurrentYear() - (userProfile.birthYear as Number)) +
        scalingValue;

      var multiplier = getActivityClassMultiplier(userProfile.activityClass as Number);
      var activeMetabolicRate = Math.round(bodyMetabolicRate * multiplier).toNumber();

      return activeMetabolicRate;
    }

    // Gets an estimation of the user's daily calorie burn progress as a percentage
    // @return Numeric or null
    function getCalorieProgress(current as Number?) as Numeric? {
      var value = ActivityMonitor.getInfo().calories;

      if (value == null) {
        return null;
      }

      return value / getCalorieTarget();
    }
  }
}
