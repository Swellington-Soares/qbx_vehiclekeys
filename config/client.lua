---@alias Difficulty 'easy' | 'medium' | 'hard' | {areaSize: number, speedMultiplier: number}

---Arguments of https://overextended.dev/ox_lib/Modules/Interface/Client/skillcheck
---@class SkillCheckConfig
---@field difficulty Difficulty[]
---@field inputs? string[]

---@type SkillCheckConfig
local easyLockpickSkillCheck = {
    difficulty = { 'easy', 'easy', { areaSize = 60, speedMultiplier = 1 }, 'medium' },
    inputs = { '1', '2', '3' }
}

---@type SkillCheckConfig
local normalLockpickSkillCheck = {
    difficulty = { 'easy', 'easy', { areaSize = 60, speedMultiplier = 1 }, 'medium' },
    inputs = { '1', '2', '3', '4' }
}

---@type SkillCheckConfig
local hardLockpickSkillCheck = {
    difficulty = { 'easy', 'easy', { areaSize = 60, speedMultiplier = 2 }, 'medium' },
    inputs = { '1', '2', '3', '4' }
}

---@alias Anim {dict: string, clip: string, delay?: integer}

---@type Anim
local defaultHotwireAnim = { dict = 'anim@veh@plane@howard@front@ds@base', clip = 'hotwire' }

---@type Anim
local defaultSearchKeysAnim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' }

---@type Anim
local defaultLockpickAnim = { dict = 'veh@break_in@0h@p_m_one@', clip = 'low_force_entry_ds' }

---@type Anim
local defaultHoldupAnim = { dict = 'mp_am_hold_up', clip = 'holdup_victim_20s' }

return {
    vehicleMaximumLockingDistance = 5.0, -- Minimum distance for vehicle locking

    getKeysWhenEngineIsRunning = true, -- when enabled, gives keys to a player who doesn't have them if they enter the driver seat when the engine is running

    keepEngineOnWhenAbandoned = true, -- when enabled, keeps a vehicle's engine running after exiting

    -- Carjack Settings
    carjackEnable = true,                -- Enables the ability to carjack pedestrian vehicles, stealing them by pointing a weapon at them
    carjackingTimeInMs = 7500,           -- Time it takes to successfully carjack in miliseconds
    delayBetweenCarjackingsInMs = 10000, -- Time before you can attempt another carjack in miliseconds

    -- Hotwire Settings
    timeBetweenHotwires = 5000, -- Time in milliseconds between hotwire attempts
    minKeysSearchTime = 20000,  -- Minimum hotwire time in milliseconds
    maxKeysSearchTime = 40000,  -- Maximum hotwire time in milliseconds

    -- Police Alert Settings
    alertCooldown = 10000,         -- Cooldown period in milliseconds (10 seconds)
    policeAlertChance = 0.75,      -- Chance of alerting the police during the day
    policeNightAlertChance = 0.50, -- Chance of alerting the police at night (times: 01-06)
    policeAlertNightStartHour = 1,
    policeAlertNightDuration = 5,
    ---Sends an alert to police
    ---@param crime string
    ---@param vehicle number entity
    alertPolice = function(crime, vehicle)
        TriggerServerEvent('police:server:policeAlert', locale("info.vehicle_theft") .. crime)
    end,

    vehicleAlarmDuration = 10000,
    lockpickCooldown = 1000,
    hotwireCooldown = 1000,

    -- Job Settings
    sharedKeys = { -- Share keys amongst employees. Employees can lock/unlock any job-listed vehicle
        police = { -- Job name
            enableAutolock = true,
            requireOnduty = true,
            classes = {},
            vehicles = {
                [`police`] = true,  -- Vehicle model
                [`police2`] = true, -- Vehicle model
            }
        },
        ambulance = {
            enableAutolock = true,
            requireOnduty = true,
            classes = {},
            vehicles = {
                [`ambulance`] = true,
            },
        },
        mechanic = {
            requireOnduty = false,
            vehicles = {
                [`towtruck`] = true,
            }
        }
    },

    ---@class SkillCheckConfigEntry
    ---@field default SkillCheckConfig
    ---@field class table<VehicleClass, SkillCheckConfig | {}>
    ---@field model table<number, SkillCheckConfig>

    ---@class SkillCheckEntities
    ---@field lockpick SkillCheckConfigEntry
    ---@field advancedLockpick SkillCheckConfigEntry
    ---@field hotwire SkillCheckConfigEntry
    ---@field advancedHotwire SkillCheckConfigEntry

    ---@type SkillCheckEntities
    skillCheck = {
        lockpick = {
            default = normalLockpickSkillCheck,
            class = {
                [VehicleClass.COMPACTS]        = normalLockpickSkillCheck,
                [VehicleClass.SEDANS]          = normalLockpickSkillCheck,
                [VehicleClass.SUVS]            = normalLockpickSkillCheck,
                [VehicleClass.COUPES]          = normalLockpickSkillCheck,
                [VehicleClass.MUSCLE]          = normalLockpickSkillCheck,
                [VehicleClass.SPORTS_CLASSICS] = normalLockpickSkillCheck,
                [VehicleClass.SPORTS]          = normalLockpickSkillCheck,
                [VehicleClass.SUPER]           = normalLockpickSkillCheck,
                [VehicleClass.MOTORCYCLES]     = normalLockpickSkillCheck,
                [VehicleClass.OFF_ROAD]        = normalLockpickSkillCheck,
                [VehicleClass.INDUSTRIAL]      = normalLockpickSkillCheck,
                [VehicleClass.UTILITY]         = normalLockpickSkillCheck,
                [VehicleClass.VANS]            = normalLockpickSkillCheck,
                [VehicleClass.BOATS]           = normalLockpickSkillCheck,
                [VehicleClass.HELICOPTERS]     = {},
                [VehicleClass.PLANES]          = normalLockpickSkillCheck,
                [VehicleClass.SERVICE]         = normalLockpickSkillCheck,
                [VehicleClass.EMERGENCY]       = hardLockpickSkillCheck,
                [VehicleClass.MILITARY]        = {},                          -- The vehicle class can only be opened with an advanced lockpick
                [VehicleClass.COMMERCIAL]      = normalLockpickSkillCheck,
                [VehicleClass.TRAINS]          = {},
                [VehicleClass.OPEN_WHEEL]      = easyLockpickSkillCheck,
            },
            model = {
                [`zombiea`] = normalLockpickSkillCheck
            }
        },
        advancedLockpick = {
            default = easyLockpickSkillCheck,
            class = {
                [VehicleClass.COMPACTS]        = easyLockpickSkillCheck,
                [VehicleClass.SEDANS]          = easyLockpickSkillCheck,
                [VehicleClass.SUVS]            = easyLockpickSkillCheck,
                [VehicleClass.COUPES]          = easyLockpickSkillCheck,
                [VehicleClass.MUSCLE]          = easyLockpickSkillCheck,
                [VehicleClass.SPORTS_CLASSICS] = easyLockpickSkillCheck,
                [VehicleClass.SPORTS]          = easyLockpickSkillCheck,
                [VehicleClass.SUPER]           = easyLockpickSkillCheck,
                [VehicleClass.MOTORCYCLES]     = easyLockpickSkillCheck,
                [VehicleClass.OFF_ROAD]        = easyLockpickSkillCheck,
                [VehicleClass.INDUSTRIAL]      = easyLockpickSkillCheck,
                [VehicleClass.UTILITY]         = easyLockpickSkillCheck,
                [VehicleClass.VANS]            = easyLockpickSkillCheck,
                [VehicleClass.BOATS]           = easyLockpickSkillCheck,
                [VehicleClass.HELICOPTERS]     = hardLockpickSkillCheck,
                [VehicleClass.PLANES]          = hardLockpickSkillCheck,
                [VehicleClass.SERVICE]         = easyLockpickSkillCheck,
                [VehicleClass.EMERGENCY]       = easyLockpickSkillCheck,
                [VehicleClass.MILITARY]        = hardLockpickSkillCheck,
                [VehicleClass.COMMERCIAL]      = easyLockpickSkillCheck,
                [VehicleClass.TRAINS]          = {},                         -- The vehicle class can't be opened with an lockpick
                [VehicleClass.OPEN_WHEEL]      = easyLockpickSkillCheck,
            },
            model = {
                [`zombiea`] = easyLockpickSkillCheck
            }
        },
        hotwire = {
            default = normalLockpickSkillCheck,
            class = {
                [VehicleClass.COMPACTS]        = normalLockpickSkillCheck,
                [VehicleClass.SEDANS]          = normalLockpickSkillCheck,
                [VehicleClass.SUVS]            = normalLockpickSkillCheck,
                [VehicleClass.COUPES]          = normalLockpickSkillCheck,
                [VehicleClass.MUSCLE]          = normalLockpickSkillCheck,
                [VehicleClass.SPORTS_CLASSICS] = normalLockpickSkillCheck,
                [VehicleClass.SPORTS]          = normalLockpickSkillCheck,
                [VehicleClass.SUPER]           = normalLockpickSkillCheck,
                [VehicleClass.MOTORCYCLES]     = normalLockpickSkillCheck,
                [VehicleClass.OFF_ROAD]        = normalLockpickSkillCheck,
                [VehicleClass.INDUSTRIAL]      = normalLockpickSkillCheck,
                [VehicleClass.UTILITY]         = normalLockpickSkillCheck,
                [VehicleClass.VANS]            = normalLockpickSkillCheck,
                [VehicleClass.BOATS]           = normalLockpickSkillCheck,
                [VehicleClass.HELICOPTERS]     = {},
                [VehicleClass.PLANES]          = normalLockpickSkillCheck,
                [VehicleClass.SERVICE]         = normalLockpickSkillCheck,
                [VehicleClass.EMERGENCY]       = hardLockpickSkillCheck,
                [VehicleClass.MILITARY]        = {},
                [VehicleClass.COMMERCIAL]      = normalLockpickSkillCheck,
                [VehicleClass.TRAINS]          = {},
                [VehicleClass.OPEN_WHEEL]      = easyLockpickSkillCheck,
            },
            model = {
                [`zombiea`] = normalLockpickSkillCheck
            }
        },
        advancedHotwire = {
            default = easyLockpickSkillCheck,
            class = {
                [VehicleClass.COMPACTS]        = easyLockpickSkillCheck,
                [VehicleClass.SEDANS]          = easyLockpickSkillCheck,
                [VehicleClass.SUVS]            = easyLockpickSkillCheck,
                [VehicleClass.COUPES]          = easyLockpickSkillCheck,
                [VehicleClass.MUSCLE]          = easyLockpickSkillCheck,
                [VehicleClass.SPORTS_CLASSICS] = easyLockpickSkillCheck,
                [VehicleClass.SPORTS]          = easyLockpickSkillCheck,
                [VehicleClass.SUPER]           = easyLockpickSkillCheck,
                [VehicleClass.MOTORCYCLES]     = easyLockpickSkillCheck,
                [VehicleClass.OFF_ROAD]        = easyLockpickSkillCheck,
                [VehicleClass.INDUSTRIAL]      = easyLockpickSkillCheck,
                [VehicleClass.UTILITY]         = easyLockpickSkillCheck,
                [VehicleClass.VANS]            = easyLockpickSkillCheck,
                [VehicleClass.BOATS]           = easyLockpickSkillCheck,
                [VehicleClass.HELICOPTERS]     = hardLockpickSkillCheck,
                [VehicleClass.PLANES]          = hardLockpickSkillCheck,
                [VehicleClass.SERVICE]         = easyLockpickSkillCheck,
                [VehicleClass.EMERGENCY]       = easyLockpickSkillCheck,
                [VehicleClass.MILITARY]        = hardLockpickSkillCheck,
                [VehicleClass.COMMERCIAL]      = easyLockpickSkillCheck,
                [VehicleClass.TRAINS]          = {},                         -- The vehicle class can't be hotwired
                [VehicleClass.OPEN_WHEEL]      = easyLockpickSkillCheck,
            },
            model = {
                [`zombiea`] = easyLockpickSkillCheck
            }
        }
    },

    ---@class AnimConfigEntry
    ---@field default Anim
    ---@field class table<VehicleClass, Anim | {}>
    ---@field model table<number, Anim>

    ---@class AnimConfigEntities
    ---@field hotwire AnimConfigEntry
    ---@field searchKeys AnimConfigEntry
    ---@field lockpick AnimConfigEntry
    ---@field holdup AnimConfigEntry
    ---@field toggleEngine AnimConfigEntry

    ---@type AnimConfigEntities
    anims = {
        hotwire = {
            default = defaultHotwireAnim,
            class = {
                [VehicleClass.COMPACTS]        = defaultHotwireAnim,
                [VehicleClass.SEDANS]          = defaultHotwireAnim,
                [VehicleClass.SUVS]            = defaultHotwireAnim,
                [VehicleClass.COUPES]          = defaultHotwireAnim,
                [VehicleClass.MUSCLE]          = defaultHotwireAnim,
                [VehicleClass.SPORTS_CLASSICS] = defaultHotwireAnim,
                [VehicleClass.SPORTS]          = defaultHotwireAnim,
                [VehicleClass.SUPER]           = defaultHotwireAnim,
                [VehicleClass.MOTORCYCLES]     = defaultHotwireAnim,
                [VehicleClass.OFF_ROAD]        = defaultHotwireAnim,
                [VehicleClass.INDUSTRIAL]      = defaultHotwireAnim,
                [VehicleClass.UTILITY]         = defaultHotwireAnim,
                [VehicleClass.VANS]            = defaultHotwireAnim,
                [VehicleClass.BOATS]           = defaultHotwireAnim,
                [VehicleClass.HELICOPTERS]     = defaultHotwireAnim,
                [VehicleClass.PLANES]          = defaultHotwireAnim,
                [VehicleClass.SERVICE]         = defaultHotwireAnim,
                [VehicleClass.EMERGENCY]       = defaultHotwireAnim,
                [VehicleClass.MILITARY]        = defaultHotwireAnim,
                [VehicleClass.COMMERCIAL]      = defaultHotwireAnim,
                [VehicleClass.TRAINS]          = defaultHotwireAnim,
                [VehicleClass.OPEN_WHEEL]      = defaultHotwireAnim,
            },
            model = {
                [`zombiea`] = defaultHotwireAnim
            }
        },
        searchKeys = {
            default = defaultSearchKeysAnim,
            class = {
                [VehicleClass.COMPACTS]        = defaultSearchKeysAnim,
                [VehicleClass.SEDANS]          = defaultSearchKeysAnim,
                [VehicleClass.SUVS]            = defaultSearchKeysAnim,
                [VehicleClass.COUPES]          = defaultSearchKeysAnim,
                [VehicleClass.MUSCLE]          = defaultSearchKeysAnim,
                [VehicleClass.SPORTS_CLASSICS] = defaultSearchKeysAnim,
                [VehicleClass.SPORTS]          = defaultSearchKeysAnim,
                [VehicleClass.SUPER]           = defaultSearchKeysAnim,
                [VehicleClass.MOTORCYCLES]     = defaultSearchKeysAnim,
                [VehicleClass.OFF_ROAD]        = defaultSearchKeysAnim,
                [VehicleClass.INDUSTRIAL]      = defaultSearchKeysAnim,
                [VehicleClass.UTILITY]         = defaultSearchKeysAnim,
                [VehicleClass.VANS]            = defaultSearchKeysAnim,
                [VehicleClass.BOATS]           = defaultSearchKeysAnim,
                [VehicleClass.HELICOPTERS]     = defaultSearchKeysAnim,
                [VehicleClass.PLANES]          = defaultSearchKeysAnim,
                [VehicleClass.SERVICE]         = defaultSearchKeysAnim,
                [VehicleClass.EMERGENCY]       = defaultSearchKeysAnim,
                [VehicleClass.MILITARY]        = defaultSearchKeysAnim,
                [VehicleClass.COMMERCIAL]      = defaultSearchKeysAnim,
                [VehicleClass.TRAINS]          = defaultSearchKeysAnim,
                [VehicleClass.OPEN_WHEEL]      = defaultSearchKeysAnim,
            },
            model = {
                [`zombiea`] = defaultSearchKeysAnim
            }
        },
        lockpick = {
            default = defaultLockpickAnim,
            class = {
                [VehicleClass.COMPACTS]        = defaultLockpickAnim,
                [VehicleClass.SEDANS]          = defaultLockpickAnim,
                [VehicleClass.SUVS]            = defaultLockpickAnim,
                [VehicleClass.COUPES]          = defaultLockpickAnim,
                [VehicleClass.MUSCLE]          = defaultLockpickAnim,
                [VehicleClass.SPORTS_CLASSICS] = defaultLockpickAnim,
                [VehicleClass.SPORTS]          = defaultLockpickAnim,
                [VehicleClass.SUPER]           = defaultLockpickAnim,
                [VehicleClass.MOTORCYCLES]     = defaultLockpickAnim,
                [VehicleClass.OFF_ROAD]        = defaultLockpickAnim,
                [VehicleClass.INDUSTRIAL]      = defaultLockpickAnim,
                [VehicleClass.UTILITY]         = defaultLockpickAnim,
                [VehicleClass.VANS]            = defaultLockpickAnim,
                [VehicleClass.BOATS]           = defaultLockpickAnim,
                [VehicleClass.HELICOPTERS]     = defaultLockpickAnim,
                [VehicleClass.PLANES]          = defaultLockpickAnim,
                [VehicleClass.SERVICE]         = defaultLockpickAnim,
                [VehicleClass.EMERGENCY]       = defaultLockpickAnim,
                [VehicleClass.MILITARY]        = defaultLockpickAnim,
                [VehicleClass.COMMERCIAL]      = defaultLockpickAnim,
                [VehicleClass.TRAINS]          = defaultLockpickAnim,
                [VehicleClass.OPEN_WHEEL]      = defaultLockpickAnim,
            },
            model = {
                [`zombiea`] = defaultLockpickAnim
            }
        },
        holdup = {
            default = defaultHoldupAnim,
            class = {
                [VehicleClass.COMPACTS]        = defaultHoldupAnim,
                [VehicleClass.SEDANS]          = defaultHoldupAnim,
                [VehicleClass.SUVS]            = defaultHoldupAnim,
                [VehicleClass.COUPES]          = defaultHoldupAnim,
                [VehicleClass.MUSCLE]          = defaultHoldupAnim,
                [VehicleClass.SPORTS_CLASSICS] = defaultHoldupAnim,
                [VehicleClass.SPORTS]          = defaultHoldupAnim,
                [VehicleClass.SUPER]           = defaultHoldupAnim,
                [VehicleClass.MOTORCYCLES]     = defaultHoldupAnim,
                [VehicleClass.OFF_ROAD]        = defaultHoldupAnim,
                [VehicleClass.INDUSTRIAL]      = defaultHoldupAnim,
                [VehicleClass.UTILITY]         = defaultHoldupAnim,
                [VehicleClass.VANS]            = defaultHoldupAnim,
                [VehicleClass.BOATS]           = defaultHoldupAnim,
                [VehicleClass.HELICOPTERS]     = defaultHoldupAnim,
                [VehicleClass.PLANES]          = defaultHoldupAnim,
                [VehicleClass.SERVICE]         = defaultHoldupAnim,
                [VehicleClass.EMERGENCY]       = defaultHoldupAnim,
                [VehicleClass.MILITARY]        = defaultHoldupAnim,
                [VehicleClass.COMMERCIAL]      = defaultHoldupAnim,
                [VehicleClass.TRAINS]          = defaultHoldupAnim,
                [VehicleClass.OPEN_WHEEL]      = defaultHoldupAnim,
            },
            model = {
                [`zombiea`] = defaultHoldupAnim
            }
        },
        toggleEngine = {
            default = {
                dict = 'oddjobs@towing',
                clip = 'start_engine',
                delay = 400, -- how long it takes to start the engine
            },
            class = {
                [VehicleClass.MOTORCYCLES] = {
                    dict = 'veh@bike@quad@front@base',
                    clip = 'start_engine',
                    delay = 1000,
                },
                [VehicleClass.CYCLES] = {}, -- does not have an engine
            },
            model = {},
        },
    }
}
