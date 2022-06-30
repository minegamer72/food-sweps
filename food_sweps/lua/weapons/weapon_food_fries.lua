AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Fries"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/foodnhouseholditems/mcdfrenchfries.mdl")
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Config = {
	holdType = "slam",
	viewModel = {
		model = "models/foodnhouseholditems/mcdfrenchfries.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(-91, -75, 110),
		offset = Vector(3.5, -3, -2),
		scale = 0.8
	},
	worldModel = {
		model = "models/foodnhouseholditems/mcdfrenchfries.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(90, 0, 180),
		offset = Vector(-3, -7.5, -0.3),
		scale = 0.8
	},
	Animations = {
		["default"] = {
			[0] = {
				view = {
					["ValveBiped.cube"] = {	
						scale = Vector(0.001, 0.001, 0.001)
					},
					["ValveBiped.cube1"] = { 
						scale = Vector(0.001, 0.001, 0.001)
					},
					["ValveBiped.cube2"] = { 
						scale = Vector(0.001, 0.001, 0.001)
					},
					["ValveBiped.cube3"] = { 
						scale = Vector(0.001, 0.001, 0.001)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, -15, -65)
					}
				}
			},
			[1] = {
				easing = FoodSwep.ANIMATION_EASE_DRINK,
				duration = 2,
				view = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -30, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(-45, -20, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(30, 20, -40)
					},
					["ValveBiped.Bip01_Spine4"] = {	
						pos = Vector(0, -7, -10)
					}
				},
				world = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -65, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(5, -15, 0)
					}
				}
			}
		}
	}
}


function SWEP:UpdateBodyGroups()
	if (self:Clip1() == 3) then
			self.ClientViewModel:SetBodyGroups("030")
		self.ClientWorldModel:SetBodyGroups("030")
	elseif (self:Clip1() == 2) then
		self.ClientViewModel:SetBodyGroups("010")
		self.ClientWorldModel:SetBodyGroups("010")
	elseif (self:Clip1() == 1) then
		self.ClientViewModel:SetBodyGroups("020")
		self.ClientWorldModel:SetBodyGroups("020")
	end
end

function SWEP:OnCreateCliendsideModels()
	self:UpdateBodyGroups()
end

function SWEP:OnAnimationEvent(id)
	if id == FoodSwep.ANIMATION_EVENT_HALF then 
		if SERVER then
			if (self:Clip1() == 1) then
				self:Remove()
				FoodSwep:AddHealth(self.Owner, 15)
			end
		end
		
		self:SetClip1(self:Clip1() - 1)

		if CLIENT then
			self:EmitSound("weapons/food/eat1.wav")
			self:UpdateBodyGroups()
		end
	end	
end