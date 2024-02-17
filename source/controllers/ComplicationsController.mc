import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;

class ComplicationsController extends BaseController {
  hidden static var instances as Types.Controllers.ComplicationDict?;

  hidden var mType as Complications.Type;
  hidden var mValue as String or Numeric;
  hidden var mUnit as String;

  function initialize(type as Complications.Type) {
    BaseController.initialize(null);
    mType = type;
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    Utils.Complications.registerUpdateCallback(type, self.method(:onComplicationUpdate));
  }

  static function getInstance(
    type as Complications.Type
  ) as Types.Controllers.EverythingController {
    if (instances == null) {
      instances = ({}) as Types.Controllers.ComplicationDict;
    }

    if (!(instances as Types.Controllers.ComplicationDict).hasKey(type)) {
      (instances as Types.Controllers.ComplicationDict).put(
        type,
        new ComplicationsController(type as Complications.Type)
      );
    }

    return (
      (instances as Types.Controllers.ComplicationDict).get(type) as
      Types.Controllers.EverythingController
    );
  }

  public function onComplicationUpdate(id as Complications.Id) as Void {
    if (id.getType() != mType) {
      return;
    }

    var complication = Complications.getComplication(id);

    mValue =
      complication[:value] == null
        ? Application.loadResource(Rez.Strings.UnknownValue) as String
        : complication[:value] as Complications.Value;

    mUnit = Utils.Complications.getUnitFromEnum(complication[:unit]) as String;
  }

  public function getAngle() as Numeric {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_BATTERY:
        return Utils.Conversion.progressToAngle(100 - System.getSystemStats().battery, {
          :min => Constants.Values.DEFAULT_MIN_PROGRESS,
          :max => Constants.Values.DEFAULT_MAX_PROGRESS,
        });
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Utils.Conversion.progressToAngle(mValue.toNumber(), {
          :min => Constants.Values.DEFAULT_MIN_PROGRESS,
          :max => Utils.Energy.getCalorieTarget(),
        });
      case Complications.COMPLICATION_TYPE_HEART_RATE:
        return Utils.Conversion.progressToAngle(
          Utils.HeartRate.getLegacyHeartRate(),
          Utils.HeartRate.getHeartRateRange()
        );
      case Complications.COMPLICATION_TYPE_STEPS:
        return Utils.Conversion.progressToAngle(Utils.Steps.getStepProgress(mValue.toNumber()), {
          :min => Constants.Values.DEFAULT_MIN_PROGRESS,
          :max => Constants.Values.DEFAULT_MAX_PROGRESS,
        });
      default:
        return Utils.Conversion.progressToAngle(0, {
          :min => Constants.Values.DEFAULT_MIN_PROGRESS,
          :max => Constants.Values.DEFAULT_MAX_PROGRESS,
        });
    }
  }

  public function getLabel() as String {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_BATTERY:
        if (Application.Properties.getValue("ShortLabelsSetting")) {
          return Application.loadResource(Rez.Strings.BatteryLabelShort) as String;
        }
        return Application.loadResource(Rez.Strings.BatteryLabel) as String;
      case Complications.COMPLICATION_TYPE_CALORIES:
        if (Application.Properties.getValue("ShortLabelsSetting")) {
          return Application.loadResource(Rez.Strings.CaloriesLabelShort) as String;
        }
        return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
      case Complications.COMPLICATION_TYPE_HEART_RATE:
        if (Application.Properties.getValue("ShortLabelsSetting")) {
          return Application.loadResource(Rez.Strings.HeartRateLabelShort) as String;
        }
        return Application.loadResource(Rez.Strings.HeartRateLabel) as String;
      case Complications.COMPLICATION_TYPE_STEPS:
        if (Application.Properties.getValue("ShortLabelsSetting")) {
          return Application.loadResource(Rez.Strings.StepsLabelShort) as String;
        }
        return Application.loadResource(Rez.Strings.StepsLabel) as String;
      default:
        return Application.loadResource(Rez.Strings.Unknown) as String;
    }
  }

  public function getProgress() as Numeric? {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_BATTERY:
        return System.getSystemStats().battery / 100.0;
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Utils.Energy.getCalorieProgress(mValue.toNumber());
      case Complications.COMPLICATION_TYPE_HEART_RATE:
        return Utils.HeartRate.getHeartRateProgress(mValue.toNumber());
      case Complications.COMPLICATION_TYPE_STEPS:
        return Utils.Steps.getStepProgress(mValue.toNumber());
      default:
        return null;
    }
  }

  public function getUnit() as String {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Application.loadResource(Rez.Strings.EnergyUnit) as String;
      case Complications.COMPLICATION_TYPE_HEART_RATE:
        return Application.loadResource(Rez.Strings.HeartRateUnit) as String;
      default:
        return mUnit;
    }
  }

  public function getValue() as String or Numeric {
    return mValue;
  }
}
