import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFaceApp extends Application.AppBase {
  var mCallbacks as
  Dictionary<Complications.Type, (Method(complicationId as Complications.Id) as Void)> = {};
  var mUsedComplications as Array<Complications.Id>;
  function initialize() {
    AppBase.initialize();
    mUsedComplications = [
      new Complications.Id(Complications.COMPLICATION_TYPE_CALORIES),
      new Complications.Id(Complications.COMPLICATION_TYPE_STEPS),
    ];
  }

  function complicationCallbackDelegate(complicationId as Complications.Id) as Void {
    if (mCallbacks.hasKey(complicationId.getType())) {
      mCallbacks.get(complicationId.getType()).invoke(complicationId);
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {
    Complications.registerComplicationChangeCallback(self.method(:complicationCallbackDelegate));
    for (var i = 0; i < mUsedComplications.size(); i++) {
      Complications.subscribeToUpdates(mUsedComplications[i]);
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
