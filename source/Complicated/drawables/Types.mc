import Toybox.Lang;

module Complicated {
  module Types {
    typedef ComplicationDrawableParams as {
      :identifier as String,
      // :complication as Complication,
      :x as Number,
      :y as Number,
      :height as Number,
      :width as Number,
    };

    typedef UpdateModel as Value;

    typedef ModelUpdater as interface {
      //! Function that provides updated data for the Model
      function getModel() as UpdateModel;
    };
  }
}
