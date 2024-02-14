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

  class MissingDictionaryValueException extends Lang.Exception {
    function initialize(dictionaryName as String, keyName as String) {
      Exception.initialize();
      self.mMessage = "Missing symbol [" + keyName + "] in dictionary '" + dictionaryName + "'.";
    }
  }
}
