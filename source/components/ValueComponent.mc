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
  hidden var mFont as Graphics.FontDefinition;

  function initialize(params as Types.Components.ValueParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mHideUnit = params[:hideUnit] as Boolean;
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownTime) as String;
    mFont =
      mController.getId() == Types.Controllers.CURRENT_TIME
        ? Graphics.FONT_NUMBER_HOT
        : Constants.Fonts.VALUE_FONT;
  }

  function drawValue(dc as Graphics.Dc, valueAndUnitGap as Numeric) as Void {
    var HORIZONTAL_OFFSET = !(
      (Application.Properties.getValue("HideUnitsSetting") as Boolean) || mHideUnit
    )
      ? valueAndUnitGap / 2 + dc.getTextWidthInPixels(mUnit, Constants.Fonts.UNIT_FONT) / 2
      : 0;

    dc.setColor(Constants.Colors.PRIMARY, Constants.Colors.BACKGROUND);
    dc.drawText(
      locX - HORIZONTAL_OFFSET,
      locY,
      mFont,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  function drawUnit(dc as Graphics.Dc, valueAndUnitGap as Numeric) as Void {
    var HORIZONTAL_OFFSET = valueAndUnitGap / 2 + dc.getTextWidthInPixels(mValue, mFont) / 2;

    dc.setColor(Constants.Colors.TERTIARY, Constants.Colors.BACKGROUND);
    dc.drawText(
      locX + HORIZONTAL_OFFSET,
      locY,
      Constants.Fonts.UNIT_FONT,
      mUnit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      mUnit = mController.getUnit();
      mValue = mController.getValue().toString();
      mUpdated = Time.now();
    }

    var VALUE_AND_UNIT_GAP = dc.getTextWidthInPixels(" ", Constants.Fonts.UNIT_FONT) / 2;

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);
    drawValue(dc, VALUE_AND_UNIT_GAP);

    if (mHideUnit || (Application.Properties.getValue("HideUnitsSetting") as Boolean)) {
      return;
    }

    drawUnit(dc, VALUE_AND_UNIT_GAP);
  }
}
