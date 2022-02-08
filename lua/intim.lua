SoloHeisterHelper = SoloHeisterHelper or {}
SoloHeisterHelper._path = ModPath
SoloHeisterHelper.options_path = SavePath .. "SoloHeisterHelper.txt"
SoloHeisterHelper.options = {}
SoloHeisterHelper._menu_path = ModPath .. 'menu.txt'

function GroupAIStateBase:has_room_for_police_hostage()
	local intimAmount = SoloHeisterHelper.options.intim_amount
	local nr_hostages_allowed = intimAmount

	for u_key, u_data in pairs(self._player_criminals) do
		if u_data.unit:base().is_local_player then
			if managers.player:has_category_upgrade("player", "intimidate_enemies") then
				nr_hostages_allowed = nr_hostages_allowed + 1
			end
		elseif u_data.unit:base():upgrade_value("player", "intimidate_enemies") then
			nr_hostages_allowed = nr_hostages_allowed + 1
		end
	end

	return nr_hostages_allowed > self._police_hostage_headcount + table.size(self._converted_police)
end