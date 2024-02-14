import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;

class ComplicationsController extends BaseController {
  hidden var mType as Complications.Type;
  hidden var mValue as String or Numeric;
  hidden var mUnit as String;

  function initialize(type as Complications.Type) {
    BaseController.initialize(null);
    mType = type;
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    Utils.Complications.registerToComplicationChangeCallback(
      type,
      self.method(:onComplicationUpdate)
    );
  }

  public function onComplicationUpdate(id as Complications.Id) as Void {
    if (id.getType() != mType) {
      return;
    }

    var complication = Complications.getComplication(id);

    if (complication[:value] == null) {
      mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    } else {
      mValue = complication[:value] as Complications.Value;
    }

    mUnit = Utils.Complications.getUnitFromEnum(complication[:unit]) as String;
  }

  public function getAngle() as Numeric {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_BATTERY:
        return Utils.Conversion.progressToAngle(100 - System.getSystemStats().battery, {
          :min => Constants.Value.DEFAULT_MIN_PROGRESS,
          :max => Constants.Value.DEFAULT_MAX_PROGRESS,
        });
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Utils.Conversion.progressToAngle(mValue.toNumber(), {
          :min => Constants.Value.DEFAULT_MIN_PROGRESS,
          :max => Utils.Energy.getCalorieTarget(),
        });
      case Complications.COMPLICATION_TYPE_STEPS:
        return Utils.Conversion.progressToAngle(Utils.Steps.getStepProgress(mValue.toNumber()), {
          :min => Constants.Value.DEFAULT_MIN_PROGRESS,
          :max => Constants.Value.DEFAULT_MAX_PROGRESS,
        });
      default:
        return Utils.Conversion.progressToAngle(0, {
          :min => Constants.Value.DEFAULT_MIN_PROGRESS,
          :max => Constants.Value.DEFAULT_MAX_PROGRESS,
        });
    }
  }

  public function getLabel() as String {
    switch (mType) {
      case Complications.COMPLICATION_TYPE_BATTERY:
        return Application.loadResource(Rez.Strings.BatteryLabel) as String;
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
      case Complications.COMPLICATION_TYPE_STEPS:
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
        var value = ActivityMonitor.getInfo().calories;

        if (value == null) {
          return null;
        }

        return value / Utils.Data.getCalorieTarget();
      case Complications.COMPLICATION_TYPE_STEPS:
        var stepsInfo = Utils.Data.getStepsInfo();
        return (1.0 * stepsInfo[0]) / stepsInfo[1];
      default:
        return null;
    }
  }

  public function getUnit() as String? {
    return mUnit;
  }

  public function getValue() as String or Numeric {
    return mValue;
  }
}
