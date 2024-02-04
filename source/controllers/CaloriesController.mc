import Toybox.Complications;
import Toybox.Lang;

class CaloriesController {
  var mValue as String;
  var mUnit as String;
  var mHasCompSupport as Boolean;
  var mComplicationId as Complications.Id;

  function initialize() {
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    mUnit = "";
    mHasCompSupport = Utils.Complications.hasComplicationSupport();
    mComplicationId = new Complications.Id(Complications.COMPLICATION_TYPE_CALORIES);
    if (mHasCompSupport) {
      Utils.Complications.registerToComplicationChangeCallback(
        mComplicationId,
        self.method(:onComplicationUpdate)
      );
    }
  }

  function onComplicationUpdate(complicationId as Complications.Id) as Void {
    if (!complicationId.equals(mComplicationId)) {
      return;
    }
    var comp = Complications.getComplication(complicationId);

    mValue = comp[:value];
    mUnit = comp[:unit];
  }

  function updateData() as Void {
    mValue = "";
    mUnit = "";
  }

  function getValue() as String {
    if (!mHasCompSupport) {
      updateData();
    }

    return mValue;
  }

  function getLabel() as String {
    return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
  }

  function getUnit() as String {
    if (!mHasCompSupport) {
      updateData();
    }

    return mUnit;
  }
}