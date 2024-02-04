import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFaceApp extends Application.AppBase {
  hidden var mDeviceSupportsComplications as Boolean = Utils.Complications.hasComplicationSupport();
  hidden var mCallbacks as Dictionary<Complications.Type, Types.ComplicationCallbackFunction> =
    ({}) as Dictionary<Complications.Type, Types.ComplicationCallbackFunction>;
  hidden var mUsedComplications as Array<Complications.Id> = [] as Array<Complications.Id>;

  function initialize() {
    AppBase.initialize();

    if (mDeviceSupportsComplications) {
      mUsedComplications =
        [
          new Complications.Id(Complications.COMPLICATION_TYPE_CALORIES),
          new Complications.Id(Complications.COMPLICATION_TYPE_STEPS),
        ] as Array<Complications.Id>;
    }
  }

  function complicationCallbackDelegate(complicationId as Complications.Id) as Void {
    var type = complicationId.getType() as Complications.Type;

    if (mCallbacks.hasKey(type)) {
      (mCallbacks.get(type) as Types.ComplicationCallbackFunction).invoke(complicationId);
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {
    if (mDeviceSupportsComplications) {
      Complications.registerComplicationChangeCallback(self.method(:complicationCallbackDelegate));
      for (var i = 0; i < mUsedComplications.size(); i++) {
        Complications.subscribeToUpdates(mUsedComplications[i]);
      }
    }
  }

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return [new WatchFaceView()] as Array<Views or InputDelegates>;
  }

  function getSettingsView() as Array<Views or InputDelegates>? {
    return [new SettingsView(), new SettingsDelegate()] as Array<Views or InputDelegates>;
  }
}
