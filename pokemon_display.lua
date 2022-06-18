local json = require("dkjson")

-- Data.
local party_count_adr = 0x1CD7
local first_party_pkm_adr = 0x1CDF

local pkm_names = { "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
    "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree",
    "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
    "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash",
    "NidoranF", "Nidorina", "Nidoqueen", "NidoranM", "Nidorino", "Nidoking",
    "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
    "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth",
    "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape",
    "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
    "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel",
    "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
    "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
    "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
    "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak",
    "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey",
    "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie",
    "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados",
    "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
    "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres",
    "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",

    "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion",
    "Totodile", "Croconaw", "Feraligatr", "Sentret", "Furret", "Hoothoot", "Noctowl",
    "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn", "Pichu", "Cleffa",
    "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
    "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom",
    "Sunkern", "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking",
    "Misdreavus", "Unown", "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar",
    "Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel",
    "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola", "Remoraid", "Octillery",
    "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
    "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank",
    "Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",

    "", "Egg"
}

local move_names = { "Pound", "Karate Chop", "Doubleslap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch",
    "Ice Punch", "Thunderpunch", "Scratch", "Vicegrip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust",
    "Wing Attack", "Whirlwind", "Fly", "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick",
    "Rolling Kick", "Sand-attack", "Headbutt", "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap",
    "Take Down", "Thrash", "Double-edge", "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite",
    "Growl", "Roar", "Sing", "Supersonic", "Sonicboom", "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun",
    "Hydro Pump", "Surf", "Ice Beam", "Blizzard", "Psybeam", "Bubblebeam", "Aurora Beam", "Hyper Beam", "Peck",
    "Drill Peck", "Submission", "Low Kick", "Counter", "Seismic Toss", "Strength", "Absorb", "Mega Drain", "Leech Seed",
    "Growth", "Razor Leaf", "Solarbeam", "Poisonpowder", "Stun Spore", "Sleep Powder", "Petal Dance", "String Shot",
    "Dragon Rage", "Fire Spin", "Thundershock", "Thunderbolt", "Thunder Wave", "Thunder", "Rock Throw", "Earthquake",
    "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate", "Agility", "Quick Attack", "Rage",
    "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden", "Minimize", "Smokescreen",
    "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect", "Focus Energy", "Bide",
    "Metronome", "Mirror Move", "Selfdestruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club", "Fire Blast",
    "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Softboiled",
    "Hi Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack",
    "Transform", "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer", "Explosion",
    "Fury Swipes", "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack", "Super Fang",
    "Slash", "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader", "Nightmare",
    "Flame Wheel", "Snore", "Curse", "Flail", "Conversion2", "Aeroblast", "Cotton Spore", "Reversal", "Spite",
    "Powder Snow", "Protect", "Mach Punch", "Scary Face", "Faint Attack", "Sweet Kiss", "Belly Drum", "Sludge Bomb",
    "Mud-slap", "Octazooka", "Spikes", "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song", "Icy Wind", "Detect",
    "Bone Rush", "Lock-on", "Outrage", "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout", "False Swipe", "Swagger",
    "Milk Drink", "Spark", "Fury Cutter", "Steel Wing", "Mean Look", "Attract", "Sleep Talk", "Heal Bell", "Return",
    "Present", "Frustration", "Safeguard", "Pain Split", "Sacred Fire", "Magnitude", "Dynamicpunch", "Megahorn",
    "Dragonbreath", "Baton Pass", "Encore", "Pursuit", "Rapid Spin", "Sweet Scent", "Iron Tail", "Metal Claw",
    "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power", "Cross Chop", "Twister", "Rain Dance",
    "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extremespeed", "Ancientpower", "Shadow Ball", "Future Sight",
    "Rock Smash", "Whirlpool", "Beat Up" }

-- Code.

--[[
    Memory layout doc: https://datacrystal.romhacking.net/wiki/Pok%C3%A9mon_Crystal:RAM_map#Party
]]

-- Figure out if we are working with numbered or named sprites.
local function guess_sprite_name_type()
    local numbered = io.open("./sprites/133.png", "r")
    local named = io.open("./sprites/eevee.png", "r")

    if numbered ~= nil and named == nil then
        return "numbered"
    end

    if numbered == nil and named ~= nil then
        return "named"
    end

    if numbered ~= nil and named ~= nil then
        print("Found both named and numbered sprites. Defaulting to numbered sprites.")
        return "numbered"
    end

    if numbered == nil and named == nil then
        print("Could not find sprites.")
        return ""
    end
end

local function write_to_slot(sprite_name, slot)
    local sprite_path = "./sprites/" .. sprite_name .. ".png"
    local input = io.open(sprite_path, "rb")
    if input == nil then
        print("Could not open " .. sprite_path)
        return
    end

    local output = io.open("./party/" .. tostring(slot) .. ".png", "wb")
    if output == nil then
        input:close()
        print("Could not open party slot " .. tostring(slot) .. " to write new pokemon.")
        return
    end

    local data = input:read("*a")
    output:write(data)

    output:close()
    input:close()
end

local function write_party(party, sprite_type)
    for i = 1, 6, 1 do
        local pkm = party[i]
        if pkm ~= nil then
            if sprite_type == "numbered" then
                write_to_slot(tostring(pkm.species), i)
            else
                write_to_slot(pkm.species_name, i)
            end
        else
            write_to_slot("0", i)
        end
    end
end

local function main()
    local old_party_json = ""
    local sprite_type = guess_sprite_name_type()

    if sprite_type == "" then
        print("Sprites are either missing or incomplete.")
        return
    end

    while true do
        -- Read data.
        local party_size = mainmemory.read_u8(party_count_adr)
        local party = {}
        for i = first_party_pkm_adr, first_party_pkm_adr + (party_size - 1) * 48, 48 do
            local pkm = {}

            -- Kind of Pokémon.
            pkm.species = mainmemory.read_u8(i)
            pkm.species_name = pkm_names[pkm.species]

            --[[

            -- Level.
            pkm.level = mainmemory.read_u8(i + 31)
    
            -- Stats.
            pkm.stats = {}
            pkm.hp = mainmemory.read_u16_be(i + 34)
            pkm.stats.max_hp = mainmemory.read_u16_be(i + 36)
            pkm.stats.atack = mainmemory.read_u16_be(i + 38)
            pkm.stats.defense = mainmemory.read_u16_be(i + 40)
            pkm.stats.speed = mainmemory.read_u16_be(i + 42)
            pkm.stats.special_attack = mainmemory.read_u16_be(i + 44)
            pkm.stats.special_defense = mainmemory.read_u16_be(i + 46)
    
            -- Stat exp ???
            pkm.stat_exp = {}
            pkm.stat_exp.hp = mainmemory.read_u16_be(i + 11)
            pkm.stat_exp.attack = mainmemory.read_u16_be(i + 13)
            pkm.stat_exp.defense = mainmemory.read_u16_be(i + 15)
            pkm.stat_exp.speed = mainmemory.read_u16_be(i + 17)
            pkm.stat_exp.special = mainmemory.read_u16_be(i + 19)
    
            -- DVs
            local dvs = mainmemory.read_u16_be(i + 21)
            pkm.dvs = {}
            pkm.dvs.attack = bit.rshift(dvs, 12)
            pkm.dvs.defense = bit.band(bit.rshift(dvs, 8), 15) -- 15 = 0b1111
            pkm.dvs.speed = bit.band(bit.rshift(dvs, 4), 15)
            pkm.dvs.special = bit.band(dvs, 15)
    
            -- Moves.
            pkm.moves = {}
            for j = i + 2, i + 5, 1 do
                table.insert(pkm.moves, move_names[mainmemory.read_u8(j)])
            end
            ]]

            -- Add to array.
            table.insert(party, pkm)
        end

        -- Save data.
        local party_json = json.encode(party, { indent = true })
        if party_json ~= old_party_json then
            old_party_json = party_json
            write_party(party, sprite_type)
        end

        -- Go to next frame.
        emu.frameadvance();
    end
end

main()
