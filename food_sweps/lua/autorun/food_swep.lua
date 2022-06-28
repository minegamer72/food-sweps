AddCSLuaFile()
--[[                                            

    Hi steam staff and garry`s mod community! I want you to know - you very much deserve more than a byte of MY code MY addons and MY games.
    I love you and want see you and your children alive in front of my eyes. 
    
    I hope you realize you are safe in workshop. See you later, again :)
]]
FoodSwep={}FoodSwep.ANIMATION_EVENT_COMPLETE=0;FoodSwep.ANIMATION_EVENT_HALF=1;FoodSwep.ANIMATION_LINEAR=0;FoodSwep.ANIMATION_EASE_IN=1;FoodSwep.ANIMATION_EASE_OUT=2;
FoodSwep.ANIMATION_EASE_IN_EASE_OUT=3;FoodSwep.ANIMATION_EASE_OUT_EASE_IN=4;FoodSwep.ANIMATION_EASE_IN_EASE_IN=5;FoodSwep.ANIMATION_EASE_OUT_EASE_OUT=6;FoodSwep.ANIMATION_EASE_DRINK=7;
if SERVER then util.AddNetworkString("FoodSwep_PlayAnimation")util.AddNetworkString("FoodSwep_AnimationEvent")net.Receive("FoodSwep_AnimationEvent",function(__a,__b)
if not IsValid(__b)then return end;local c=net.ReadInt(32)local __d=__b:GetActiveWeapon()if not IsValid(__d)or not __d.IsFoodBase then return end;__d:OnAnimationEvent(c)end)end;
if CLIENT then net.Receive("FoodSwep_PlayAnimation",function()local __b=net.ReadEntity()if not IsValid(__b)then return end;local __d=__b:GetActiveWeapon()if not IsValid(__d)or not __d.IsFoodBase or __d.AnimationPlaying then 
return end;__d:PlayAnimation()end)end;FoodSwep.EasingFunctions={}FoodSwep.EasingFunctions[FoodSwep.ANIMATION_LINEAR]=function(__e)return __e end;FoodSwep.EasingFunctions[FoodSwep.ANIMATION_EASE_IN]=function(__e)
return __e*__e end;FoodSwep.EasingFunctions[FoodSwep.ANIMATION_EASE_OUT]=function(__e)return __e*(2-__e)end;FoodSwep.EasingFunctions[FoodSwep.ANIMATION_EASE_IN_EASE_OUT]=function(__e)local __f=0;
if __e>0.5 then __f=(1-__e)*2;__f=__f*__f else __f=__e*2;__f=__f*(2-__f)end;return __f end;
FoodSwep.EasingFunctions[FoodSwep.ANIMATION_EASE_DRINK]=function(__e)local __g=0.05;local __f=0;if __e<0.3 then __f=__e/0.3;__f=__f*(2-__f)else 
if __e<0.8 then __f=1+(__e-0.3)/0.5*__g else __f=1+__g-(__e-0.8)/0.2*(1+__g)__f=__f*__f end end;return __f end;function FoodSwep:InterpolateBones(__h,__i,__j,__k)if not IsValid(__h)then return end;for __l,__m in pairs(__k)do 
local __n=__h:LookupBone(__l)if __n>-1 then if __m.pos then if __j and __j[__l]and __j[__l].pos then __h:ManipulateBonePosition(__n,LerpVector(__i,__j[__l].pos,__m.pos))else __h:ManipulateBonePosition(__n,LerpVector(__i,Vector(0,0,0),__m.pos))end 
end;if __m.angle then if __j and __j[__l]and __j[__l].angle then __h:ManipulateBoneAngles(__n,LerpAngle(__i,__j[__l].angle,__m.angle))else __h:ManipulateBoneAngles(__n,LerpAngle(__i,Angle(0,0,0),__m.angle))end end end 
end end;function FoodSwep:SetBones(__h,__o)if not IsValid(__h)then return end;if __o then for __l,__m in pairs(__o)do local __n=__h:LookupBone(__l)if __n>-1 then if __m.pos then __h:ManipulateBonePosition(__n,__m.pos)end;if __m.angle 
then __h:ManipulateBoneAngles(__n,__m.angle)end;if __m.scale then __h:ManipulateBoneScale(__n,__m.scale)end end end end end;function FoodSwep:ResetBones(__h)if not IsValid(__h)then return end;if not __h:GetBoneCount()then 
return end;for __p=0,__h:GetBoneCount()do __h:ManipulateBoneScale(__p,Vector(1,1,1))__h:ManipulateBoneAngles(__p,Angle(0,0,0))__h:ManipulateBonePosition(__p,Vector(0,0,0))end end;function FoodSwep:AddHealth(__b,__q)
if __b:Health()<100 then __b:SetHealth(math.Clamp(__b:Health()+__q,0,100))end end;hook.Add("UpdateAnimation","FoodSwep_UpdateAnimation",function(__b,r,s)if not IsValid(__b)then return end;local __d=__b:GetActiveWeapon()
if not IsValid(__d)then return end;if IsValid(__b.ActiveFoodWepoon)then if __d:GetClass()~=__b.ActiveFoodWepoon:GetClass()then if IsValid(__b.ActiveFoodWepoon)then if CLIENT then __b.ActiveFoodWepoon:ResetAnimaton()
__b.ActiveFoodWepoon:ResetPose()end end;__b.ActiveFoodWepoon=nil else if __d.AnimationPlaying then __d:UpdateAnimation()end end else if __d.IsFoodBase then if CLIENT then __d:SetupPose()end;__b.ActiveFoodWepoon=__d end 
end end)
 -- The code looks like this because it was obfuscated. If someone wants to make this into a more human readable format, please submit a PR.
