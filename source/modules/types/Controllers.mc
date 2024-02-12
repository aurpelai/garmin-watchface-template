import Toybox.Complications;
import Toybox.Lang;
import Toybox.WatchUi;

module Types {
  module Controllers {
    enum Id {
      BLUETOOTH_STATUS,
      CALORIES,
      CURRENT_TIME,
      SECONDS,
      STEPS,
    }

    typedef ComplicationCallbackFunction as (Method(complicationId as Complications.Id) as Void);

    typedef ComplicationsControllerDictionary as Dictionary<
      Complications.Type,
      ComplicationCallbackFunction
    >;

    typedef EverythingController as interface {
    function getAngle() as Numeric;
    function getIcon() as BitmapResource?;
    function getLabel() as String;
    function getProgress() as Numeric?;
    function getUnit() as String?;
    function getValue() as String or Numeric;
    function shouldDraw() as Boolean;
  };
  }
}
