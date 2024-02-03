import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class TimeFieldView extends WatchUi.Drawable {
  hidden var mController as Types.ValueController;
  hidden var mUpdated as Time.Moment;
  hidden var mValue as String;
  hidden var mUpdateInterval as Time.Duration;

  public function initialize(params as Types.ViewParams) {
    mController = Utils.Controller.getController(params[:controller]);
    mUpdated = new Time.Moment(0);
    // -1 to account for the fact that we're using greaterThan comparison instead of gte (gte not available)
    mUpdateInterval = new Time.Duration(params[:updateInterval] - 1);
    mValue = Application.loadResource(Rez.Strings.UnknownTime);
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
