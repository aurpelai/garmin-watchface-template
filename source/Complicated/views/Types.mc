import Toybox.Lang;

module Complicated {
  module Types {
    typedef ValueController as interface {
    //! Function that provides updated data for the Model
    function getValue() as String;
  };

    typedef LabeledValueController as interface {
    //! Function that provides updated data for the Model
    function getValue() as String;
    function getLabel() as String;
  };

    typedef Controller as ValueController or LabeledValueController;
  }
}
