AddCSLuaFile()

SWEP.PrintName = "foodswep_base"
SWEP.Category = "Food"
SWEP.Spawnable = false
SWEP.IsFoodBase = true

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/unconid/w_bugbait.mdl")
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Config = nil

if CLIENT then
	function SWEP:ClearCliensideModels()
		if IsValid(self.ClientViewModel) then
			self.ClientViewModel:Remove()
		end

		if IsValid(self.ClientWorldModel) then
			self.ClientWorldModel:Remove()
		end
	end

	function SWEP:OnCreateCliendsideModels() end

	function SWEP:CreateCliensideModels()
		self:ClearCliensideModels()
		local config = self.Config

		if config.viewModel and config.viewModel.model then
            self.ClientViewModel = ents.CreateClientside("food_viewmodel_prop")
            self.ClientViewModel:Setup(self.Owner, self)
            self.ClientViewModel:SetModelScale(config.viewModel.scale)
            self.ClientViewModel:Spawn()
		end
		if config.worldModel and config.worldModel.model then
			self.ClientWorldModel = ClientsideModel(config.worldModel.model)
			self.ClientWorldModel:SetModelScale(config.worldModel.scale)
		end
		self:OnCreateCliendsideModels()
	end

	function SWEP:DrawWorldModel()

	end

	function SWEP:SetupPose()
		if not IsValid(self.Owner) then return end

		FoodSwep:SetBones(self.Owner, self.Config.Animations["default"][0].world)

		local viewModel = self.Owner:GetViewModel()

		if not IsValid(viewModel) then return end

		FoodSwep:SetBones(viewModel, self.Config.Animations["default"][0].view)
	end

	function SWEP:ResetPose()
		if not IsValid(self.Owner) then return end

		FoodSwep:ResetBones(self.Owner)

		local viewModel = self.Owner:GetViewModel()

		if not IsValid(viewModel) then return end

		FoodSwep:ResetBones(viewModel)
	end

	function SWEP:AnimationEvent(id)
		self:OnAnimationEvent(id)

		if self.Owner == LocalPlayer() then
			net.Start("FoodSwep_AnimationEvent")
			net.WriteInt(id, 32)
			net.SendToServer()
		end
	end

	function SWEP:UpdateAnimation()
		if (self.AnimationTimeStart + self.AnimationDuration) > CurTime() then
			self.AnimationTime = ((CurTime() - self.AnimationTimeStart) / self.AnimationDuration) * 1

			local easeFunction = self.AnimationEasing

			if easeFunction == FoodSwep.ANIMATION_EASE_DRINK then
				if self.AnimationTime > 0.3 and not self.IsAnimationHalf then
					self:AnimationEvent(FoodSwep.ANIMATION_EVENT_HALF)
					self.IsAnimationHalf = true
				end
			else
				if self.AnimationTime > 0.5 and not self.IsAnimationHalf then
					self:AnimationEvent(FoodSwep.ANIMATION_EVENT_HALF)
					self.IsAnimationHalf = true
				end
			end

			local fraction = FoodSwep.EasingFunctions[easeFunction](self.AnimationTime)

			if not IsValid(self.Owner) then return end

			FoodSwep:InterpolateBones(self.Owner, fraction, self.Config.Animations["default"][self.AnimationFrame - 1].world, self.Config.Animations["default"][self.AnimationFrame].world)

			local viewModel = self.Owner:GetViewModel()

			if not IsValid(viewModel) then return end

			FoodSwep:InterpolateBones(viewModel, fraction, self.Config.Animations["default"][self.AnimationFrame - 1].view, self.Config.Animations["default"][self.AnimationFrame].view)
		else
			if self.Config.Animations["default"][self.AnimationFrame + 1] then
				self.AnimationTime = 0
				self.AnimationTimeStart = CurTime()
				self:SetAnimationFrame(self.AnimationFrame + 1)
			else
				self:ResetAnimaton()
				self:AnimationEvent(FoodSwep.ANIMATION_EVENT_COMPLETE)
			end
		end
	end

	function SWEP:SetAnimationFrame(frame)
		if self.Config.Animations["default"][frame] then
			self.AnimationFrame = frame
			self.AnimationDuration = self.Config.Animations["default"][frame].duration
			self.AnimationEasing = self.Config.Animations["default"][frame].easing
		end
	end

	function SWEP:PlayAnimation()
		self:SetAnimationFrame(1)

		if self.AnimationFrame == 1 then
			self:SetupPose()
			self.AnimationTimeStart = CurTime()
			self.AnimationPlaying = true
		end
	end

	function SWEP:ResetAnimaton()
		self.AnimationTimeStart = 0
		self.AnimationTime = 0
		self.AnimationDuration = 0
		self.AnimationFrame = 0
		self.AnimationPlaying = false
		self.AnimationName = ""

		self.IsAnimationHalf = false
	end
	
	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = true
		self.AmmoDisplay.PrimaryClip = self:Clip1()

		return self.AmmoDisplay
	end

	function SWEP:OnRemove()
		self:ClearCliensideModels()
		self:ResetAnimaton()
		self:ResetPose()
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.Config.holdType)

	if CLIENT then
		self.AnimationTimeStart = 0
		self.AnimationTime = 0
		self.AnimationDuration = 0
		self.AnimationFrame = 0
		self.AnimationPlaying = false
		self.AnimationName = ""

		self.IsAnimationHalf = false
		self:CreateCliensideModels()
	end
end

function SWEP:OnAnimationEvent(id) end

function SWEP:PrimaryAttack()		
	if SERVER then
		net.Start("FoodSwep_PlayAnimation")
		net.WriteEntity(self.Owner)
		net.Broadcast()
	end
end

function SWEP:SecondaryAttack() end