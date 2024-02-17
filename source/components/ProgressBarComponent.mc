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
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      var progress = mController.getProgress();
      mLabel = mController.getLabel().toUpper();
      mProgress = progress != null ? progress : 0;
      mUpdated = Time.now();
    }

    var totalHeight = !mHideLabel
      ? height +
        Constants.Values.PROGRESS_BAR_LABEL_VERTICAL_OFFSET +
        dc.getFontHeight(Constants.Fonts.LABEL_FONT)
      : height;

    Utils.Component.clipAndClearRectangle(dc, locX, locY + totalHeight / 2, width, totalHeight);

    dc.setColor(Constants.Colors.TERTIARY, Constants.Colors.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY, width, height);

    dc.setColor(Constants.Colors.PRIMARY, Constants.Colors.BACKGROUND);
    dc.fillRectangle(locX - width / 2, locY, width * mProgress, height);

    if (!mHideLabel) {
      dc.setColor(Constants.Colors.SECONDARY, Constants.Colors.BACKGROUND);
      dc.drawText(
        locX,
        locY + height + Constants.Values.PROGRESS_BAR_LABEL_VERTICAL_OFFSET,
        Constants.Fonts.LABEL_FONT,
        mLabel,
        Graphics.TEXT_JUSTIFY_CENTER
      );
    }
  }
}
