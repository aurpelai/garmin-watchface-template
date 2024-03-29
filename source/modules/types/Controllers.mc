import Toybox.Complications;
import Toybox.Lang;
import Toybox.WatchUi;

module Types {
  module Controllers {
    enum Id {
      BATTERY,
      BLUETOOTH_STATUS,
      CALORIES,
      CURRENT_TIME,
      HEART_RATE,
      SECONDS,
      STEPS,
    }

    typedef ComplicationUpdater as (Method(id as Complications.Id) as Void);

    typedef ComplicationControllerDictionary as Dictionary<Complications.Type, ComplicationUpdater>;

    typedef ComplicationDict as Dictionary<
      Complications.Type,
      Types.Controllers.EverythingController
    >;

    typedef EverythingController as interface {
      function getAngle() as Number;
      function getIcon() as BitmapResource?;
      function getId() as Types.Controllers.Id?;
      function getLabel() as String;
      function getProgress() as Number?;
      function getUnit() as String;
      function getValue() as String or Number;
      function shouldDraw() as Boolean;
    };
  }
}
