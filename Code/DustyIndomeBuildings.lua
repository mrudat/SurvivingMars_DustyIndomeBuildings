local orig_print = print
if Mods.mrudat_TestingMods then
  print = orig_print
else
  print = empty_func
end

local CurrentModId = rawget(_G, 'CurrentModId') or rawget(_G, 'CurrentModId_X')
local CurrentModDef = rawget(_G, 'CurrentModDef') or rawget(_G, 'CurrentModDef_X')
if not CurrentModId then

  -- copied shamelessly from Expanded Cheat Menu
  local Mods, rawset = Mods, rawset
  for id, mod in pairs(Mods) do
    rawset(mod.env, "CurrentModId_X", id)
    rawset(mod.env, "CurrentModDef_X", mod)
  end

  CurrentModId = CurrentModId_X
  CurrentModDef = CurrentModDef_X
end

orig_print("loading", CurrentModId, "-", CurrentModDef.title)

-- unforbid DustGenerators from being built inside.
mrudat_AllowBuildingInDome.forbidden_classnames.DustGenerator = nil

local wrap_method = mrudat_AllowBuildingInDome.wrap_method

mrudat_AllowBuildingInDome.DomePosOrMyPos('DustGenerator')

wrap_method('DustGenerator','GetDustRadius', function(self, orig_func)
  local dome = self.parent_dome
  if not dome or dome.open_air then
    return orig_func(self)
  end

  return HexShapeRadius(dome:GetInteriorShape())
end)

wrap_method('DustGenerator','ThrowDust', function(self, orig_func)
  if not self.working then return end

  local dome = self.parent_dome
  if not dome or dome.open_air then
    return orig_func(self)
  end

  local time = GameTime() - self.last_dust_throw_time
  if time < hour_duration then return end

  local dust = MulDivTrunc(self.dust_per_sol, time, sol_duration)

  local dust_scale = self.mrudat_AllowBuildingInDome_dust_scale
  if not dust_scale then
    dust_scale = MulDivTrunc(1000, self.dust_range, self:GetDustRadius())
    self.mrudat_AllowBuildingInDome_dust_scale = dust_scale
  end

  dust = MulDivTrunc(dust, dust_scale, 1000)

  if dust < 1 then return end

  for _,building in ipairs(dome.labels.Building) do
    if building == self then goto next_building end
    if building.accumulate_dust then
      building:AddDust(dust)
    end
    ::next_building::
  end

  dome:AddDust(dust)

  self.last_dust_throw_time = GameTime()
end)

orig_print("loaded", CurrentModId, "-", CurrentModDef.title)
