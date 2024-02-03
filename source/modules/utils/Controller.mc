import Toybox.Lang;
import Toybox.System;
import Exceptions;

module Utils {
  module Controller {
    function getController(
      _controller as Controllers.Identifier
    ) as Types.Controller? {
      switch (_controller) {
        case Controllers.CURRENT_TIME:
          return new CurrentTimeController();
        default:
          throw new Exceptions.InvalidControllerIdentifierException(
            _controller as String
          );
      }
    }
  }
}
