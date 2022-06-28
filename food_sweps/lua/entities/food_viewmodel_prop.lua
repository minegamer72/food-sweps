AddCSLuaFile()

ENT.Base = "base_anim"
ENT.RenderGroup = RENDERGROUP_VIEWMODEL_TRANSLUCENT
ENT.AutomaticFrameAdvance = false
ENT.AdminOnly = false
ENT.Spawnable = false

function ENT:Setup(player, weapon)
	self:SetOwner(player)
	self.Weapon = weapon

	self:SetModel(self.Weapon.Config.viewModel.model)
end

function ENT:Draw()
	local owner = self:GetOwner()

	if not owner then return end
	if owner:GetActiveWeapon() ~= self.Weapon then return end

	local viewModel = owner:GetViewModel()
	local config = self.Weapon.Config.viewModel

	if IsValid(viewModel) then
		local offsetVec = Vector(5, -2.7, -3.4)
		local offsetAng = Angle(180, 90, 0)
		
		local boneid = viewModel:LookupBone(config.bone)
		if !boneid then return end

		local matrix = viewModel:GetBoneMatrix(boneid)
		if !matrix then return end

		local newPos, newAng = LocalToWorld(config.offset, config.angle, matrix:GetTranslation(), matrix:GetAngles())

		self:SetPos(newPos)
		self:SetAngles(newAng)
	else
		self:SetPos(self:GetPos())
		self:SetAngles(self:GetAngles())
	end

	self:SetupBones()
	self:DrawModel()
end
