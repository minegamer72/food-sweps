AddCSLuaFile()

SWEP.Base = "weapon_food_base"
SWEP.PrintName = "Bloxy Cola"
SWEP.Category = "Food"
SWEP.Instructions = "click to drink"

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_bugbait.mdl")
SWEP.WorldModel = Model("models/weapons/food/bloxycola_popcan.mdl")
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
		model = "models/weapons/food/bloxycola_popcan.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 270, 175), --0, 180, 175
		offset = Vector(4.2, -2, -0.5),
		scale = 1
	},
	worldModel = {
		model = "models/weapons/food/bloxycola_popcan.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		angle = Angle(0, 0, 190),
		offset = Vector(-1.5, 2, -4),
		scale = 1
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

------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------
function SWEP:Deploy()
	self:EmitSound("weapons/food/bopen.wav")
end

function SWEP:OnAnimationEvent(id)
	if SERVER then
		if id == FoodSwep.ANIMATION_EVENT_HALF then 
			self:EmitSound("weapons/food/bdrink.wav")
            FoodSwep:AddHealth(self.Owner, 25)
		end
	end
end
