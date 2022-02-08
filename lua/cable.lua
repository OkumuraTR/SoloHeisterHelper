SoloHeisterHelper = SoloHeisterHelper or {}
SoloHeisterHelper._path = ModPath
SoloHeisterHelper.options_path = SavePath .. "SoloHeisterHelper.txt"
SoloHeisterHelper.options = {}
SoloHeisterHelper._menu_path = ModPath .. 'menu.txt'

local cableAmount = SoloHeisterHelper.options.cable_amount
if RequiredScript == "lib/tweak_data/upgradestweakdata" then
		local old_init_pd2_values = UpgradesTweakData._init_pd2_values
		function UpgradesTweakData:_init_pd2_values(...)
			old_init_pd2_values(self, ...)
            self.values.cable_tie.quantity_1 = {cableAmount}
            self.values.cable_tie.quantity_2 = {cableAmount}
		end
end
