
--[[
	We setup the global table for our mod, along with some path variables, and a data table.
	We cache the ModPath directory, so that when our hooks are called, we aren't using the ModPath from a
		different mod.
]]
SoloHeisterHelper = SoloHeisterHelper or {}
SoloHeisterHelper._path = ModPath
SoloHeisterHelper.options_path = SavePath .. "SoloHeisterHelper.txt"
SoloHeisterHelper.options = {} 

--[[
	A simple save function that json encodes our options table and saves it to a file.
]]
function SoloHeisterHelper:Save()
	local file = io.open( self.options_path, "w+" )
	if file then
		file:write( json.encode( self.options ) )
		file:close()
	end
end

--[[
	A simple load function that decodes the saved json options table if it exists.
]]
function SoloHeisterHelper:Load()
	local file = io.open( self.options_path, "r" )
	if file then
		self.options = json.decode( file:read("*all") )
		file:close()
	else
	log("No previous save found. Creating new using default values")
	local default_file = io.open(self._path .."default_values.txt")
		if default_file then
			self.options = json.decode( default_file:read("*all") )
			self:Save()
		end
	end
end

if not SoloHeisterHelper.setup then
	SoloHeisterHelper:Load()
	SoloHeisterHelper.setup = true
	log("Menu Restore loaded")
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_SoloHeisterHelper", function( loc )
	loc:load_localization_file( SoloHeisterHelper._path .. "Loc/english.txt")
end)

--[[
	Setup our menu callbacks, load our saved data, and build the menu from our json file.
]]
Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_SoloHeisterHelper", function( menu_manager )

	--[[
		Setup our callbacks as defined in our item callback keys, and perform our logic on the data retrieved.
	]]

	MenuCallbackHandler.callback_intim_amount = function(self, item)
		SoloHeisterHelper.options.intim_amount = item:value()
		SoloHeisterHelper:Save()
	end

	--[[
		Load our previously saved data from our save file.
	]]
	SoloHeisterHelper:Load()

	--[[
		Load our menu json file and pass it to our MenuHelper so that it can build our in-game menu for us.
		We pass our parent mod table as the second argument so that any keybind functions can be found and called
			as necessary.
		We also pass our data table as the third argument so that our saved values can be loaded from it.
	]]
	MenuHelper:LoadFromJsonFile( SoloHeisterHelper._path .. "Menu/menu.txt", SoloHeisterHelper, SoloHeisterHelper.options )

end )
