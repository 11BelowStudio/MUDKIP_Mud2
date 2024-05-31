# MUDKIP_Mud2

## Multi User Dungeon Kool Informational Panels (for playing MUD2 with Mudlet)

**MUDKIP** is a plucky little [Mudlet](https://www.mudlet.org) plugin
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
and the most recent dreamword you recieved.

The only automation it currently offers is sending a `fes`
every so often whilst in-game (to obtain the current status of
your persona), and does this via sending one along with your
other commands.

**MUDKIP** unfortunately does *not* offer those bells and
whistles like speedwalking, fancy maps, re-fighting, etc.

### Aliases

* `(.+)` *(semi_auto_fes)*
  * This alias is currently used as a really hacky way of
  sneaking in the semi-automatic `fes` command every so often.
  * Every 20 seconds, assuming you're actually in the game
  (have entered the tearoom etc), *MUDKIP* will 'queue' a `fes`
  command, which, via this alias, will be appended onto the
  command you send to the server (otherwise your command is
  sent as-is, completely untouched).

### API

// TODO

* Everything's contained within the global `MUDKIP_Mud2` table.
* The stats etc with the current state of your persona are
  in the `MUDKIP_Mud2.stats` table.

## Final thoughts, how to contribute, thanks, things like that

*MUDKIP* is still a bit scuffed, and some of the implementation
details could use a bit of cleaning up. If you do want to help
out, feel free to open a PR on the `develop` branch.

This package was built using [muddler](https://github.com/demonnic/muddler),
in case you were wondering.
Consider taking a look at the documentation of muddler
if you wish to contribute to the development of *MUDKIP*.

### TODO

* add screenshots to this readme
