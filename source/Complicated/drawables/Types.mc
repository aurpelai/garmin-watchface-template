import Toybox.Lang;

module Complicated {
  module Types {
    typedef UpdateModel as Value;

    typedef ModelUpdater as interface {
      //! Function that provides updated data for the Model
      function updateModel() as UpdateModel;
    };
  }
}
