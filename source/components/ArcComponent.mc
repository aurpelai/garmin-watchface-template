import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ArcComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.EverythingController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mAngle as Numeric;
  hidden var mHeight as Number;
  hidden var mRadius as Number;
  hidden var mWidth as Number;

  function initialize(params as Types.Components.ArcParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mAngle = 0;
    mHeight = params[:height] as Number;
    mRadius = params[:radius] as Number;
    mWidth = params[:width] as Number;
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, true)) {
      var controllerAngle = mController.getAngle();
      mAngle = controllerAngle != null ? controllerAngle as Numeric : 0;
      mUpdated = Time.now();
    }

    Utils.Component.clipAndClearArc(dc, locX, locY, mRadius, mHeight);

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
