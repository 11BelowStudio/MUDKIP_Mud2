--[[
THE AUTO-UPDATER FOR MUDKIP_Mud2

heavily ripped off from https://forums.mudlet.org/viewtopic.php?p=20504
(DSL PNP 4.0 Main Script, Zachary Hiland, 2/09/2014)

Shoutouts to demonnic for providing the lua code to actually get the package installed and such

]]--

local M2Updates = MUDKIP_Mud2.updates

local defaults = {
	download_path = "https://github.com/11BelowStudio/MUDKIP_Mud2/releases/latest/download/",
	package_name = "MUDKIP_Mud2",
	package_url = "",
	version_check_download = "version.txt",
	version_url = "",
	file_path = "",
	version_check_save = "dl_version.txt"--,
	--versions_file_name = "version.txt",
}
defaults.package_url = defaults.download_path .. defaults.package_name .. ".mpackage"
defaults.version_url = defaults.download_path .. defaults.version_check_download
defaults.file_path = getMudletHomeDir() .. "/".. defaults.package_name .. "/"
defaults.temp_file_path = getMudletHomeDir() .. "/" .. defaults.package_name ..  "_temp" .. "/"

local download_queue = download_queue or {}
local downloading = false
local available = {}
local unavailable = {}
local scripts_list = {}
local init_list = {}
local event_list = {}

--[[
Attempts to open a file to read/write/append/modify.

If file could be read, returns table of file {name:str,mode:str,type:"fileIO_file",contents:{str}} and a nil
If it couldn't be read, returns a nil and a string with info about the error.
]]
local function fileOpen(filename,mode)
	local errors
	mode = mode or "read"
	assert(table.contains({"read","write","append","modify"},mode),"Invalid mode: must be 'read', 'write', 'append', or 'modify'.")
	if mode ~= "write" then
		local info = lfs.attributes(filename)
		if not info then
			errors = "Invalid filename: no such file."
			return nil, errors
		end
		if info.mode ~= "file" then
			errors = "Invalid filename: path points to a directory."
			return nil, errors
		end
	end
	local file = {}
	file.name = filename
	file.mode = mode
	file.type = "fileIO_file"
	file.contents = {}
	if file.mode == "read" or file.mode == "modify" then
		local tmp = io.open(file.name,"r")
		local linenum = 1
		for line in tmp:lines() do
			file.contents[linenum] = line
			linenum = linenum + 1
		end
		tmp:close()
	end
	--setmetatable(file,MUDKIP_Mud2.fileIO)
	return file, nil
end

local function fileClose(file)
	assert(file.type == "fileIO_file", "Invalid file: must be file returned by fileIO.open.")
	local tmp
	if file.mode == "write" then
		tmp = io.open(file.name,"w")
	elseif file.mode == "append" then
		tmp = io.open(file.name,"a")
	elseif file.mode == "modify" then
		tmp = io.open(file.name,"w+")
	end
	if tmp then
		for k,v in ipairs(file.contents) do
			tmp:write(v .. "\n")
		end
		tmp:flush()
		tmp:close()
		tmp = nil
	end
	return true
end

-- THIS FUNCTION INITIALIZES SCRIPTS, GETS CALLED ON CONNECT/RECONNECT
function M2Updates:initialize()

  --[[
	--init_list = table.n_union(defaults.initialize, MUDKIP_Mud2.config.initialize or {})
	--event_list = table.n_union(defaults.connect_events, MUDKIP_Mud2.config.connect_events or {})
	-- run required events
	for k,v in ipairs(event_list) do
		raiseEvent(v)
	end
	-- initialize scripts
	for k,v in ipairs(init_list) do
		raiseEvent("onConfig",v)
	end
  --]]
end


-- is M2Updates currently running an auto update?
M2Updates.is_updating = false

-- checks if we're currently running an auto update.
function M2Updates:isUpdating()
	return self.is_updating
end

local function load_package_xml(path)


	if path ~= defaults.temp_file_path .. defaults.package_name.. ".xml" then
		-- if this isn't the updated version of MUDKIP_Mud2, we don't do anything.
		return
		--[[
		if MUDKIP_Mud2 then
			MUDKIP_Mud2:mcecho("Given unexpected .xml file (".. path .."), aborting! (please install the update manually.)", "error")
		else
			cecho("\n<b><ansiLightRed>ERROR</b><reset> - Given unexpected .xml file (".. path .."), aborting! (please install the update manually.)\n")
			return
		end
		]]
	end

	M2Updates.is_updating = true
	-- uninstall old package
	uninstallPackage(defaults.package_name)

	-- wipe old package variables etc from memory
	_G.MUDKIP_Mud2 = nil

	-- install new package
	tempTimer(1, function()
		installPackage(path)
		os.remove(path)
		lfs.rmdir(defaults.temp_file_path)
	end)
end

local function load_package_mpackage(path)

	if path ~= defaults.temp_file_path .. defaults.package_name.. ".mpackage" then
		return
		-- if this isn't the updated version of MUDKIP_Mud2, we don't do anything.
		--[[
		if MUDKIP_Mud2 then
			MUDKIP_Mud2:mcecho("Given unexpected .mpackage file (".. path .."), aborting! (please install the update manually.)", "error")
		else
			cecho("\n<b><ansiLightRed>ERROR</b><reset> - Given unexpected .mpackage file (".. path .."), aborting! (please install the update manually.)\n")
			return
		end
		--]]
	end

	M2Updates.is_updating = true

	-- uninstall old package
	uninstallPackage(defaults.package_name)

	-- wipe old package variables etc from memory
	_G.MUDKIP_Mud2 = nil

	-- install new package
	tempTimer(1, function()
		installPackage(path)
		--installPackage(defaults.temp_file_path .. defaults.package_name .. ".mpackage")
		os.remove(path)
		lfs.rmdir(defaults.temp_file_path)
	end)
	--installPackage(defaults.download_path .. defaults.package_name .. ".mpackage")
end




local function start_download()
	-- get info from queue
	local info = download_queue[1]
  if MUDKIP_Mud2 then
		MUDKIP_Mud2:mcecho("Downloading remote file " .. info[2] .. " to " .. info[1], "info")
	else
		cecho("\n<b><ansiLightYellow>INFO</b><reset> - Downloading remote version file " .. info[2] .. " to " .. info[1] .. "\n")
	end
	if info then
		local path, address = info[1], info[2]
		-- remove current item from queue
		table.remove(download_queue,1)
		-- begin download
		downloadFile(path,address)
		downloading = true
	else
		--load_scripts()
	end
end

local function queue_download(path, address)
	-- add item to queue
	table.insert(download_queue, {path, address})
	if not downloading then
		-- start new download if none in progress
		start_download()
	end
end


-- turns a semantic version number string (such as 1.1.1) into a table of {number,number,number}
local function semantic_version_splitter(_version_string)
	local t = {}
	for k, v in string.gmatch(_version_string, "([^.]+)") do
		table.insert(t,tonumber(k))
	end
	return t
end

-- compares two semantic version numbers.
-- returns true if _installed < _remote, otherwise returns false
local function compare_versions(_installed, _remote)
	local current = semantic_version_splitter(_installed)
	local remote = semantic_version_splitter(_remote)

	local remote_newer = false

	if current[1] < remote[1] then
		remote_newer = true
	elseif current[1] == remote[1] then
		if current[2] < remote[2] then
			remote_newer = true
		elseif current[2] == remote[2] then
			remote_newer = current [3] < remote[3]
		end
	end

	return remote_newer

end


local function get_version_check()
	-- create MUDKIP_Mud2 folder in Mudlet home directory if necessary
	lfs.mkdir(defaults.file_path)
	-- download current version info
	queue_download(defaults.file_path .. defaults.version_check_save, defaults.download_path .. defaults.version_check_download)
end

local function check_versions()

	

	--local version_path = defaults.file_path .. defaults.versions_file_name
	local dl_path = defaults.file_path .. defaults.version_check_save
	local dl_version, curr_version
	local dl_file, dl_errors--, version_file
	
	
	-- read in check file
	dl_file, dl_errors = fileOpen(dl_path,"read")

	if dl_file == nil then
		-- if something's gone AWOL and we couldn't read the file
		if MUDKIP_Mud2 then
			MUDKIP_Mud2:mcecho("Could not read remote version info file, aborting auto-update routine. (".. dl_errors ..")", "error")
		else
			cecho("\n<b><ansiLightRed>ERROR</b><reset> - Could not read remote version info file, aborting auto-update routine. (".. dl_errors ..")\n")
			return
		end
	end

  curr_version = getPackageInfo(defaults.package_name,"version") --version_file.contents[1]
  dl_version = dl_file.contents[1]

  if MUDKIP_Mud2 then
    MUDKIP_Mud2:mcecho("installed " .. curr_version .."; remote " .. dl_version .. ";", "info")
  else
    cecho("\n<b><ansiLightYellow>INFO</b><reset> - installed " .. curr_version .."; remote " .. dl_version .. ";\n")
  end

	-- close the files (we don't need them any more)
	--fileClose(version_file)
	fileClose(dl_file)

	os.remove(dl_path)
  
  if compare_versions(curr_version, dl_version) then
		if MUDKIP_Mud2 then
			MUDKIP_Mud2:mcecho("Attempting to update MUDKIP to v" .. dl_version.. "", "info")
		else
			cecho("\n<b><ansiLightYellow>INFO</b><reset> - Attempting to update MUDKIP to v" .. dl_version .."\n")
		end
		M2Updates:update_package()
    --update_the_package()
	else
		if MUDKIP_Mud2 then
			MUDKIP_Mud2:mcecho("MUDKIP_Mud2 is up-to-date, have a nice day :)", "info")
		else
			cecho("\n<b><ansiLightYellow>INFO</b><reset> - MUDKIP_Mud2 is up-to-date, have a nice day :)\n")
		end
  end

	

end

local function finish_download(path)
	-- start next download in queue
	if download_queue[1] then
		start_download()
	else
		downloading = false
	end
	-- run version checking once file downloaded
	if string.find(path,defaults.version_check_save) then
		check_versions()
	elseif string.find(path,".mpackage") then
		load_package_mpackage(path)
  elseif string.find(path,".xml") then
		load_package_xml(path)
	end
end

local function fail_download(...)
	-- begin next download
	start_download()
	-- add failed download to list of unavailable scripts
	if MUDKIP_Mud2 then
		MUDKIP_Mud2:mcecho("failed downloading " .. arg[2] .. arg[1], "error")
	else
		cecho("\n<b><ansiLightRed>ERROR</b><reset> - failed downloading " .. arg[2] .. arg[1].. "\n")
	end

	--table.insert(unavailable, arg[1])
end

function M2Updates:update_package()
	-- create MUDKIP_Mud2_temp folder in Mudlet home directory if necessary
	lfs.mkdir(defaults.temp_file_path)
	-- download newest package
	queue_download(defaults.temp_file_path .. defaults.package_name .. ".mpackage", defaults.download_path .. defaults.package_name .. ".mpackage")
end

function M2Updates:update_scripts()
	get_version_check()
end


function M2Updates:eventHandler(event, ...)
	if event == "sysLoadEvent" then
		M2Updates:update_scripts()
	elseif event == "sysDownloadDone" then
		finish_download(...)
	elseif event == "sysDownloadError" then
		fail_download(...)
	end
end

--[[
function M2Updates:sysInstallEvent(_, name)
  -- stop if what got installed isn't our package
  if name ~= defaults.package_name then return end

  M2Updates:update_scripts()
end
]]

M2Updates:update_scripts()

--registerAnonymousEventHandler("sysLoadEvent", "MUDKIP_Mud2.updates:update_scripts()")

registerAnonymousEventHandler("sysDownloadDone", "MUDKIP_Mud2.updates:eventHandler")
registerAnonymousEventHandler("sysDownloadError", "MUDKIP_Mud2.updates:eventHandler")

