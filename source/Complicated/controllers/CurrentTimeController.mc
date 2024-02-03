import Toybox.Lang;
import Toybox.Time;

module Complicated {
  class CurrentTimeController {
    public function getValue() as String {
      return Utils.Time.getFormattedTimeFromMoment(Time.now());
    }
  }
}
