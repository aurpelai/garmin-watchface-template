import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BluetoothStatusController extends BaseController {
  function initialize(id as Types.Controllers.Id) {
    BaseController.initialize(id);
  }

  hidden function isBluetoothConnected() as Boolean {
    var isBluetoothConnected = System.getDeviceSettings().phoneConnected;
    return isBluetoothConnected;
  }

  public function getIcon() as BitmapResource? {
    return Application.loadResource(Rez.Drawables.BluetoothIcon) as BitmapResource;
  }

  public function getLabel() as String {
    if (Application.Properties.getValue("ShortLabelsSetting")) {
      return Application.loadResource(Rez.Strings.BluetoothStatusLabelShort) as String;
    }

    return Application.loadResource(Rez.Strings.BluetoothStatusLabel) as String;
  }

  public function getValue() as String or Number {
    var value = isBluetoothConnected() ? Rez.Strings.ValueOn : Rez.Strings.ValueOff;

    return Application.loadResource(value) as String;
  }

  public function shouldDraw() as Boolean {
    return !isBluetoothConnected();
  }
}
