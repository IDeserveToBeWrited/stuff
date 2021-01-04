local additionals = {
	mower = {
		"workMode",
		"pdlc_kvernelandPack.workModeConfigurations",
		"pdlc_kvernelandPack.connectionHosePowerTakeOffFix"
	}
}
local oldFinalizeVehicleTypes = VehicleTypeManager.finalizeVehicleTypes

function VehicleTypeManager:finalizeVehicleTypes(...)
	for typeName, typeEntry in pairs(self:getVehicleTypes()) do
		for name, specs in pairs(additionals) do
			if typeName == name then
				for i = 1, #specs do
					if typeEntry.specializationsByName[specs[i]] == nil then
						self:addSpecialization(typeName, specs[i])
					end
				end
			end
		end
	end

	oldFinalizeVehicleTypes(self, ...)
end
