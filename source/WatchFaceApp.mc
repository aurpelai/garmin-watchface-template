import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

var gCallbacks as Types.Controllers.ComplicationsControllerDictionary =
  ({}) as Types.Controllers.ComplicationsControllerDictionary;
var gIsLegacyDevice as Boolean = true;
var gForceRedraw as Boolean = false;

class WatchFaceApp extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
    gIsLegacyDevice = !Utils.Complications.hasComplicationSupport();
  }

  // onComplicationUpdate() is a CUSTOM event handler callback for devices with Toybox.Complications support
  function onComplicationUpdate(complicationId as Complications.Id) as Void {
    var type = complicationId.getType() as Complications.Type;

    if (gCallbacks.hasKey(type)) {
      (gCallbacks.get(type) as Types.Controllers.ComplicationUpdater).invoke(complicationId);
    }
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {
    if (gIsLegacyDevice) {
      return;
    }

    Complications.registerComplicationChangeCallback(self.method(:onComplicationUpdate));
    Complications.subscribeToUpdates(
      new Complications.Id(Complications.COMPLICATION_TYPE_CALORIES)
    );
    Complications.subscribeToUpdates(new Complications.Id(Complications.COMPLICATION_TYPE_STEPS));
    Complications.subscribeToUpdates(
      new Complications.Id(Complications.COMPLICATION_TYPE_HEART_RATE)
    );
  }

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {
    if (gIsLegacyDevice) {
      return;
    }

    Complications.unsubscribeFromAllUpdates();
  }

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return [new WatchFaceView()] as Array<Views or InputDelegates>;
  }

  function getSettingsView() as Array<Views or InputDelegates>? {
    return [new SettingsView(), new SettingsDelegate()] as Array<Views or InputDelegates>;
  }
}
