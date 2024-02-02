import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

module Complicated {
  class TimeFieldDrawable extends WatchUi.Drawable {
    hidden var modelUpdater as Types.ModelUpdater;

    public function initialize(params as ComplicationDrawableParams) {
      modelUpdater = getComplication(params[:complication]);
      Drawable.initialize(params);
    }

    function draw(dc as Dc) as Void {
      var timeFont = Graphics.FONT_LARGE;
      var model = modelUpdater.updateModel();

      if (model instanceof Value) {
        dc.setColor(Constants.Color.BACKGROUND, Constants.Color.BACKGROUND);
        dc.setClip(locX - (width / 2), locY - (height / 2), width, height);
        dc.clear();

        dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
        dc.drawText(
          locX,
          locY,
          timeFont,
          model.value,
          Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
      }
    }
  }
}
