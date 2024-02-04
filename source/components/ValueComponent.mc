import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ValueComponent extends WatchUi.Drawable {
  hidden var mController as Types.ValueController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mValue as String;

  public function initialize(params as Types.ComponentParams) {
    mController = Utils.Controller.getController(params[:controller] as Controllers.Identifier);
    mUpdated = new Time.Moment(0);
    // -1 to account for the fact that we're using greaterThan comparison instead of gte (gte not available)
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mValue = Application.loadResource(Rez.Strings.UnknownTime) as String;
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval)) {
      mValue = mController.getValue();
      mUpdated = Time.now();
    }

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.drawText(
      locX,
      locY,
      Graphics.FONT_LARGE,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}
