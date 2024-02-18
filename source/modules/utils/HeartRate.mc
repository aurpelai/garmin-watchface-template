import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Lang;
import Toybox.SensorHistory;
import Toybox.UserProfile;
import Toybox.Time;

module Utils {
  module HeartRate {
    function getHeartRateFromCurrentActivity() as Number? {
      var activityInfo = Activity.getActivityInfo();

      if (activityInfo has :currentHeartRate) {
        return activityInfo[:currentHeartRate];
      }

      return null;
    }

    function getHeartRateFromActivityHistory() as Number? {
      if (!(ActivityMonitor has :getHeartRateHistory)) {
        return null;
      }

      var sample = ActivityMonitor.getHeartRateHistory(1, false).next();

      if (sample == null || sample[:heartRate] == ActivityMonitor.INVALID_HR_SAMPLE) {
        return null;
      }

      return sample[:heartRate];
    }

    function getHeartRateFromSensorHistory() as Number? {
      if (!(SensorHistory has :getHeartRateHistory)) {
        return null;
      }

      var sample = SensorHistory.getHeartRateHistory({}).next();

      if (!(sample has :data) || sample[:data] == null) {
        return null;
      }

      return ((sample as SensorHistory.SensorSample)[:data] as Number or Float).toNumber();
    }

    function getLegacyHeartRate() as Number? {
      var heartRateFromCurrentActivity = getHeartRateFromCurrentActivity();

      if (heartRateFromCurrentActivity != null) {
        return heartRateFromCurrentActivity;
      }

      var heartRateFromActivityHistory = getHeartRateFromActivityHistory();

      if (heartRateFromActivityHistory != null) {
        return heartRateFromActivityHistory;
      }

      return getHeartRateFromSensorHistory();
    }

    function getRestingHeartRate() as Number? {
      var userProfile = UserProfile.getProfile();

      if (userProfile.restingHeartRate != null) {
        return userProfile.restingHeartRate;
      }

      if (userProfile.averageRestingHeartRate != null) {
        return userProfile.averageRestingHeartRate;
      }

      return null;
    }

    function getMaxHeartRate() as Number? {
      if (ActivityMonitor has :getHeartRateHistory) {
        return ActivityMonitor.getHeartRateHistory(null, false).getMax();
      }

      return UserProfile.getHeartRateZones(UserProfile.HR_ZONE_SPORT_GENERIC).slice(-1, null)[0];
    }

    function getHeartRateRange() as Types.Utils.MinMaxOptions {
      var restingHeartRate = getRestingHeartRate();
      var maxHeartRate = getMaxHeartRate();

      if (restingHeartRate == null) {
        restingHeartRate = 0;
      }

      if (maxHeartRate == null) {
        maxHeartRate = Constants.Users.DEFAULT_MAX_HEART_RATE;
      }

      return ({ :min => restingHeartRate, :max => maxHeartRate }) as Types.Utils.MinMaxOptions;
    }

    function getHeartRateProgress(current as Number?) as Number? {
      if (current == null) {
        return null;
      }

      var range = getHeartRateRange();

      if (range[:max] == null || range[:min] == null) {
        return null;
      }

      return (
        (100 * (current - (range[:min] as Number))) /
        ((range[:max] as Number) - (range[:min] as Number))
      );
    }
  }
}
