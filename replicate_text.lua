obs = obslua

-- Replicate A Text Label
-- By Phoebe Zeitler
-- phoebe.zeitler@gmail.com 

-- begin properties variables
source_name       = ""
target_0_name     = ""
target_1_name     = ""
target_2_name     = ""
target_3_name     = ""
target_4_name     = ""
target_5_name     = ""
target_6_name     = ""
target_7_name     = ""
target_8_name     = ""
target_9_name     = ""
-- end properties variables

-- begin OBS required functions

-- A function named script_properties defines the properties that the user
-- can change for the entire script module itself
function script_properties()
  local props = obs.obs_properties_create()
  
      local origin = obs.obs_properties_add_list(props, "source_name", "Origin Text Source", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target0 = obs.obs_properties_add_list(props, "target_0_name", "Target Text 1", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target1 = obs.obs_properties_add_list(props, "target_1_name", "Target Text 2", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target2 = obs.obs_properties_add_list(props, "target_2_name", "Target Text 3", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target3 = obs.obs_properties_add_list(props, "target_3_name", "Target Text 4", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target4 = obs.obs_properties_add_list(props, "target_4_name", "Target Text 5", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target5 = obs.obs_properties_add_list(props, "target_5_name", "Target Text 6", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target6 = obs.obs_properties_add_list(props, "target_6_name", "Target Text 7", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target7 = obs.obs_properties_add_list(props, "target_7_name", "Target Text 8", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target8 = obs.obs_properties_add_list(props, "target_8_name", "Target Text 9", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	  local target9 = obs.obs_properties_add_list(props, "target_9_name", "Target Text 10", obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)
	local sources = obs.obs_enum_sources()
	if sources ~= nil then
		for _, source in ipairs(sources) do
			source_id = obs.obs_source_get_id(source)
			if source_id == "text_gdiplus" or source_id == "text_ft2_source" then
				local name = obs.obs_source_get_name(source)
				obs.obs_property_list_add_string(origin, name, name)
				obs.obs_property_list_add_string(target0, name, name)
				obs.obs_property_list_add_string(target1, name, name)
				obs.obs_property_list_add_string(target2, name, name)
				obs.obs_property_list_add_string(target3, name, name)
				obs.obs_property_list_add_string(target4, name, name)
				obs.obs_property_list_add_string(target5, name, name)
				obs.obs_property_list_add_string(target6, name, name)
				obs.obs_property_list_add_string(target7, name, name)
				obs.obs_property_list_add_string(target8, name, name)
				obs.obs_property_list_add_string(target9, name, name)
			end
		end
	end
	obs.source_list_release(sources)
	
	return props
end

-- A function named script_defaults will be called to set the default settings
function script_defaults(settings)
	
end

-- A function named script_description returns the description shown to
-- the user
function script_description()
	return "Replicates the contents of one text source into up to 10 others. \n\nAuthor: Phoebe Zeitler (See source for additional code acknowledgements)"
end
	
function script_update(settings)
	source_name = obs.obs_data_get_string(settings, "source_name")
	target_0_name = obs.obs_data_get_string(settings, "target_0_name")
	target_1_name = obs.obs_data_get_string(settings, "target_1_name")
	target_2_name = obs.obs_data_get_string(settings, "target_2_name")
	target_3_name = obs.obs_data_get_string(settings, "target_3_name")
	target_4_name = obs.obs_data_get_string(settings, "target_4_name")
	target_5_name = obs.obs_data_get_string(settings, "target_5_name")
	target_6_name = obs.obs_data_get_string(settings, "target_6_name")
	target_7_name = obs.obs_data_get_string(settings, "target_7_name")
	target_8_name = obs.obs_data_get_string(settings, "target_8_name")
	target_9_name = obs.obs_data_get_string(settings, "target_9_name")
	reset()
end

-- end OBS required functions

-- begin application-specific functions

function reset()
    if timer_deployed then
		obs.timer_remove(timer_callback)
	end
	
	obs.timer_add(timer_callback, 100)
	timer_deployed = true
end

function timer_callback()
	local text_to_display = ""
	local source = obs.obs_get_source_by_name(source_name)
	if source ~= nil then
		local settings = obs.obs_source_get_settings(source)
		text_to_display = obs.obs_data_get_string(settings, "text")
		obs.obs_data_release(settings)
		obs.obs_source_release(source)
	end
	
	--print("Source " .. source_name .. " shows text " .. text_to_display)
	update_source(target_0_name, text_to_display)
	update_source(target_1_name, text_to_display)
	update_source(target_2_name, text_to_display)
	update_source(target_3_name, text_to_display)
	update_source(target_4_name, text_to_display)
	update_source(target_5_name, text_to_display)
	update_source(target_6_name, text_to_display)
	update_source(target_7_name, text_to_display)
	update_source(target_8_name, text_to_display)
	update_source(target_9_name, text_to_display)
	
end

function update_source(target_name, text_to_display)
	local source = obs.obs_get_source_by_name(target_name)
	if source ~= nil then
	
		--print("updating source " .. target_name .. " to read " .. text_to_display)
		local settings = obs.obs_data_create()
		obs.obs_data_set_string(settings, "text", text_to_display)
		obs.obs_source_update(source, settings)
		obs.obs_data_release(settings)
		obs.obs_source_release(source)
	end
end