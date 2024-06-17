# CHANGELOG

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
