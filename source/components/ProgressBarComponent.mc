import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ProgressBarComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.EverythingController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mProgress as Numeric;

  function initialize(params as Types.Components.ProgressBarParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mProgress = 0.0;
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      if (mController.getProgress() == null) {
        return;
      }
      mProgress = mController.getProgress() as Numeric;
      mUpdated = Time.now();
    }

    var progress = width * mProgress;

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);

    dc.setColor(Constants.Color.TERTIARY, Constants.Color.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY - height / 2, width, height);

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY - height / 2, progress, height);
  }
}
