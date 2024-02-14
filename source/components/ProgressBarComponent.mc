import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ProgressBarComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.EverythingController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mHideLabel as Boolean;
  hidden var mUpdated as Time.Moment;
  hidden var mLabel as String;
  hidden var mProgress as Numeric;

  function initialize(params as Types.Components.ProgressBarParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mHideLabel = params[:hideLabel] as Boolean;
    mLabel = Application.loadResource(Rez.Strings.Unknown) as String;
    mProgress = 0.0;
  }

  function draw(dc as Graphics.Dc) as Void {
    mLabel = mController.getLabel().toUpper();

    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      var progress = mController.getProgress();
      mProgress = progress != null ? progress : 0;
      mUpdated = Time.now();
    }

    var LABEL_OFFSET = 4;
    var progress = width * mProgress;
    var totalHeight = !mHideLabel
      ? height + LABEL_OFFSET + dc.getFontHeight(Constants.Font.LABEL_FONT)
      : height;

    Utils.Component.clipAndClearRectangle(dc, locX, locY + totalHeight / 2, width, totalHeight);

    dc.setColor(Constants.Color.TERTIARY, Constants.Color.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY, width, height);

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY, progress, height);

    if (!mHideLabel) {
      dc.setColor(Constants.Color.SECONDARY, Constants.Color.BACKGROUND);
      dc.drawText(
        locX,
        locY + height + LABEL_OFFSET,
        Constants.Font.LABEL_FONT,
        mLabel,
        Graphics.TEXT_JUSTIFY_CENTER
      );
    }
  }
}
