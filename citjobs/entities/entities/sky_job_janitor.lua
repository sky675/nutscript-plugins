AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Janitor Job Terminal"
ENT.Category = "HL2RP"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Base = "sky_job_base"
ENT.model = "models/props_combine/breenconsole.mdl" --classic model

ENT.name = "Janitor Job Terminal"
ENT.desc = "A machine to clock into the Janitor job. This job requires no special knowledge. In order to keep the job you must collect eligible items. Eligible items include naturally spawned items and items from dumpsters. These can then be sold at the dropoff point for pay. You will only recieve pay for things you picked up while on the job."
ENT.job = "janitor"
