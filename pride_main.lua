function desaturate_completed_achievements()
	--- extend through overwrite the AchievementButton_DisplayAchievement function
	local originalDisplayAchievement = AchievementButton_DisplayAchievement
	function AchievementButton_DisplayAchievement(button, category, achievement, selectionID, renderOffScreen)
		originalDisplayAchievement(button, category, achievement, selectionID, renderOffScreen)
		local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(category, achievement);
		if ( completed and not wasEarnedByMe ) then
			--- if an achievement was not earned by this char, hide the date completed and show the shield as grey
			button.dateCompleted:Hide();
			button:Desaturate();
		end
		return id
	end
	
end

--- only replace the function when the achievement frame is opened (before that it doesn't exist)
local AchievementDisplayFrame = CreateFrame("Frame")
AchievementDisplayFrame:RegisterEvent("ADDON_LOADED")
AchievementDisplayFrame:SetScript("OnEvent", function (self, event, arg)
	if arg == "Blizzard_AchievementUI" then
		desaturate_completed_achievements()	 
	end
end)
