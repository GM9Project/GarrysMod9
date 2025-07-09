----------------------
- Client Lua scripts -
----------------------
There's a few differences between clientside Lua and serverside Lua.



First of all the engine binds don't start with _. Secondly all of the 
 commands are arranged in tables. These are two of my big regrets with 
 the serverside Lua implementation.


I'm trying to keep things as secure as possible so I'm leaving out some things
 on purpose right now because they'd be exploitable (reading files, writing files, 
 deleting files). I'll try to find solutions to some of these at a later date.


There's no need to type lua_c at the start of paths. It's always assumed that it will be in the lua_c folder.