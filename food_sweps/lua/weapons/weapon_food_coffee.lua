AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Coffee"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/food/coffee.mdl")
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
		model = "models/weapons/food/coffee.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 130, 200),
		offset = Vector(4, -2.6, -3.3),
		scale = 1
	},
	worldModel = {
		model = "models/weapons/food/coffee.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 130, 180),
		offset = Vector(-1.5, 2, -4),
		scale = 0.9
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
						angle = Angle(0, -85, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(5, 25, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(35, 20, 16)
					}
				}
			}
		}
	}
}

function SWEP:OnAnimationEvent(id)
	if SERVER then
		if id == FoodSwep.ANIMATION_EVENT_HALF then 
			self:EmitSound("weapons/food/drink1.wav")
            FoodSwep:AddHealth(self.Owner, 25)
		end
	end
end