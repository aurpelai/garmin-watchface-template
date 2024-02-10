import Toybox.Complications;
import Toybox.Lang;

module Exceptions {
  class InvalidControllerIdException extends Lang.Exception {
    function initialize(id as Types.Controllers.Id) {
      Exception.initialize();
      self.mMessage = "No case for '" + id + "' of Types.Controllers.Id";
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

  class InvalidTupleSizeException extends Lang.Exception {
    function initialize(length as Number) {
      Exception.initialize();
      self.mMessage = "Expected a tuple but received an array of length: " + length + ".";
    }
  }

  class ComplicationCallbackMissingException extends Lang.Exception {
    function initialize(type as Complications.Type) {
      Exception.initialize();
      self.mMessage = "No callback registered for complication type '" + type + "'";
    }
  }
}
