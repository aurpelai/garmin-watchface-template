import Toybox.Lang;
import Toybox.Graphics;

module Types {
  typedef ComponentParams as {
    :controller as Controllers.Identifier,
    :font as Graphics.FontDefinition,
    :height as Number,
    :identifier as String,
    :locX as Number,
    :locY as Number,
    :updateInterval as Number,
    :width as Number,
  };
}
