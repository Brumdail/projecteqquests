-- items: 51121, 51122, 18740, 13559, 13951, 5353
function event_spawn(e)
	local xloc = e.self:GetX();
	local yloc = e.self:GetY();
	eq.set_proximity(xloc - 50, xloc + 50, yloc - 50, yloc + 50);
end

function event_enter(e)
	if(e.other:HasItem(18740) == true) then
		e.other:Message(MT.Yellow,"As you make your way into a small well-lit room, a robed figure turns to greet you. 'Hello there, friend. I am Lorme Tredore, Magician Guild Master. Should you wish to begin your training, read the note in your inventory and then hand it to me'");
	end
end

function event_say(e)
	if(e.message:findi("trades")) then
		e.self:Say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [second book], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		e.other:SummonItem(51121); -- Item: Tradeskill Basics : Volume I
	elseif(e.message:findi("second book")) then
		e.self:Say("Here is the second volume of the book you requested, may it serve you well!");
		e.other:SummonItem(51122); -- Item: Tradeskill Basics : Volume II
	end
end

function event_trade(e)
	local item_lib = require("items");

	if(item_lib.check_turn_in(e.trade, {item1 = 18740})) then -- A Tattered Note
		e.self:Say(string.format("Welcome to the Academy of Arcane Sciences. I am Lorme Tredore, Master Magician. Here is our guild robe, wear it with pride and represent us well, young %s. Once you are ready to begin your training please make sure that you see Shana Liskia, he can assist you in developing your hunting and gathering skills. Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [trades] you will have available to you.",e.other:GetName()));
		e.other:SummonItem(13559); -- Item: Used Violet Robe*
		e.other:Ding();
		e.other:Faction(220,100,0); -- Arcane Scientists
		e.other:Faction(281,25,0); -- Knights of Truth
		e.other:Faction(296,-15,0); -- Opal Dark Briar
		e.other:Faction(330,-15,0); -- The Freeport Militia
		e.other:AddEXP(100);
	elseif(item_lib.check_turn_in(e.trade, {item1 = 13951})) then -- Fleshy Orb
		e.self:Say("Ah. Thank you for bringing this to me! I will make very good use of it. Here take this small token of my appreciation in return. Guard Jenkins will no longer require it as he was killed on the training field yesterday. Tsk. tsk. tsk.");
		e.other:SummonItem(5353); -- Item: Fine Steel Scimitar
		e.other:Ding();
		e.other:AddEXP(100);
	end
	item_lib.return_items(e.self, e.other, e.trade)
end

-- END of FILE Zone:freeportwest -- Lorme_Tredore
