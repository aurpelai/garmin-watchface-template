import Toybox.Lang;

module Complicated {
  enum Complication {
    CURRENT_TIME,
  }

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
