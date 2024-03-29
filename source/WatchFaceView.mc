import Toybox.Application;
import Toybox.Graphics;
import Toybox.WatchUi;

class WatchFaceView extends WatchUi.WatchFace {
  function initialize() {
    WatchFace.initialize();
  }

  // Load your resources here
  function onLayout(dc as Graphics.Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    Application.Storage.setValue("HighPowerMode", true);
    gForceRedraw = true;
  }

  // Update the view
  function onUpdate(dc as Graphics.Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
    gForceRedraw = false;
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
    Application.Storage.setValue("HighPowerMode", false);
  }

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    Application.Storage.setValue("HighPowerMode", true);
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    Application.Storage.setValue("HighPowerMode", false);
  }
}
