SoloHeisterHelper = SoloHeisterHelper or {}
SoloHeisterHelper._path = ModPath
SoloHeisterHelper.options_path = SavePath .. "SoloHeisterHelper.txt"
SoloHeisterHelper.options = {}
SoloHeisterHelper._menu_path = ModPath .. 'menu.txt'

local cable_amount = SoloHeisterHelper.options.cable_amount
local tweaker = UpgradesTweakData.init
function UpgradesTweakData:init(tweak_data)
	tweaker(self, tweak_data)
	self.values.cable_tie.quantity_1 = {cable_amount}
end