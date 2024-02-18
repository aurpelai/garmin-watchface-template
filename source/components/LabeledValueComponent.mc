import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class LabeledValueComponent extends WatchUi.Drawable {
  hidden var mController as Types.Controllers.EverythingController;
  hidden var mUpdateInterval as Time.Duration;
  hidden var mUpdated as Time.Moment;
  hidden var mHideUnit as Boolean;
  hidden var mLabel as String;
  hidden var mUnit as String;
  hidden var mValue as String;

  function initialize(params as Types.Components.LabeledValueParams) {
    Drawable.initialize(params);
    mController = Utils.Controller.getController(params[:controller] as Types.Controllers.Id);
    mUpdated = new Time.Moment(0);
    mUpdateInterval = Utils.Component.getUpdateInterval(params[:updateInterval]);
    mHideUnit = params[:hideUnit] as Boolean;
    mLabel = Application.loadResource(Rez.Strings.Unknown) as String;
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
  }

  function drawLabel(dc as Graphics.Dc) as Void {
    dc.setColor(Constants.Colors.SECONDARY, Constants.Colors.BACKGROUND);
    dc.drawText(
      locX,
      locY - height / 2,
      Constants.Fonts.LABEL_FONT,
      mLabel,
      Graphics.TEXT_JUSTIFY_CENTER
    );
  }

  function drawValue(dc as Graphics.Dc, valueAndUnitGap as Number) as Void {
    var VERTICAL_OFFSET = Graphics.getFontHeight(Constants.Fonts.LABEL_FONT) / 2;
    var HORIZONTAL_OFFSET = !(
      (Application.Properties.getValue("HideUnitsSetting") as Boolean) || mHideUnit
    )
      ? valueAndUnitGap / 2 + dc.getTextWidthInPixels(mUnit, Constants.Fonts.UNIT_FONT) / 2
      : 0;

    dc.setColor(Constants.Colors.PRIMARY, Constants.Colors.BACKGROUND);
    dc.drawText(
      locX - HORIZONTAL_OFFSET,
      locY + VERTICAL_OFFSET,
      Constants.Fonts.VALUE_FONT,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  function drawUnit(dc as Graphics.Dc, valueAndUnitGap as Number) as Void {
    var VERTICAL_OFFSET =
      (Graphics.getFontDescent(Constants.Fonts.LABEL_FONT) +
        Graphics.getFontHeight(Constants.Fonts.LABEL_FONT)) /
      2;
    var HORIZONTAL_OFFSET =
      valueAndUnitGap / 2 + dc.getTextWidthInPixels(mValue, Constants.Fonts.VALUE_FONT) / 2;

    dc.setColor(Constants.Colors.TERTIARY, Constants.Colors.BACKGROUND);
    dc.drawText(
      locX + HORIZONTAL_OFFSET,
      locY + VERTICAL_OFFSET,
      Constants.Fonts.UNIT_FONT,
      mUnit,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }

  function draw(dc as Graphics.Dc) as Void {
    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      mLabel = mController.getLabel().toUpper();
      mUnit = mController.getUnit();
      mValue = mController.getValue().toString();
      mUpdated = Time.now();
    }

    var VALUE_AND_UNIT_GAP = dc.getTextWidthInPixels(" ", Constants.Fonts.UNIT_FONT) / 2;

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);
    drawLabel(dc);
    drawValue(dc, VALUE_AND_UNIT_GAP);

    if (mHideUnit || (Application.Properties.getValue("HideUnitsSetting") as Boolean)) {
      return;
    }

    drawUnit(dc, VALUE_AND_UNIT_GAP);
  }
}
