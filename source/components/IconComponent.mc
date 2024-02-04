import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class IconComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controller;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mIcon as WatchUi.BitmapResource?;
  hidden var mIsVisible as Boolean;

  public function initialize(params as Types.ComponentParams) {
    mController = Utils.Controller.getController(params[:controller] as Controllers.Identifier);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mIsVisible = false;
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval)) {
      mIcon = mController.getIcon();
      mIsVisible = mController.shouldDraw();
      mUpdated = Time.now();
    }

    if (mIcon == null || !mIsVisible) {
      return;
    }

    var xOffset = -width / 2;
    var yOffset = -height / 2;

    dc.drawBitmap(locX + xOffset, locY + yOffset, mIcon);
  }
}
