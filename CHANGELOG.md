# CHANGELOG

## 1.3.6

*10/10/2024*

* Changed the blanked-out line placeholder to be something that MUD2 genuinely cannot comprehend (I think) but hopefully won't accidentally cause mishaps to happen
* (theoretically) added support for being invisible

## 1.3.5

*20/9/2024*

* Fixed bug that made MUDKIP not respond to `qs` when using a persona who has magic.
* Added a couple of triggers to (hopefully) update one's stats if after using a spell.
* (I have a persona who has magic again so I've only just noticed and fixed these issues xd)

## 1.3.4

*16/9/2024*

* Found workaround for issue which turned the helpful tooltips on the stamina/magic bars into unreadable black rectangles.

## 1.3.3

*24/7/2024*

* Made MUDKIP look a bit less terrible on Mudlet 4.18.3 (seeing as that update changed a few things with geyser unexpectedly)

## 1.3.2

*27/6/2024*

* MUDKIP now recognizes the stamina update messages from `fightbrief` (hopefully)

## 1.3.1

*26/6/2024*

* Added some code to make MUDKIP clean up after itself after it gets uninstalled.
* Stamina is now displayed as 0 if you get permadeathed in the ways which bypass stamina.
* Some refactorings have happened.
* Removed some deprecated legacy code.

## 1.3.0

*18/6/2024*

* The output of `map` is now on 3 lines (not 11) and is now ***CLICKABLE!*** so you can go in a certain direction *without* needing to type stuff in (just click on the appropriate thingy!)
  * Remember that MUD2 allows you to use `auto map` to automagically send a `map` command whenever you move to a new room!
  * (note: only the most recent `map` output has clickable directions, to avoid potential misclicks whilst scrolling up)
* also added a couple more typo-correction aliases
* auto-fes timer is now 15 seconds (was 20)

## 1.2.0

*17/6/2024*

* Rewrote the automatic update code a little bit.
* Using the `dword` alias will clear the known dreamword.
  * Also added a `DWORD` alias for saying the dreamword IN CAPITALS (for personae who tend to say things in capitals)
* Added an alias to fix accidentally putting an 's' at the end of emote-y commands whilst in game (correcting `smiles` to `smile`, `waves` into `wave`, `laughs` into `laugh` etc).
* Renamed the package to `Multi User Dungeon Kool Informational Package for MUD2` (says `Package` instead of `Panels`)

## 1.1.2

*7/6/2024*

* Fixed automatic updates (forgot to delete the downloaded version check file :P)

## 1.1.1

*7/6/2024*

* Added automatic updates so you (hopefully) don't need to manually update MUDKIP any more :)

## 1.1.0

*7/6/2024*

* Replaced the 'semi-automatic' fes (implemented poorly via aliases) with an automatic fes
  (sends `fes` every 20 seconds whilst in-game to update the status bars etc.)
* Now shows version number in the status bar
* Added `dword` alias to automatically say the dreamword (if known).
* Some backend changes

## 1.0.0

*31/5/2024*

* Initial release.
* Stat bars on the bottom for stamina/magic
* Status line on the top showing stamina, magic, strength, dexterity, points, afflictions, dreamword, weather, and time until reset.
