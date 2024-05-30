# MUDKIP_Mud2

## Multi User Dungeon Kool Informational Panels (for playing MUD2 with Mudlet)

**MUDKIP** is a plucky little Mudlet plugin I bodged together,
to add some kool informational panels that might be of use
whilst one is playing MUD2.

It adds some gauges at the bottom to show your current stamina
and magic (assuming you have any magic) at a glance, and adds
a status bar across the top with the raw stats on them (along
with afflictions, the dreamword, current points, etc.)

Yes, *MUDKIP* isn't complete. It still relies on you (the 
player) manually sending a `FES` every so often to update
some of the stats (albeit it can recognize most point/stamina/
etc update messages and react accordingly)




This is a template project created by muddler. It's meant to give you the basic skeleton to get started.
It is not a complete project, nor does it provide an example of every type of trigger scenario or keybinding corner case. It would make it even more difficult to clear out to make way for your own items.
It **will** properly muddle and create an mpackage, however.
For more detailed information on describing your triggers, scripts, etc in the json files, please see the [muddler wiki](https://github.com/demonnic/muddler/wiki)

This space is where I would normally put the description of my package and what it does/why I made it. But if you have a README format you already like, feel free to ignore all this.

## Installation

It's a good idea to provide installation instructions. I like to include a command they can copy/paste into the Mudlet commandline. Like

`lua uninstallPackage("MUDKIP_Mud2") installPackage("https://somedomain.org/path/to/my/package/MUDKIP_Mud2.mpackage")`

## Usage

Brief introduction to the overall usage. Then break it down to specifics

### Aliases

* `alias1 <param1>`
  * description of what the alias does, and what param1 is if it exists
    * example usage1
    * optional example usage2, etc
* `alias 2`
  * and so on, and so forth

### API

* `functionName(param1, param2)
  * Then, do the same thing for any Lua API which you want them to be able to use.
  * This part can be skipped if you have separate API documentation, but keep in mind the README.md file is accessible from the package manage in Mudlet, so this allows you to provide documentation within Mudlet, to a degree.

## Final thoughts, how to contribute, thanks, things like that

I like to put anything which doesn't fit with the above stuff here, at the end. It keeps the documentation like stuff at the top.


## notes

It looks like appending a `￼␛-[fes￼␛-]` to the start of any
command a player attempts to send **DURING GAMEPLAY** would work
to have some sort of auto-fes thing with minimal intrusion on
player experience? no idea how to go about doing that though.
