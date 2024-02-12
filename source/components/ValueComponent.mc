import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class ValueComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.EverythingController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mHideUnit as Boolean;
  hidden var mUnit as String;
  hidden var mValue as String;

  function initialize(params as Types.Components.ValueParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mHideUnit = params[:hideUnit] as Boolean;
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownTime) as String;
  }

  function draw(dc as Graphics.Dc) as Void {
    var VALUE_FONT = Graphics.FONT_LARGE;
    var UNIT_FONT = Graphics.FONT_SMALL;
    var HIDE_UNIT = mHideUnit || !(Application.Properties.getValue("ShowUnitsSetting") as Boolean);

    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      if (HIDE_UNIT || mController.getUnit() == null) {
        mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
      } else {
        mUnit = mController.getUnit() as String;
      }
      mValue = mController.getValue().toString();
      mUpdated = Time.now();
    }

    var VALUE_AND_UNIT_GAP = dc.getTextWidthInPixels(" ", UNIT_FONT) / 2;
    var VALUE_HORIZONTAL_OFFSET =
      VALUE_AND_UNIT_GAP / 2 + dc.getTextWidthInPixels(mUnit, UNIT_FONT) / 2;
    var UNIT_HORIZONTAL_OFFSET =
      VALUE_AND_UNIT_GAP / 2 + dc.getTextWidthInPixels(mValue, VALUE_FONT) / 2;

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.drawText(
      locX - VALUE_HORIZONTAL_OFFSET,
      locY - height / 2,
      VALUE_FONT,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER
    );

    if (!HIDE_UNIT) {
      dc.drawText(
        locX + UNIT_HORIZONTAL_OFFSET,
        locY - height / 2,
        UNIT_FONT,
        mUnit,
        Graphics.TEXT_JUSTIFY_CENTER
      );
    }
  }
}
