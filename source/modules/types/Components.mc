import Toybox.Lang;

module Types {
  module Components {
    typedef ArcComponentParams as {
      :controller as Types.Controllers.ControllerType,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :radius as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef IconComponentParams as {
      :controller as Types.Controllers.ControllerType,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef ValueComponentParams as {
      :controller as Types.Controllers.ControllerType,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef LabeledValueComponentParams as {
      :controller as Types.Controllers.ControllerType,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };
  }
}
