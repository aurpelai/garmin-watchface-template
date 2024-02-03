import Toybox.Lang;

module Complicated {
  module Types {
    typedef ValueController as interface {
      // Function that provides updated data for the View
      function getValue() as String;
    };

    typedef LabeledValueController as interface {
      // Function that provides updated data for the View
      function getValue() as String;
      // Function that provides an updated label for the View
      function getLabel() as String;
    };

    typedef Controller as ValueController or LabeledValueController;
  }
}
