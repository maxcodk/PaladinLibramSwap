First install this: https://github.com/pepopo978/nampower
Addon for paladins. Swaps librams without breaking GCD. 
1) Removes salva if you have righteous fury buff(includes https://github.com/maxcodk/PalSalvaRemover)
2) CastEquipByName(spellname,itemName)
3) PaladinConsecration() casts cosecration rank 1 if not in cooldown and equips Libram of the Faithful, use with shift - max rank
4) PaladinHolyShield() - casts max rank of holy shield and equips Libram of the Dreamguard, can use with shift for lower rank
5) PaladinHolyStrike() - casts max rank of holy strike and equips Libram of Radiance
6) PaladinBubble() first click with shift to activate divine shield, second to remove it, use without shift - no cancel
You have to create macro in game like 
/run PaladinConsecration()
/run CastEquipByName("Holy Shield","Libram of the Dreamguard")

Based on 
Shagu tutorial https://github.com/shagu/wow-vanilla-api/blob/master/tutorial/tutorial-01-enUS.md
LazyPig https://github.com/Lexiebean/_LazyPig
Super macro 

by Svarrog