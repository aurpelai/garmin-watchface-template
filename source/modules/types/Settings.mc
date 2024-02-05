import Toybox.Lang;

module Types {
  module Settings {
    enum MenuItemType {
      MENU_ITEM_TOGGLE,
    }

    typedef ToggleMenuItemParams as {
      :id as String,
      :label as String,
      :type as MenuItemType,
    };

    typedef MenuItemParams as ToggleMenuItemParams;
  }
}
