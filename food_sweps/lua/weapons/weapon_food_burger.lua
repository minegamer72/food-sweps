AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Burger"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/food/burger.mdl")
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Config = {
	holdType = "slam",
	viewModel = {
		model = "models/food/burger.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(110, 0, -20),
		offset = Vector(-5.6, -6.5, 3.5),
		scale = 0.75
	},
	worldModel = {
		model = "models/food/burger.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(90, 0, 180),
		offset = Vector(-3, -7.5, -0.2),
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
						angle = Angle(20, 0, 0)
					}
				}
			},
			[1] = {
				easing = FoodSwep.ANIMATION_EASE_IN_EASE_OUT,
				duration = 1.0,
				view = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, 20, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(0, -80, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, -35, -50)
					},
					["ValveBiped.Bip01_Spine4"] = {	
						--pos = Vector(0, -8, -15)
                        pos = Vector(0, 3, -5)
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
						angle = Angle(25, 20, 40)
					}
				}
			}
		}
	}
}

function SWEP:OnAnimationEvent(id)
	if SERVER then
		if id == FoodSwep.ANIMATION_EVENT_HALF then
			self:Remove()
            self:EmitSound("weapons/food/eat1.wav")
            FoodSwep:AddHealth(self.Owner, 10)
		end
	end
end