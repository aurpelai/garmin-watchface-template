import Toybox.Lang;

module Complicated {
    class Value extends BaseModel {
        var value as String?;

        //! @param _value a string to be displayed
        public function initialize(_value as String?) {
            BaseModel.initialize();
            value = _value;
        }

        public function updateValue(_value as String?) as Void {
            if (_value != null && !_value.equals(value)) {
                value = _value;
            }
        }
    }
}
