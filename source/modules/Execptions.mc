import Toybox.Complications;
import Toybox.Lang;

module Exceptions {
  class InvalidControllerIdException extends Lang.Exception {
    function initialize(msg as String) {
      Exception.initialize();
      self.mMessage = "No case for '" + msg + "'";
    }
  }

  class InvalidPropertyIdException extends Lang.Exception {
    function initialize(id as String) {
      Exception.initialize();
      self.mMessage = "Invalid property id '" + id + "' given!";
    }
  }

  class InvalidSettingPropertyOptionException extends Lang.Exception {
    function initialize(msg as String) {
      Exception.initialize();
      self.mMessage = "Invalid setting property option: '" + msg + "'.";
    }
  }

  class ComplicationCallbackMissingException extends Lang.Exception {
    function initialize(type as Complications.Type) {
      Exception.initialize();
      self.mMessage = "No callback registered for complication type '" + type + "'";
    }
  }
}
