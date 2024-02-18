import Toybox.Application;
import Toybox.Lang;

class LegacyHeartRateController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  public function getAngle() as Number {
    return Utils.Conversion.progressToAngle(
      Utils.HeartRate.getLegacyHeartRate(),
      Utils.HeartRate.getHeartRateRange()
    );
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.HeartRateLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.HeartRateLabel) as String;
  }

  public function getProgress() as Number? {
    return Utils.HeartRate.getHeartRateProgress(Utils.HeartRate.getLegacyHeartRate());
  }

  public function getUnit() as String {
    return Application.loadResource(Rez.Strings.HeartRateUnit) as String;
  }

  public function getValue() as String or Numeric {
    var heartRate = Utils.HeartRate.getLegacyHeartRate();

    if (heartRate == null) {
      return Application.loadResource(Rez.Strings.UnknownValue) as String;
    }

    return heartRate;
  }
}
