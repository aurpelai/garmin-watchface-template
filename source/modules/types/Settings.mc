import Toybox.Lang;

module Types {
  module Settings {
    typedef SetSubLabelCallback as (Method() as Symbol?);

    enum PropertyType {
      TOGGLE_MENU_ITEM,
      MENU_ITEM,
    }

    typedef SettingProperty as {
      :id as String,
      :label as Symbol,
      :type as PropertyType,
    };

    typedef SettingPropertyOption as {
      :id as String,
      :label as Symbol,
    };
  }
}
