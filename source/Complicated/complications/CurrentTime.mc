import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

module Complicated {
  class CurrentTime {
    var model as Value = new Value(Application.loadResource(Rez.Strings.UnknownTime) as String);

    function getCurrentTime() as String {
      return Utils.Time.getFormattedTimeFromMoment(Time.now(), false);
    }

    public function getModel() as Types.UpdateModel {
      var value = getCurrentTime();
      model.updateValue(value);

      return model;
    }
  }
}
