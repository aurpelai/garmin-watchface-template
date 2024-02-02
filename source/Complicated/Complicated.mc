import Toybox.Lang;

module Complicated {
  enum Complication {
    CURRENT_TIME,
  }

  typedef ComplicationDrawableParams as {
    :identifier as String,
    :controller as Complication,
    :x as Number,
    :y as Number,
    :height as Number,
    :width as Number,
  };

  function getController(_complication as Complication) as Types.ValueController or Types.Controller {
    var complicationMap = ({
      CURRENT_TIME => new CurrentTimeController(),
    }) as Dictionary<Complication, Types.Controller>;

    var complication = complicationMap[_complication];

    return complication as Types.Controller;
  }
}
