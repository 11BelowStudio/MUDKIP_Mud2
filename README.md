# MUDKIP_Mud2

## Multi User Dungeon Kool Informational Package (for playing MUD2 with Mudlet)

**MUDKIP** is a plucky little [Mudlet](https://www.mudlet.org) package
I bodged together, which adds some Kool Informational Panels
that might be of use whilst one is playing *MUD2*.

It adds some gauges at the bottom to show your current stamina
and magic (assuming you have any magic) at a glance, and adds
a status bar across the top with the raw stats on them (along
with afflictions, the dreamword, current points, etc.)

This is a plugin for Mudlet, *not a standalone MUD client!*
Please ensure you have Mudlet installed and are using Mudlet.

And, again, this is *only intended to be used for MUD2!*
This is very unlikely to work on any other MUD, so don't try it.

also yes, we have auto-updates now (very nice)

![a screenshot of MUDKIP being used in mudlet](/docs/readme.png)

## Installation and Uninstallation

### Installation

Open your MUD2 profile in mudlet and enter the following command:

`lua installPackage("https://github.com/11BelowStudio/MUDKIP_Mud2/releases/latest/download/MUDKIP_Mud2.mpackage")`

### Uninstallation

Open your MUD2 profile in mudlet and enter this command:

`lua uninstallPackage("MUDKIP_Mud2")`

(or just use mudlet's package manager menu thing to uninstall it)

## Usage

The main thing *MUDKIP* does is add the status indicators
mentioned above. It shows your stats at a glance, current
status afflictions, current weather, time until the next reset,
and the most recent dreamword you received.

The only automation it currently offers is sending a `fes`
every so often whilst in-game (to obtain the current status of
your persona), and an alias for saying the dreamword (if known)

**MUDKIP** unfortunately does *not* offer those bells and
whistles like speedwalking, fancy maps, re-fighting, etc.

### Aliases

* **automatic dreamword** `dword`
  * If the dreamword is known, this will send a `say <dreamword>` command to the game.
    * If the dreamword is not known, MUDKIP will leave a message
    telling you that it doesn't know what the dreamword is.
  * `dwo` and `dwor` are also aliases for this.
  * There's an uppercase variant which says the dreamword in uppercase instead.
* **fixing emotes**
  * Tired of accidentally sending `laughs`,`smiles`,`waves` etc
    and then having the MUD2 parser complain about it?
  * *MUDKIP_Mud2* will correct them to `laugh`, `smile`, `wave` etc, allowing you to perform those actions in peace.
  * Many other verbs along these lines have also been fixed.

### API

// TODO

* Everything's contained within the global `MUDKIP_Mud2` table.
* The stats etc with the current state of your persona are
  in the `MUDKIP_Mud2.stats` table.
* Misc utils are in `MUDKIP_Mud2.utils`.
* UI stuff is held in `MUDKIP_Mud2.ui`
* Auto-update stuff is held in `MUDKIP_Mud2.updates`
* Stuff related to the enhanced `map` command output is in `MUDKIP_Mud2.map`

## Final thoughts, how to contribute, thanks, things like that

*MUDKIP* is still a bit scuffed, and some of the implementation
details could use a bit of cleaning up. If you do want to help
out, feel free to open a PR on the `develop` branch.

This package was built using [muddler](https://github.com/demonnic/muddler),
in case you were wondering.
Consider taking a look at the documentation of muddler
if you wish to contribute to the development of *MUDKIP*.

## CHANGELOG

* **1.3.2** (`27/6/2024`)
  * Now (hopefully) works with the stamina update messages from `fightbrief`!

See [CHANGELOG.md](https://github.com/11BelowStudio/MUDKIP_Mud2/blob/main/CHANGELOG.md) for the full changelog.

## TODO

* see what people want I guess
* get the auto-update to check the tag on the latest release on git or something like that instead of the release version.txt(?)
