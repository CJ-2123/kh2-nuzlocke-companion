LUAGUI_NAME = "KH2 start with 99 boosts"
LUAGUI_AUTH = "CJ"
LUAGUI_DESC = "Start with 99 Str and Mag Boosts"

function _OnInit() -- Runs during game initialization, only once
    kh2lib = require("kh2lib") -- Imports the KH2 Lua Library, detects game version, and populates the `kh2lib` table
    RequireKH2LibraryVersion(1) -- Declares the minimum version of the library required by this script
    RequirePCGameVersion() -- Declares that this script was only written for the PC ports of KH2 (optional)

    -- Can do this if desired to reduce noise in code later, or can reference these as `kh2lib.whatever` as needed
    -- (either way should work)
    CanExecute = kh2lib.CanExecute
    Now = kh2lib.Now
    Save = kh2lib.Save

    Log("99 Boosts") -- Using Log() will use an appropriate console print call per platform
end

function Events(M,B,E) --Check for Map, Btl, and Evt
return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function _OnFrame() -- Runs once per frame, game will wait for code to finish before proceeding to next frame
    -- Only allows code to run if required conditions were met
    if not CanExecute then
        return
    end

    World = ReadByte(Now + 0x00)
	Room = ReadByte(Now + 0x01)
	Place = ReadShort(Now + 0x00)
	Door = ReadShort(Now + 0x02)
	Map = ReadShort(Now + 0x04)
	Btl = ReadShort(Now + 0x06)
	Evt = ReadShort(Now + 0x08)
    NewGame()
end

function NewGame()
--Before New Game
if Place == 0x2002 and Events(0x01,Null,0x01) then --Station of Serenity Weapons
	StartingBoosts()
end
end

function StartingBoosts()
	WriteByte(Save+0x3666,99) --PowerBoost
	WriteByte(Save+0x3667,99) --MagicBoost
    WriteByte(Save+0x3668,99) --DefenseBoost
end
