import Toybox.Lang;

module Types {
  module Components {
    typedef ArcParams as {
      :controller as Types.Controllers.Id,
      :radius as Number,
      :updateInterval as Number,
    };

    typedef IconParams as {
      :controller as Types.Controllers.Id,
      :updateInterval as Number,
    };

    typedef LabeledValueParams as {
      :controller as Types.Controllers.Id,
      :hideUnit as Boolean,
      :updateInterval as Number,
    };

    typedef ProgressBarParams as {
      :controller as Types.Controllers.Id,
      :hideLabel as Boolean,
      :updateInterval as Number,
    };

    typedef ValueParams as {
      :controller as Types.Controllers.Id,
      :hideUnit as Boolean,
      :updateInterval as Number,
    };
  }
}
