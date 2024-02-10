import Toybox.Graphics;
import Toybox.Time;
import Toybox.Lang;

module Utils {
  module Component {
    function getUpdateInterval(updateInterval as Number?) as Time.Duration {
      if (updateInterval == null || updateInterval <= 0) {
        return new Time.Duration(0);
      }

      return new Time.Duration(updateInterval - 1);
    }

    function clipAndClearRectangle(
      dc as Graphics.Dc,
      locX as Numeric,
      locY as Numeric,
      width as Numeric,
      height as Numeric
    ) as Void {
      dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_TRANSPARENT);
      dc.setClip(locX - width / 2, locY - height / 2, width, height);
      dc.clear();
    }
  }
}
