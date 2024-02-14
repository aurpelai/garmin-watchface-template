import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class BaseController {
  var mId as Types.Controllers.Id?;

  public function initialize(id as Types.Controllers.Id?) {
    mId = id;
  }
  public function getAngle() as Numeric {
    return Utils.Conversion.progressToAngle(0, {
      :min => Constants.Value.DEFAULT_MIN_PROGRESS,
      :max => Constants.Value.DEFAULT_MAX_PROGRESS,
    });
  }
  public function getIcon() as BitmapResource? {
    return null;
  }
  public function getId() as Types.Controllers.Id? {
    return mId;
  }
  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.Unknown) as String;
  }
  public function getProgress() as Numeric? {
    return null;
  }
  public function getUnit() as String? {
    return null;
  }
  public function getValue() as String or Numeric {
    return Application.loadResource(Rez.Strings.UnknownValue) as String;
  }
  public function shouldDraw() as Boolean {
    return true;
  }
}
