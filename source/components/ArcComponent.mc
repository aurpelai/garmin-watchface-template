import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ArcComponent extends WatchUi.Drawable {
  hidden var mController as Types.ArcController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mAngle as Number;
  hidden var mHeight as Number;
  hidden var mRadius as Number;
  hidden var mWidth as Number;

  public function initialize(params as Types.ComponentParams) {
    mController =
      Utils.Controller.getController(params[:controller] as Controllers.Identifier) as
      Types.ArcController;
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mAngle = 0;
    mHeight = params[:height] as Number;
    mRadius = params[:radius] as Number;
    mWidth = params[:width] as Number;
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    if ((Application.Storage.getValue("HighPowerMode") as Boolean) == false) {
      return;
    }

    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval)) {
      mAngle = mController.getAngle();
      mUpdated = Time.now();
    }

    dc.setPenWidth(mHeight);
    dc.setColor(Constants.Color.GOLD, Constants.Color.BACKGROUND);
    dc.drawArc(
      locX,
      locY,
      mRadius - mHeight,
      Graphics.ARC_CLOCKWISE,
      mAngle + mWidth / 2,
      mAngle - mWidth / 2
    );
  }
}
