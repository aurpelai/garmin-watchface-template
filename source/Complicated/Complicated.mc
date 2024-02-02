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
  function getComplication(_complication as Complication) as Types.ModelUpdater {
    var complicationMap = {
      CURRENT_TIME => new CurrentTime(),
    } as Dictionary<Complication, Types.ModelUpdater>;

    var complication = complicationMap[_complication];

    return complication as Types.ModelUpdater;
  }
}
