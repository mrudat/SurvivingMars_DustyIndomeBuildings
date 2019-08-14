return PlaceObj('ModDef', {
	'title', "Dusty Indome Buildings",
	'description', "Allows building dust generating buildings (mostly mines) indoors.\n\nGiven that dust is generated inside a sealed environment, dust is spread evenly across all buildings inside the dome, rather than in a circle around the building generating dust. Reverts to vanilla behaviour if the dome is opened.\n\nPermission is granted to update this mod to support the latest version of the game if I'm not around to do it myself.",
	'image', "preview.png",
	'last_changes', "Dust visualisation radius = dome radius.",
	'dependencies', {
		PlaceObj('ModDependency', {
			'id', "mrudat_AllowBuildingInDome",
			'title', "Allow Building In Dome",
		}),
	},
	'id', "mrudat_DustyIndomeBuildings",
	'steam_id', "1833070549",
	'pops_desktop_uuid', "38edbbbd-054a-4706-b06b-746e9ea14748",
	'pops_any_uuid', "41da3e3a-b50c-4183-bb32-a64d686f663a",
	'author', "mrudat",
	'version', 5,
	'lua_revision', 233360,
	'saved_with_revision', 245618,
	'code', {
		"Code/DustyIndomeBuildings.lua",
	},
	'saved', 1565648129,
})
