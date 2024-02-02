import Toybox.Graphics;
import Toybox.Lang;

module Complicated {
  class TimeFieldDrawable extends BaseDrawable {
    public function initialize(params as Types.ComplicationDrawableParams) {
      BaseDrawable.initialize(params);
    }

    function draw(dc as Dc) as Void {
      var timeFont = Graphics.FONT_LARGE;
      var model = mComplication.getModel();

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
