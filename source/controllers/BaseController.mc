import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class BaseController {
  public function getAngle() as Numeric {
    return Utils.Controller.getAngleByProgress(0, 100);
  }
  public function getIcon() as BitmapResource? {
    return null;
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
