AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Apple"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/food/apple.mdl")
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Config = {
	holdType = "slam",
	viewModel = {
		model = "models/weapons/food/apple.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle( 0, 0, 165 ),
		offset = Vector( 4, -2.4, 2.6 ),
		scale = 0.7
	},
	worldModel = {
		model = "models/weapons/food/apple.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle( 0, 0, 165 ),
		offset = Vector( -3.2, -1.9, 3.5 ),
		scale = 0.7
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
				}
			},
			[1] = {
				easing = FoodSwep.ANIMATION_EASE_IN_EASE_OUT,
				duration = 1.2,
				view = {
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(-95, -160, 20),
						pos = Vector(0, 0, -10)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, 0, 90)
					}
				},
				world = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -70, -6)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(0, -15, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, 0, 90)
					}
				}
			}
		}
	}
}

function SWEP:UpdateBodyGroups()
	if (self:Clip1() == 2) then
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
			self:EmitSound("weapons/food/eat2.wav")
			self:UpdateBodyGroups()
		end
	end	
end
