import Toybox.Complications;
import Toybox.Lang;
import Toybox.WatchUi;

module Types {
  module Controllers {
    enum Id {
      BLUETOOTH_STATUS = "BluetoothStatus",
      CALORIES = "Calories",
      CURRENT_TIME = "CurrentTime",
      SECONDS = "Seconds",
      STEPS = "Steps",
    }

    typedef ComplicationCallbackFunction as (Method(complicationId as Complications.Id) as Void);

    typedef ComplicationsControllerDictionary as Dictionary<
      Complications.Type,
      ComplicationCallbackFunction
    >;

    typedef ValueController as interface {
      function getValue() as String;
    };

    typedef LabeledValueController as interface {
      function getValue() as String;
      function getLabel() as String;
    };

    typedef IconController as interface {
      function getIcon() as WatchUi.BitmapResource;
      function getLabel() as String;
      function getValue() as String;
      function shouldDraw() as Boolean;
    };

    typedef ArcController as interface {
      function getAngle() as Number;
      function getLabel() as String;
      function getValue() as String;
      function shouldDraw() as Boolean;
    };

    typedef LayoutController as ArcController or
      IconController or
      LabeledValueController or
      ValueController;
  }
}
