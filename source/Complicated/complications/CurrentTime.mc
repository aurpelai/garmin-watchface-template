import Toybox.Application;
import Toybox.Lang;
import Toybox.Time;

module Complicated {
  class CurrentTime {
    var model as Value = new Value(Application.loadResource(Rez.Strings.UnknownTime) as String);

    function getValue() as String {
      return Utils.Time.getFormattedTimeFromMoment(Time.now());
    }

    public function updateModel() as Types.UpdateModel {
      var value = getValue();
      model.updateValue(value);

      return model;
    }
  }
}
