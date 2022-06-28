AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Breen Soda"
SWEP.Category = "Food"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_grenade.mdl")
SWEP.WorldModel = Model("models/weapons/food/popcan.mdl")
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
		model = "models/weapons/food/popcan.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 180, 175),
		offset = Vector(3.5, -3, -0.5),
		scale = 1
	},
	worldModel = {
		model = "models/weapons/food/popcan.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 0, 190),
		offset = Vector(-3.2, 0.5, 3.5),
		scale = 1
	},
	Animations = {
		["default"] = {
			[0] = {
				view = {
                    ["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, 0, 15)
					},
					["ValveBiped.Grenade_body"] = {
						scale = Vector(0.001, 0.001, 0.001)
					},
					["ValveBiped.Pin"] = {
						scale = Vector(0.001, 0.001, 0.001)
					}
				}
			},
			[1] = {
				easing = FoodSwep.ANIMATION_EASE_DRINK,
				duration = 1.7,
				view = {
					["ValveBiped.Bip01_R_UpperArm"] = {	
						angle = Angle(0, -30, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Forearm"] = {	
						angle = Angle(-45, -10, 0),
						pos = Vector(0, 0, 0)
					},
					["ValveBiped.Bip01_R_Hand"] = {	
						angle = Angle(0, 45, 0)
					},
					["ValveBiped.Bip01_Spine4"] = {	
						pos = Vector(-5, -7, -6)
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

function SWEP:Deploy()
	self:EmitSound("weapons/food/can_open.wav")
end

function SWEP:OnAnimationEvent(id)
	if SERVER then
		if id == FoodSwep.ANIMATION_EVENT_HALF then 
			self:EmitSound("weapons/food/drink1.wav")
            FoodSwep:AddHealth(self.Owner, 25)
		end
	end
end