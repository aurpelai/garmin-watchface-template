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
    mValue = Application.loadResource(Rez.Strings.UnknownValue) as String;
    mUnit = "";

    Utils.Complications.registerToComplicationChangeCallback(
      mComplicationId,
      self.method(:onComplicationUpdate)
    );
  }

  hidden function getUnitByEnumValue(index as Complications.Unit?) as String? {
    if (index == null) {
      return null;
    }

    var units =
      [
        Rez.Strings.UnknownUnit,
        Rez.Strings.DistanceUnit,
        Rez.Strings.ElevationUnit,
        Rez.Strings.HeightUnit,
        Rez.Strings.SpeedUnit,
        Rez.Strings.TemperatureUnit,
        Rez.Strings.WeightUnit,
      ] as Array<Symbol>;

    return Application.loadResource(units[index as Number]) as String;
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

    mUnit = getUnitByEnumValue(mComplication[:unit] as Complications.Unit) as String?;
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
