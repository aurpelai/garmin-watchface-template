import Toybox.Lang;

module Types {
  module Components {
    typedef ArcParams as {
      :controller as Types.Controllers.Id,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :radius as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef IconParams as {
      :controller as Types.Controllers.Id,
      :height as Number,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef LabeledValueParams as {
      :controller as Types.Controllers.Id,
      :height as Number,
      :hideUnit as Boolean,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef ProgressBarParams as {
      :controller as Types.Controllers.Id,
      :height as Number,
      :hideLabel as Boolean,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };

    typedef ValueParams as {
      :controller as Types.Controllers.Id,
      :height as Number,
      :hideUnit as Boolean,
      :identifier as String,
      :locX as Number,
      :locY as Number,
      :updateInterval as Number,
      :width as Number,
    };
  }
}
