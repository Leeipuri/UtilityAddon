UtilityAddon = {scanTarget=nil, healingPower=0, healingScale=1.0, maxRankCondition=nil}

function UtilityAddon.setHealingPower(useless, power)
	UtilityAddon.healingPower=power
end
UtilityAddon.sh=UtilityAddon.setHealingPower

function UtilityAddon.SetScanTarget(useless, name)
	UtilityAddon.scanTarget=name
end
UtilityAddon.ss=UtilityAddon.SetScanTarget

function UtilityAddon.TargetScanTarget()
	if UtilityAddon.scanTarget~=nil then
		TargetByName(UtilityAddon.scanTarget)
	end
end
UtilityAddon.ts=UtilityAddon.TargetScanTarget

function UtilityAddon.SetHealingScale(useless, scale)
	UtilityAddon.healingScale=scale
end
UtilityAddon.hs=UtilityAddon.SetHealingScale

function UtilityAddon.SetMaxRankCondition(useless, maxRankCondition)
	UtilityAddon.maxRankCondition=maxRankCondition
end
UtilityAddon.mc=UtilityAddon.SetMaxRankCondition

function UtilityAddon.isFriendly()
	do return UnitIsFriend("player","target") end
end
UtilityAddon.f=UtilityAddon.isFriendly

function UtilityAddon.isEnemy()
	do return UnitIsEnemy("player","target") end
end
UtilityAddon.e=UtilityAddon.isEnemy

function UtilityAddon.NoCancelAction(useless, actionnumber)
	if not IsCurrentAction(actionnumber)then
		UseAction(actionnumber)
	end
end
UtilityAddon.na=UtilityAddon.NoCancelAction

function UtilityAddon.CancelShapeshift(useless, ...)
	for i=1,40 do
		if UnitDebuff("target",i)==nil then
			break
		elseif string.find(tostring(UnitDebuff("target",i)),"Spell_Shadow_ShadowWordDominate")~=nil then
			do return end
			break
		end
	end
	UtilityAddon.fc()
	for i,v in ipairs(arg) do
		if v~=nil then
			UtilityAddon.na(nil, v)
		end
	end
end
UtilityAddon.cs=UtilityAddon.CancelShapeshift

function UtilityAddon.ForceCancel()
	for i=1,GetNumShapeshiftForms()do
		local _,_,a=GetShapeshiftFormInfo(i)
		if a~=nil then
			CastShapeshiftForm(i)
			break
		end
	end
end
UtilityAddon.fc=UtilityAddon.ForceCancel

function UtilityAddon.BuffCancel(useless, buffstring)
	local i=0
	while not (GetPlayerBuff(i) == -1) do
		if(strfind(GetPlayerBuffTexture(GetPlayerBuff(i)),buffstring))then
			CancelPlayerBuff(GetPlayerBuff(i))
		end
		i=i+1
	end 
end
UtilityAddon.bc=UtilityAddon.BuffCancel

function UtilityAddon.ListBuffs(useless, unitname)
	if unitname==nil or UnitExists(unitname)==false then
		do return end
	end
	local b=0
	for i=1,40 do
		if UnitBuff(unitname,i)~=nil then
			ChatFrame1:AddMessage(tostring(UnitBuff(unitname,i)));
		end
	end
end
UtilityAddon.lb=UtilityAddon.ListBuffs

function UtilityAddon.ListDebuffs(useless, unitname)
	if unitname==nil or UnitExists(unitname)==false then
		do return end
	end
	local b=0
	for i=1,40 do
		if UnitDebuff(unitname,i)~=nil then
			ChatFrame1:AddMessage(tostring(UnitDebuff(unitname,i)));
		end
	end
end
UtilityAddon.ld=UtilityAddon.ListDebuffs

function UtilityAddon.CheckBuff(useless, unitname, buffstring, spelltrue, spellfalse, control)
	if unitname==nil and buffstring==nil or UnitExists(unitname)==false then
		do return end
	end
	local b=0
	for i=1,40 do
		if UnitBuff(unitname,i)==nil then
			break
		elseif string.find(tostring(UnitBuff(unitname,i)),buffstring)~=nil then
			b=1
			break
		end
	end
	if b==0 or (control and IsControlKeyDown()) then
		if spellfalse~=nil then
			CastSpellByName(spellfalse)
		end
		do return 0 end
	elseif spelltrue~=nil then
		CastSpellByName(spelltrue)
	end
	do return 1 end
end
UtilityAddon.cb=UtilityAddon.CheckBuff

function UtilityAddon.CheckDebuff(useless, unitname, buffstring, spelltrue, spellfalse, control)
	if unitname==nil and buffstring==nil or UnitExists(unitname)==false then
		do return end
	end
	local b=0
	for i=1,40 do
		if UnitDebuff(unitname,i)==nil then
			break
		elseif string.find(tostring(UnitDebuff(unitname,i)),buffstring)~=nil then
			b=1
			break
		end
	end
	if b==0 or (control and IsControlKeyDown()) then
		if spellfalse~=nil then
			CastSpellByName(spellfalse)
		end
		do return 0 end
	elseif spelltrue~=nil then
		CastSpellByName(spelltrue)
	end
	do return 1 end
end
UtilityAddon.cd=UtilityAddon.CheckDebuff

function UtilityAddon.CancelNot(useless, shapeshiftindex, ...)
	if shapeshiftindex==nil then
		do return end
	end
	for i=1,GetNumShapeshiftForms()do
		local _,_,a=GetShapeshiftFormInfo(i)
		if a~=nil and i~=shapeshiftindex then
			CastShapeshiftForm(i)
			break
		end
	end
	local _,_,a=GetShapeshiftFormInfo(shapeshiftindex)
	if not a then
		CastShapeshiftForm(shapeshiftindex)
	end
	for i,v in ipairs(arg) do
		if v~=nil then
			UtilityAddon.na(nil, v)
		end
	end
end
UtilityAddon.cn=UtilityAddon.CancelNot

function UtilityAddon.SSConditional(useless, humanoid, bear, cat)
	for i=1,GetNumShapeshiftForms()do
		local _,_,a=GetShapeshiftFormInfo(i)
		if a~=nil then
			if i==1 then
				CastSpellByName(tostring(bear))
				do return 1 end
			elseif i==3 then
				CastSpellByName(tostring(cat))
				do return 2 end
			end
		end
	end
	CastSpellByName(tostring(humanoid))
	do return 0 end
end
UtilityAddon.sc=UtilityAddon.SSConditional

function UtilityAddon.SpellRanks(useless, spellname, spellranks, scale, control, nocast)
	if spellname==nil or spellranks==nil then
		do return end
	end
	local h=0
	if UnitHealthMax("target")==100 then
		h=(UnitHealthMax("target")-UnitHealth("target"))/UnitHealthMax("target")*UnitHealthMax("player")
	else
		h=UnitHealthMax("target")-UnitHealth("target")
	end
	local m=UnitMana("player")
	local rlen = table.getn(spellranks)
	for key,value in pairs(spellranks) do
		local derank=1
		if value[4]~=nil then
			derank=value[4]/100
		end
		local powered=(value[2]+(UtilityAddon.healingPower*derank))
		if ((powered<(h*scale) or (control and IsControlKeyDown())) and value[3]<=m) or (key==rlen and nocast~=1) then
			local whatrank = "Rank "..value[1]
			if UtilityAddon.maxRankCondition~=nil then
				if UtilityAddon.cb(nil, "player", UtilityAddon.maxRankCondition)==1 then
					whatrank = ""
				end
			end
			CastSpellByName(spellname.."("..whatrank..")");
			do return value[1] end
			break
		end
	end
	do return 0 end
end
UtilityAddon.sr=UtilityAddon.SpellRanks

function UtilityAddon.RunMacro(useless, macroname)
	if macroname==nil then
		do return end
	end
	local _,_,mi=GetMacroInfo(GetMacroIndexByName(macroname))
	if(string.find(mi,"/run ")==1)then
		mi=string.sub(mi, 5)
	end
	RunScript(mi)
end
UtilityAddon.rm=UtilityAddon.RunMacro

function UtilityAddon.NocancelStance(useless, stance)
	if stance==nil then
		do return end
	end
	local _,_,a=GetShapeshiftFormInfo(stance)
	if not a then
		CastShapeshiftForm(stance)
	end
end
UtilityAddon.ns=UtilityAddon.NocancelStance

function UtilityAddon.LowLevelDerank(useless, spellname, spellranklevels, targetlevel)
	for i=table.getn(spellranklevels),1,-1 do
		if (targetlevel >= spellranklevels[i]-10) then
			CastSpellByName(spellname.."(Rank "..i..")")
			do return end
		end
	end
end
UtilityAddon.ld=UtilityAddon.LowLevelDerank

function UtilityAddon.help()
	ChatFrame1:AddMessage("UtilityAddon.SetHealingPower(power)")
	ChatFrame1:AddMessage("UtilityAddon.sh = UtilityAddon.SetHealingPower")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.SetScanTarget(name)")
	ChatFrame1:AddMessage("UtilityAddon.ss = UtilityAddon.SetScanTarget")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.TargetScanTarget()")
	ChatFrame1:AddMessage("UtilityAddon.ts = UtilityAddon.TargetScanTarget")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.SetHealingScale(scale)")
	ChatFrame1:AddMessage("UtilityAddon.hs = UtilityAddon.SetHealingScale")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.SetMaxRankCondition(maxRankCondition)")
	ChatFrame1:AddMessage("UtilityAddon.mc = UtilityAddon.SetMaxRankCondition")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.isFriendly()")
	ChatFrame1:AddMessage("UtilityAddon.f = UtilityAddon.isFriendly")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.isEnemy()")
	ChatFrame1:AddMessage("UtilityAddon.e = UtilityAddon.isEnemy")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.NoCancelAction(actionnumber)")
	ChatFrame1:AddMessage("UtilityAddon.na = UtilityAddon.NoCancelAction")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.CancelShapeshift(...actions)")
	ChatFrame1:AddMessage("UtilityAddon.cs = UtilityAddon.CancelShapeshift")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.ForceCancel()")
	ChatFrame1:AddMessage("UtilityAddon.fc = UtilityAddon.ForceCancel")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.BuffCancel(unitname, buffstring)")
	ChatFrame1:AddMessage("UtilityAddon.bc = UtilityAddon.BuffCancel")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.ListBuffs(unitname)")
	ChatFrame1:AddMessage("UtilityAddon.lb=UtilityAddon.ListBuffs")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.ListDebuffs(unitname)")
	ChatFrame1:AddMessage("UtilityAddon.ld=UtilityAddon.ListDebuffs")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.CheckBuff(unitname, buffstring, spelltrue, spellfalse, control)")
	ChatFrame1:AddMessage("UtilityAddon.cb = UtilityAddon.CheckBuff")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.CheckDebuff(unitname, buffstring, spelltrue, spellfalse, control)")
	ChatFrame1:AddMessage("UtilityAddon.cd = UtilityAddon.CheckDebuff")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.CancelNot(shapeshiftindex, ...actions)")
	ChatFrame1:AddMessage("UtilityAddon.cn = UtilityAddon.CancelNot")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.SSConditional(humanoid, bear, cat)")
	ChatFrame1:AddMessage("UtilityAddon.sc = UtilityAddon.SSConditional")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.SpellRanks(spellname, spellpower, {{rank,minheal,manacost[,derankmultiplier]},..}, scale, control)")
	ChatFrame1:AddMessage("UtilityAddon.sr = UtilityAddon.SpellRanks")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.RunMacro(macroname)")
	ChatFrame1:AddMessage("UtilityAddon.rm = UtilityAddon.RunMacro")
	ChatFrame1:AddMessage("---")
	
	ChatFrame1:AddMessage("UtilityAddon.NocancelStance(stance)")
	ChatFrame1:AddMessage("UtilityAddon.ns = UtilityAddon.NocancelStance")
	ChatFrame1:AddMessage("---")

	ChatFrame1:AddMessage("UtilityAddon.LowLevelDerank(spellname, spellranklevels, targetlevel)")
	ChatFrame1:AddMessage("UtilityAddon.ld = UtilityAddon.LowLevelDerank")
	ChatFrame1:AddMessage("---")
	
end