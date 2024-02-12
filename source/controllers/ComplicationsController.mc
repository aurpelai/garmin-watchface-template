import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Complications;
import Toybox.Lang;

class ComplicationsController extends BaseController {
  hidden var mComplication as Complications.Complication;
  hidden var mComplicationId as Complications.Type;
  hidden var mValue as String or Number;
  hidden var mUnit as String?;

  function initialize(complicationId as Complications.Type) {
    BaseController.initialize();
    mComplicationId = complicationId;
    mComplication = Complications.getComplication(new Complications.Id(mComplicationId));
    mUnit = Application.loadResource(Rez.Strings.UnknownUnit) as String;
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;

    Utils.Complications.registerToComplicationChangeCallback(
      mComplicationId,
      self.method(:onComplicationUpdate)
    );
  }


  public function onComplicationUpdate(complicationId as Complications.Id) as Void {
    if (complicationId.getType() != mComplicationId) {
      return;
    }

    if (mComplication[:value] == null) {
      mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    } else {
      mValue = (mComplication[:value] as Complications.Value).toString();
    }

    mUnit =
      Utils.Complications.getUnitByEnumValue(complication[:unit] as Complications.Unit?) as String;
  }

  public function getLabel() as String {
    switch (mComplicationId) {
      case Complications.COMPLICATION_TYPE_CALORIES:
        return Application.loadResource(Rez.Strings.CaloriesLabel) as String;
      case Complications.COMPLICATION_TYPE_STEPS:
        return Application.loadResource(Rez.Strings.StepsLabel) as String;
      default:
        if (mComplication[:shortLabel] == null) {
          return Application.loadResource(Rez.Strings.Unknown) as String;
        }
        return (mComplication[:shortLabel] as Complications.Label).toString();
    }
  }
}
