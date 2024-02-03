import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TimeFieldView extends WatchUi.Drawable {
  hidden var controller as Types.ValueController;

  public function initialize(params as Types.ViewParams) {
    controller = Utils.Controller.getController(params[:controller]);
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    var timeFont = Graphics.FONT_LARGE;
    var value = controller.getValue();

    dc.setColor(Constants.Color.BACKGROUND, Constants.Color.BACKGROUND);
    dc.setClip(locX - width / 2, locY - height / 2, width, height);
    dc.clear();

    dc.setColor(Constants.Color.PRIMARY, Constants.Color.BACKGROUND);
    dc.drawText(
      locX,
      locY,
      timeFont,
      value,
      Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
    );
  }
}