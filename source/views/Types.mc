import Toybox.Lang;

module Types {
  typedef ViewParams as {
    :identifier as String,
    :controller as Controllers.Identifier,
    :locX as Number,
    :locY as Number,
    :height as Number,
    :width as Number,
  };
}
