local holsteredgunsconvar = CreateConVar( "holster", "1", { FCVAR_ARCHIVE, }, "Enable/Disable the rendering of the weapons on any player" )
 
local NEXT_WEAPONS_UPDATE=CurTime();
 
local weaponsinfos={}

weaponsinfos["weapon_pistol"]={}
weaponsinfos["weapon_pistol"].Model="models/weapons/W_pistol.mdl"
weaponsinfos["weapon_pistol"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["weapon_pistol"].BoneOffset={Vector(0,-8,0),Angle(0,90,0)}

weaponsinfos["weapon_frag"]={}
weaponsinfos["weapon_frag"].Model="models/Items/grenadeAmmo.mdl"
weaponsinfos["weapon_frag"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["weapon_frag"].BoneOffset={Vector(3,-5,6),Angle(-95,0,0)}

weaponsinfos["weapon_stunstick"]={}
weaponsinfos["weapon_stunstick"].Model="models/weapons/W_stunbaton.mdl"
weaponsinfos["weapon_stunstick"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["weapon_stunstick"].BoneOffset={Vector(3,0,0),Angle(0,0,-45)}
 
weaponsinfos["weapon_shotgun"]={}
weaponsinfos["weapon_shotgun"].Model="models/weapons/W_shotgun.mdl"
weaponsinfos["weapon_shotgun"].Bone="ValveBiped.Bip01_R_Clavicle"
weaponsinfos["weapon_shotgun"].BoneOffset={Vector(10,5,2),Angle(0,90,0)}
 
weaponsinfos["weapon_smg1"]={}
weaponsinfos["weapon_smg1"].Model="models/weapons/w_smg1.mdl"
weaponsinfos["weapon_smg1"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["weapon_smg1"].BoneOffset={Vector(5,0,-5),Angle(0,0,230)}
 
weaponsinfos["weapon_ar2"]={}
weaponsinfos["weapon_ar2"].Model="models/weapons/W_irifle.mdl"
weaponsinfos["weapon_ar2"].Bone="ValveBiped.Bip01_R_Clavicle"
weaponsinfos["weapon_ar2"].BoneOffset={Vector(-5,0,7),Angle(0,270,0)}
 
weaponsinfos["weapon_crossbow"]={}
weaponsinfos["weapon_crossbow"].Model="models/weapons/W_crossbow.mdl"
weaponsinfos["weapon_crossbow"].Bone="ValveBiped.Bip01_L_Clavicle"
weaponsinfos["weapon_crossbow"].BoneOffset={Vector(0,5,-5),Angle(180,90,0)}
 
weaponsinfos["gt_medkit"]={}
weaponsinfos["gt_medkit"].Model="models/Items/HealthKit.mdl"
weaponsinfos["gt_medkit"].Bone="ValveBiped.Bip01_Spine2"
weaponsinfos["gt_medkit"].BoneOffset={Vector(1,8.5,0),Angle(90,180,0)}
 
weaponsinfos["stunstick"]={}
weaponsinfos["stunstick"].Model="models/weapons/w_stunbaton.mdl"
weaponsinfos["stunstick"].Bone="ValveBiped.Bip01_Spine2"
weaponsinfos["stunstick"].BoneOffset={Vector(-7,-11,6.5),Angle(0,0,0)}

weaponsinfos["gt_builder"]={}
weaponsinfos["gt_builder"].Model="models/weapons/w_crowbar.mdl"
weaponsinfos["gt_builder"].Bone="ValveBiped.Bip01_Spine1"
weaponsinfos["gt_builder"].BoneOffset={Vector(3,0,0),Angle(0,0,45)}

/* 
weaponsinfos["weapon_357"]={}
weaponsinfos["weapon_357"].Model="models/weapons/W_357.mdl"
weaponsinfos["weapon_357"].Bone="ValveBiped.Bip01_Pelvis"
weaponsinfos["weapon_357"].BoneOffset={Vector(-5,8,0),Angle(0,270,0)}
weaponsinfos["weapon_357"].Priority="gmod_tool"
*/ 

function LPGB(dotrace)
    if !dotrace then
    for i=0,LocalPlayer():GetBoneCount()-1 do
        print(LocalPlayer():GetBoneName(i))
    end
    else
    local entity=LocalPlayer():GetEyeTrace().Entity
    if !IsValid(entity) then return end
    for i=0,entity:GetBoneCount()-1 do
        print(entity:GetBoneName(i))
    end
    end
end
 
local function CalcOffset(pos,ang,off)
        return pos + ang:Right() * off.x + ang:Forward() * off.y + ang:Up() * off.z;
end
     
local function clhasweapon(pl,weapon)
    for i,v in pairs(pl:GetWeapons()) do
        if string.lower(v:GetClass())==string.lower(weapon) then return true end
    end
     
    return false;
end
 
local function clgetweapon(pl,weapon)
    for i,v in pairs(pl:GetWeapons()) do
        if string.lower(v:GetClass())==string.lower(weapon) then return v end
    end
     
    return nil;
end
 
local function playergetclass(ply)
    return ply:GetPlayerClass()
end
 
local function IsClass(ply)
   return LocalPlayer().IsHL2 && !LocalPlayer():IsHL2()
end
 
local function GetHolsteredWeaponTable(ply,indx)
    local class=IsClass(ply) and playergetclass(ply) or nil
    if !class then  return weaponsinfos[indx]
    else return (weaponsinfos[indx] && weaponsinfos[indx][class]) and weaponsinfos[indx][class] or nil
    end
end
 
local function think()
    if !holsteredgunsconvar:GetBool() then return end
    for _,pl in pairs(player.GetAll()) do
        if !IsValid(pl) then continue end
         
        if !pl.CL_CS_WEPS then
            pl.CL_CS_WEPS={}
        end
         
        if !pl:Alive() then pl.CL_CS_WEPS={} continue end
         
        if NEXT_WEAPONS_UPDATE<CurTime() then
            pl.CL_CS_WEPS={} 
            NEXT_WEAPONS_UPDATE=CurTime()+5
        end
         
        for i,v in pairs(pl:GetWeapons())do
            if !IsValid(v) then continue; end
             
            if pl.CL_CS_WEPS[v:GetClass()] then continue end
             
            if !pl.CL_CS_WEPS[v:GetClass()] then
                local worldmodel=v.WorldModelOverride or v.WorldModel
                local attachedwmodel=v.AttachedWorldModel;
                 
                if GetHolsteredWeaponTable(pl,v:GetClass()) && GetHolsteredWeaponTable(pl,v:GetClass()).Model then
                    worldmodel=GetHolsteredWeaponTable(pl,v:GetClass()).Model
                end
                if !worldmodel || worldmodel=="" then continue end;
                 
                 
                pl.CL_CS_WEPS[v:GetClass()]=ClientsideModel(worldmodel,RENDERGROUP_OPAQUE)
                pl.CL_CS_WEPS[v:GetClass()]:SetNoDraw(true)
                pl.CL_CS_WEPS[v:GetClass()]:SetSkin(v:GetSkin())
                pl.CL_CS_WEPS[v:GetClass()]:SetColor(v:GetColor())
                 
                if GetHolsteredWeaponTable(pl,v:GetClass()) && GetHolsteredWeaponTable(pl,v:GetClass()).Scale then
                    pl.CL_CS_WEPS[v:GetClass()]:SetModelScale(GetHolsteredWeaponTable(pl,v:GetClass()).Scale);
                end
                 
                if GetHolsteredWeaponTable(pl,v:GetClass()) && GetHolsteredWeaponTable(pl,v:GetClass()).BBP then
                    pl.CL_CS_WEPS[v:GetClass()].BuildBonePositions=GetHolsteredWeaponTable(pl,v:GetClass()).BBP;
                end
                 
                if v.MaterialOverride || v:GetMaterial() then
                    pl.CL_CS_WEPS[v:GetClass()]:SetMaterial(v.MaterialOverride || v:GetMaterial())
                end
                if worldmodel == "models/weapons/w_models/w_shotgun.mdl" then
                    pl.CL_CS_WEPS[v:GetClass()]:SetMaterial("models/weapons/w_shotgun_tf/w_shotgun_tf")
                end
                 
                pl.CL_CS_WEPS[v:GetClass()].WModelAttachment=v.WModelAttachment
                pl.CL_CS_WEPS[v:GetClass()].WorldModelVisible=v.WorldModelVisible
                 
                 
                if attachedwmodel then
                    pl.CL_CS_WEPS[v:GetClass()].AttachedModel=ClientsideModel(attachedwmodel,RENDERGROUP_OPAQUE)
                    pl.CL_CS_WEPS[v:GetClass()].AttachedModel:SetNoDraw(true)
                    pl.CL_CS_WEPS[v:GetClass()].AttachedModel:SetSkin(v:GetSkin())
                    pl.CL_CS_WEPS[v:GetClass()].AttachedModel:SetParent(pl.CL_CS_WEPS[v:GetClass()])
                    pl.CL_CS_WEPS[v:GetClass()].AttachedModel:AddEffects( EF_BONEMERGE, EF_BONEMERGE_FASTCULL, EF_PARENT_ANIMATES )
                end
            end
        end
    end
end
 
local function playerdraw(pl,legs)
    if !holsteredgunsconvar:GetBool() then return end
    if !IsValid(pl) then return end
    if !pl.CL_CS_WEPS then return end
    for i,v in pairs(pl.CL_CS_WEPS) do
 
             
        if GetHolsteredWeaponTable(pl,i) && (pl:GetActiveWeapon()==NULL || pl:GetActiveWeapon():GetClass()~=i) && clhasweapon(pl,i) then
            if GetHolsteredWeaponTable(pl,i).Priority then
                local priority=GetHolsteredWeaponTable(pl,i).Priority
                local bol=GetHolsteredWeaponTable(pl,priority) && (pl:GetActiveWeapon()==NULL || pl:GetActiveWeapon():GetClass()!=priority) && clhasweapon(pl,priority)
                if bol then continue; end
            end
             
            local oldpl=pl;
            local wep=clgetweapon(oldpl,i)
			
            local bone=pl:LookupBone(GetHolsteredWeaponTable(oldpl,i).Bone or "")
            if !bone then pl=oldpl;continue; end
 
             
            local matrix = pl:GetBoneMatrix(bone)
            if !matrix then pl=oldpl;continue; end
            local pos = matrix:GetTranslation()
			local ang = matrix:GetAngles()
            local pos=CalcOffset(pos,ang,GetHolsteredWeaponTable(oldpl,i).BoneOffset[1])
            if GetHolsteredWeaponTable(oldpl,i).Skin then v:SetSkin(GetHolsteredWeaponTable(oldpl,i).Skin) end
             
            v:SetRenderOrigin(pos)
             
            ang:RotateAroundAxis(ang:Forward(),GetHolsteredWeaponTable(oldpl,i).BoneOffset[2].p)
            ang:RotateAroundAxis(ang:Up(),GetHolsteredWeaponTable(oldpl,i).BoneOffset[2].y)
            ang:RotateAroundAxis(ang:Right(),GetHolsteredWeaponTable(oldpl,i).BoneOffset[2].r)
             
            v:SetRenderAngles(ang)
            if v.WorldModelVisible==nil || (v.WorldModelVisible!=false) then
                v:DrawModel();
            end
             
            if IsValid(v.AttachedModel) then
                v.AttachedModel:DrawModel();
            end
            if v.WModelAttachment && multimodel then
                multimodel.Draw(v.WModelAttachment, wep, {origin=pos, angles=ang})
                multimodel.DoFrameAdvance(v.WModelAttachment, CurTime(),wep)
            end
             
            if GetHolsteredWeaponTable(oldpl,i).DrawFunction then
                GetHolsteredWeaponTable(oldpl,i).DrawFunction(v,oldpl)
            end
            pl=oldpl;
        end
    end
end
 
hook.Add("Think","Holster_Think",think)
hook.Add("PostPlayerDraw","Holster_Draw",playerdraw)