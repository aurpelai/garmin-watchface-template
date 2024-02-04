import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

var gDeviceSupportsComplications as Boolean = false;
var gCallbacks as Types.ComplicationDictionary = ({}) as Types.ComplicationDictionary;

class WatchFaceApp extends Application.AppBase {
  hidden var mComplications as Array<Complications.Type> = [] as Array<Complications.Type>;

  function initialize() {
    AppBase.initialize();
    gDeviceSupportsComplications = Utils.Complications.hasComplicationSupport();

    if (gDeviceSupportsComplications) {
      mComplications =
        [Complications.COMPLICATION_TYPE_CALORIES, Complications.COMPLICATION_TYPE_STEPS] as
        Array<Complications.Type>;
    }
  }

  function complicationCallbackDelegate(complicationId as Complications.Id) as Void {
    var type = complicationId.getType() as Complications.Type;

    if (gCallbacks.hasKey(type)) {
      (gCallbacks.get(type) as Types.ComplicationCallbackFunction).invoke(complicationId);
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {
    if (gDeviceSupportsComplications) {
      Complications.registerComplicationChangeCallback(self.method(:complicationCallbackDelegate));

      for (var i = 0; i < mComplications.size(); i++) {
        Complications.subscribeToUpdates(new Complications.Id(mComplications[i]));
      }
    }
  }

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {
    if (gDeviceSupportsComplications) {
      Complications.unsubscribeFromAllUpdates();
    }
  }

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return [new WatchFaceView()] as Array<Views or InputDelegates>;
  }

  function getSettingsView() as Array<Views or InputDelegates>? {
    return [new SettingsView(), new SettingsDelegate()] as Array<Views or InputDelegates>;
  }
}
