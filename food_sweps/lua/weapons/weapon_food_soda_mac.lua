AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Mcdonalds Soda"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/food/soda_mac.mdl")
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

SWEP.Config = {
	holdType = "slam",
	viewModel = {
		model = "models/weapons/food/soda_mac.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 90, 175),
		offset = Vector(5, -2.5, 2),
		scale = 1.0
	},
	worldModel = {
		model = "models/weapons/food/soda_mac.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 90, 175),
		offset = Vector(-4, 3, -3),
		scale = 1.0
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
						angle = Angle(0, -25, -50)
					}
				}
			},
			[1] = {
				easing = FoodSwep.ANIMATION_EASE_DRINK,
				duration = 2,
				view = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -50, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(-45, -20, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(70, -10, -90)
					},
					["ValveBiped.Bip01_Spine4"] = {	
						pos = Vector(0, -7.5, -14)
					}
				},
				world = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -65, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(5, 15, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(25, 20, 10)
					}
				}
			}
		}
	}
}

function SWEP:OnAnimationEvent(id)	
	if SERVER then
		if id == FoodSwep.ANIMATION_EVENT_HALF then 
			self:EmitSound("weapons/food/drink3.wav")
            FoodSwep:AddHealth(self.Owner, 25)
		end
	end
end