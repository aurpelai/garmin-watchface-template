import Toybox.Complications;
import Toybox.Lang;

module Exceptions {
  class InvalidIdentifierException extends Lang.Exception {
    function initialize(msg as String) {
      Exception.initialize();
      self.mMessage = "No case for '" + msg + "'";
    }
  }

  class ComplicationCallbackMissingException extends Lang.Exception {
    function initialize(type as Complications.Type) {
      Exception.initialize();
      self.mMessage = "No callback registered for complication type '" + type + "'";
    }
  }
}
