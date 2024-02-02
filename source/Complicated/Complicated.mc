import Toybox.Lang;

module Complicated {
  enum Complication {
    CURRENT_TIME,
  }

  typedef ComplicationDrawableParams as {
    :identifier as String,
    :complication as Complication,
    :x as Number,
    :y as Number,
    :height as Number,
    :width as Number,
  };

  //! Return A complication model
  //! @param _complication The requested complication model
  //! @return Complication model class
  function getComplication(
    _complication as Complication
  ) as Types.ValueController or Types.Controller {
    var complicationMap =
      ({
        CURRENT_TIME => new CurrentTimeController(),
      }) as Dictionary<Complication, Types.Controller>;

    var complication = complicationMap[_complication];

    return complication as Types.Controller;
  }
}
