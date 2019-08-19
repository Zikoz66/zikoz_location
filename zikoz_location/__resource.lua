resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

name 'NativeUILua-Reloaded'
description 'NativeUILua-Reloaded is UI library for FiveM designed specifically for making interface based on GTA:Online style. (Base source: https://github.com/FrazzIe/NativeUILua ) | (Base NativeUI : https://github.com/Guad/NativeUI) '

server_scripts {
    'server/zikoz-s.lua',
    'config.lua'
}

client_scripts {

    'Wrapper/Utility.lua',

    'UIElements/UIVisual.lua',
    'UIElements/UIResRectangle.lua',
    'UIElements/UIResText.lua',
    'UIElements/Sprite.lua',

    'UIMenu/elements/Badge.lua',
    'UIMenu/elements/Colours.lua',
    'UIMenu/elements/ColoursPanel.lua',
    'UIMenu/elements/StringMeasurer.lua',

    'UIMenu/items/UIMenuItem.lua',
    'UIMenu/items/UIMenuCheckboxItem.lua',
    'UIMenu/items/UIMenuListItem.lua',
    'UIMenu/items/UIMenuSliderItem.lua',
    'UIMenu/items/UIMenuSliderHeritageItem.lua',
    'UIMenu/items/UIMenuColouredItem.lua',

    'UIMenu/items/UIMenuProgressItem.lua',
    'UIMenu/items/UIMenuSliderProgressItem.lua',

    'UIMenu/windows/UIMenuHeritageWindow.lua',

    'UIMenu/panels/UIMenuGridPanel.lua',
    'UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua',
    'UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua',
    'UIMenu/panels/UIMenuColourPanel.lua',
    'UIMenu/panels/UIMenuPercentagePanel.lua',
    'UIMenu/panels/UIMenuStatisticsPanel.lua',

    'UIMenu/UIMenu.lua',
    'UIMenu/MenuPool.lua',

    'NativeUI.lua',

    'client/zikoz-m.lua',
    'config.lua'
}
