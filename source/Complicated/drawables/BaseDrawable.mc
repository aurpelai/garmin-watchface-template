import Toybox.Lang;
import Toybox.WatchUi;

module Complicated {
  class BaseDrawable extends WatchUi.Drawable {
    hidden var mComplication as Types.ModelUpdater;

    //! @param _params Drawable arguments
    public function initialize(_params as Types.ComplicationDrawableParams) {
      mComplication = getComplication(_params[:complication] as Complication);

      var options = {
        :identifier => _params[:identifier] as String,
        :locX => _params[:x] as Number,
        :locY => _params[:y] as Number,
        :width => _params[:width] as Number,
        :height => _params[:height] as Number,
      };

      // Initialize superclass
      Drawable.initialize(options);
    }
  }
}
