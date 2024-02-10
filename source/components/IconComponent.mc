import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class IconComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.IconController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mIcon as BitmapResource?;
  hidden var mIsVisible as Boolean;

  function initialize(params as Types.Components.IconParams) {
    Drawable.initialize(params);
    mController =
      Utils.Controller.getController(params[:controller] as Types.Controllers.Id) as
      Types.Controllers.IconController;
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mIsVisible = false;
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      mIcon = mController.getIcon();
      mIsVisible = mController.shouldDraw();
      mUpdated = Time.now();
    }

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);

    if (mIcon == null || !mIsVisible) {
      return;
    }

    dc.drawBitmap(locX - width / 2, locY - height / 2, mIcon as BitmapResource);
  }
}
