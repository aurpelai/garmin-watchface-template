import Toybox.Lang;

module Types {
  enum MenuItemType {
    MENU_ITEM_TOGGLE,
  }

  typedef ToggleMenuItemParams as {
    :id as String,
    :label as String,
    :type as Types.MenuItemType,
  };

  typedef MenuItemParams as ToggleMenuItemParams;
}
