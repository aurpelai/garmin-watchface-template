import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ArcComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.ArcController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mIsVisible as Boolean;
  hidden var mAngle as Number;
  hidden var mHeight as Number;
  hidden var mRadius as Number;
  hidden var mWidth as Number;

  public function initialize(params as Types.Components.ArcParams) {
    mController =
      Utils.Controller.getController(params[:controller] as Types.Controllers.Id) as
      Types.Controllers.ArcController;
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mAngle = 0;
    mHeight = params[:height] as Number;
    mRadius = params[:radius] as Number;
    mWidth = params[:width] as Number;
    mIsVisible = true;
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, true)) {
      mAngle = mController.getAngle();
      mIsVisible = mController.shouldDraw();
      mUpdated = Time.now();
    }

    dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
    dc.setClip(locX - mRadius, locY - mRadius, mRadius * 2, mRadius * 2);

    // Instead of clearing the screen using dc.clear(), draw a 360-degree arc. This
    // let's us not to worry about redrawing every complication on every screen update
    // as they are not cleared whenever this drawable updates (as the clipping region
    // is the full screen).
    dc.drawArc(locX, locY, mRadius - mHeight, Graphics.ARC_CLOCKWISE, 0, 360);

    if (!mIsVisible) {
      return;
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
