import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class TimeFieldView extends WatchUi.Drawable {
  hidden var controller as Types.ValueController;
  hidden var updated as Time.Moment;

  public function initialize(params as Types.ViewParams) {
    controller = Utils.Controller.getController(params[:controller]);
    updated = Time.now();
    Drawable.initialize(params);
  }

  function draw(dc as Graphics.Dc) as Void {
    var timeFont = Graphics.FONT_LARGE;
    var value = controller.getValue();
    updated = Time.now();

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
