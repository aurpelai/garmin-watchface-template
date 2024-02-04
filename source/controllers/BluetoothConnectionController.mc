import Toybox.Application;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BluetoothConnectionController {
  hidden function isBluetoothConnected() as Boolean {
    var isBluetoothConnected = System.getDeviceSettings().phoneConnected;
    return isBluetoothConnected;
  }

  public function getIcon() as WatchUi.BitmapResource {
    return Application.loadResource(Rez.Drawables.BluetoothIcon) as WatchUi.BitmapResource;
  }

  public function getLabel() as String {
    return Application.loadResource(Rez.Strings.BluetoothStatusLabel) as String;
  }

  public function getValue() as String {
    var value = isBluetoothConnected()
      ? Application.loadResource(Rez.Strings.ValueOn) as String
      : Application.loadResource(Rez.Strings.ValueOff) as String;

    return value;
  }

  public function shouldDraw() as Boolean {
    return !isBluetoothConnected();
  }
}
