import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class ComplicationsController {
  var mComplication as Complications.Complication;
  var mComplicationId as Complications.Type;
  var mValue as String;
  var mUnit as String;

  function initialize(complicationId as Complications.Type) {
    mComplicationId = complicationId;
    mComplication = Complications.getComplication(new Complications.Id(mComplicationId));
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    mUnit = "";

    Utils.Complications.registerToComplicationChangeCallback(
      mComplicationId,
      self.method(:onComplicationUpdate)
    );
  }

  function onComplicationUpdate(complicationId as Complications.Id) as Void {
    if (complicationId.getType() != mComplicationId) {
      return;
    }

    if (mComplication[:value] == null) {
      mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    } else {
      mValue = (mComplication[:value] as Complications.Value).toString();
    }

    if (mComplication[:unit] == null) {
      mUnit = "";
    } else {
      mUnit = (mComplication[:unit] as Complications.Unit).toString();
    }
  }

  function getValue() as String {
    return mValue;
  }

  function getLabel() as String {
    switch (mComplicationId) {
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
      case Complications.COMPLICATION_TYPE_STEPS:
        return Application.loadResource(Rez.Strings.StepsLabel) as String;
      default:
        if (mComplication[:shortLabel] == null) {
          return Application.loadResource(Rez.Strings.Unknown) as String;
        }
        return mComplication[:shortLabel] as Complications.Label;
    }
  }

  function getUnit() as String {
    return mUnit;
  }
}
