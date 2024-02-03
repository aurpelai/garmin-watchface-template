import Toybox.Lang;
import Toybox.System;
import Exceptions;

module Utils {
  module Controller {
    function getController(
      controller as Controllers.Identifier
    ) as Types.Controller? {
      switch (controller) {
        case Controllers.CURRENT_TIME:
          return new CurrentTimeController();
        default:
          throw new Exceptions.InvalidControllerIdentifierException(
            controller as String
          );
      }
    }
  }
}
