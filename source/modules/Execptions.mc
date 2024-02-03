import Toybox.Lang;

module Exceptions {
  class InvalidControllerIdentifierException extends Lang.Exception {
    function initialize(msg as String) {
      Exception.initialize();
      self.mMessage = "No case for '" + msg + "'";
    }
  }
}
