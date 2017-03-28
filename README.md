A completely new client that borrows a large amount of features from nilly's client. The aim is to create a client that you don't need a proxy with. Originally this was my private client with the first version being for build X5.

**Feature Highlights:**
Immortality
Compact UI
- If you have backpack the contents of it are always visible, else your stats will be shown instead
- To see your stats and pet levels, press the tab switch key (default: B)
- A cooldown timer will be shown on your ability icon when it's on cooldown
/con command
- Usage: /con <server> <realm> <character>
- Any or all of the parameters can be left out and you can freely order them as wanted
- Server parameter is the abbreviation of its name (e.g. uss2), for proxy server do "/con p"
- Character names don't have to be fully written (e.g. "/con kn" will change to knight)
- Same goes for realm names and you must have visited the desired realm before, "v" can be to connect to vault
- Example usage: "/con tr v" connects to vault on the same server with trickster
Autoloot remade
- Works similarly to my autoloot plugin for K Relay
- Loots hp and mp potions to inventory and places them on the potion slots when there is free space
- Lots of customization options
Auto ability
- Works with priest, rogue, paladin and warrior
- Priest heals automatically
- The other classes will repeatedly use their ability after you've pressed space once, press again to stop
Anti lag and visual hacks
- Most particles are disabled
- Pets and skins can be turned off
Ability autoaim
- Autoaims spell bomb, quivers and stuns
- Will not shoot when there are no enemies or if the enemy is invulnerable
Timers
- Cloak timer
- Oryx and wine cellar portal timers
Quest bars
- Shows the health of your quest
Tomb hack
- Allows you to toggle which boss you're damaging for a guaranteed clean tomb
- HUD shows all the tomb bosses' remaining health
Reconnect
- Allows reconnecting to realms even after restarting client
Sprite world hacks
- Lightspeed: Makes you absurdly fast in sprite world, use the toggle key to be able to fight the boss
- No trees
- No clip that only works in sprite world
Auto pot
- Can be set to drink potions automatically
Fame notifier
- Notifies you when you earn fame
- To see fame statistic type /fame
Prism and planewalker hack
- Allows teleporting to black areas when unsafe prism use is enabled
- Makes you teleport the max distance when enabled in settings and a key is pressed (requires you to be standing still)
- With these 2 combined you can do huge skips: mad lab second boss can be done without killing teslas and sewer boss can be teleported to if you're close enough to the boss room (the radius is huge)
Auto login reward claimer

**New features:**
Custom messages
Shrink large objects
Godlands snow is now brown
Sliding on ice can be toggled
Inc finder
Teleport to caller
- Press the key to teleport the someone who called a dungeon in the tplist (Default: lab, sewer, manor)
Disable client swap
- Makes items not teleport back when moving them in your inventory
Best server selector
Fast connect
No seeing double when standing close to a wall
Self backpack viewer
- Shows your the contents of your characters' backpacks in character selection screen
Popup blocker
- New packages will never open in a popup window

**New commands:**
Friend system
- You can join friends by asking their location (/tell <friend> s?)
- Now use /con command without parameters to connect to the same realm your friend is playing on
- /afr <friend>, /rfr <friend>, /frclear, /frlist to manage friends, a player must have you friended to be able to ask their location
Spamfilter
- /asp <text>, /rsp <text>, /spclear, /splist, /spdefault to manage filtered text
Tplist
- /atp <keyword>, /rtp <keyword>, /tpclear, /tplist, /tpdefault to manage teleport keywords
- Set a key in options to teleport to the last person who called the keyword
/serv tells you the server you're on
Realmeye commands
- /hide
- /friends
- /roll
- /mates
- /player <player> visit player's realmeye profile
- /sell <potion1> <potion2> see who's buying potion1 for potion2
- /sell <slot> see who's buying the item on that slot for life
/l2m or /left2max to see how much many potions are needed to be maxed
/tut to visit nexus tutorial
/tr trades with the last person you've gotten a tell from
/re repeats your last message
/re <player> repeats your last tell but changes the recipient
/fame for fame statistics
/s to switch all items from backpack to inventory and vice versa
/timer <count> <step> start a timer which ticks %count% times every %step% milliseconds
/setmsg <id> <message> set a bind in options for a custom message, id can be from 1 to 3

**Borrowed features:**
Auto aim
- nilly's autoaim with extra spices
- Shoots tesla coils and prioritizes them
- Prioritizes ghost gods over other gods (deadliest)
- Shoots through invulnerable enemies (web spawners, oryx defenders, etc.)
Hp display
- Fixed color of armor broken damage
Inventory and stats viewer
- Shows backpack content
Star requirement (hide)
- now hides player on your nearby player display as well
Display mob info
Highlight locked players
No debuffs
- Added color to indicate that the hack is not on
Autonexus
- /autonex <0-100> sets auto nexus percentage
- /autopot <0-100> sets auto pot percentage
- /autoheal <0-100> sets auto heal percentage
Projectile no clip
- This is not visible to others, they can only see damage being dealt through walls
Disable trade delay
Safe walk
Spammable notifications
Hp bars
- 16x16 enemies now have larger bars
- The bar is thinner now
Hotkey swap
- Swap items by using the inventory hotkeys
No quest delay
- Quest arrow no longer becomes large when mouse is on it
Abilities can be used when mouse is over the void
Old menu screen
Spammable notifications
