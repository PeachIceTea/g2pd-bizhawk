# g2pd-bizhawk - Gen 2 Pokemon Display for bizhawk

## What?
This script allows streamers to display their current party to their viewers. There are a few scripts for vba-rr this script works with [Bizhawk](https://tasvideos.org/Bizhawk).


## Setup
1. Get [Bizhawk](https://tasvideos.org/Bizhawk) if you don't already use it.

2. [Get the latest version of g2pd-bizhawk](https://github.com/PeachIceTea/g2pd-bizhawk/archive/master.zip).

3. Get sprites you like. I used [these](https://veekun.com/dex/downloads). Also, there needs to be a 0.png that matches the dimensions of the other sprites but is emtpy. For eggs there needs to be a egg.png.

4. Extract g1pd into its own folder.

5. Extract the sprites into the "sprites" folder.

6. Run Bizhawk and when the game is loaded. Load the script by going to Tools -> Lua Console and then clicking onm the little folder icon and opening the "pokemon_display.lua".

7. Add the png files in the "party" folder to your OBS overlay.

## Note
Currently only Pokemon Crystal is supported.

## Licenses

g2pd uses on David Kolf's JSON module for Lua 5.1 - 5.4 which is licensed under the MIT license.

g2pd itself is licensed under GPL-3.0.