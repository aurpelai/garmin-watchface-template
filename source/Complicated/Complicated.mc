import Toybox.Lang;

module Complicated {
  enum ControllerIdentifier {
    CURRENT_TIME,
  }

  typedef ViewParams as {
    :identifier as String,
    :controller as Complication,
    :x as Number,
    :y as Number,
    :height as Number,
    :width as Number,
  };

  function getController(
    _complication as ControllerIdentifier
  ) as Types.Controller {
    var controllerMap =
      ({
        CURRENT_TIME => new CurrentTimeController(),
      }) as Dictionary<ControllerIdentifier, Types.Controller>;

    var controller = controllerMap[_complication];

    return controller as Types.Controller;
  }
}
