First install this: https://github.com/pepopo978/nampower
Addon for paladins. Swaps librams without triggering GCD. 
You press one button - you equip libram and use spell in one gcd
1) Removes salva if you have righteous fury buff(includes https://github.com/maxcodk/PalSalvaRemover)
2) CastEquipByName(spellname,itemName)
/run CastEquipByName("Holy Shield","Libram of the Dreamguard") - you can use any libram and spell in this function
3) PaladinConsecration() casts cosecration rank 1 if not in cooldown and equips Libram of the Faithful, use with shift - max rank
4) PaladinHolyShield() - casts max rank of holy shield and equips Libram of the Dreamguard, can use with shift for lower rank
5) PaladinHolyStrike() - casts max rank of holy strike and equips Libram of Radiance
6) PaladinBubble() first click with shift to activate divine shield, second to remove it, use without shift - no cancel
You have to create macro in game like 
/run PaladinConsecration()

Examples of macro with roid macro addon

#showtooltip Consecration
/run PaladinConsecration()

#showtooltip Holy Strike
/startattack
/run PaladinHolyStrike()

Based on 
Shagu tutorial https://github.com/shagu/wow-vanilla-api/blob/master/tutorial/tutorial-01-enUS.md
Super macro 

by Svarrog


