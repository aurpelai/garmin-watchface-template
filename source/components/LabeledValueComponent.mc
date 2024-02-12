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

  function draw(dc as Graphics.Dc) as Void {
    mHideUnit = mHideUnit || !(Application.Properties.getValue("ShowUnitsSetting") as Boolean);

    if (Utils.Controller.shouldUpdate(mUpdated, mUpdateInterval, false)) {
      if (mHideUnit || mController.getUnit() == null) {
        mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
      } else {
        mUnit = mController.getUnit() as String;
      }
      mLabel = mController.getLabel().toUpper();
      mValue = mController.getValue().toString();
      mUpdated = Time.now();
    }

    var VALUE_AND_UNIT_GAP = dc.getTextWidthInPixels(" ", Constants.Font.UNIT_FONT) / 2;
    var VALUE_VERTICAL_OFFSET = dc.getFontHeight(Constants.Font.LABEL_FONT) * 0.9;
    var VALUE_HORIZONTAL_OFFSET = Application.Properties.getValue("ShowUnitsSetting")
      ? VALUE_AND_UNIT_GAP / 2 + dc.getTextWidthInPixels(mUnit, Constants.Font.UNIT_FONT) / 2
      : 0;
    var UNIT_VERTICAL_OFFSET =
      VALUE_VERTICAL_OFFSET + dc.getFontHeight(Constants.Font.UNIT_FONT) / 4;
    var UNIT_HORIZONTAL_OFFSET =
      VALUE_AND_UNIT_GAP / 2 + dc.getTextWidthInPixels(mValue, Constants.Font.VALUE_FONT) / 2;

    Utils.Component.clipAndClearRectangle(dc, locX, locY, width, height);

    dc.setColor(Constants.Color.SECONDARY, Constants.Color.BACKGROUND);
    dc.drawText(
      locX,
      locY - height / 2,
      Constants.Font.LABEL_FONT,
      mLabel,
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.drawText(
      locX - VALUE_HORIZONTAL_OFFSET,
      locY + VALUE_VERTICAL_OFFSET - height / 2,
      Constants.Font.VALUE_FONT,
      mValue,
      Graphics.TEXT_JUSTIFY_CENTER
    );

    if (!mHideUnit) {
      dc.drawText(
        locX + UNIT_HORIZONTAL_OFFSET,
        locY + UNIT_VERTICAL_OFFSET - height / 2,
        Constants.Font.UNIT_FONT,
        mUnit,
        Graphics.TEXT_JUSTIFY_CENTER
      );
    }
  }
}
