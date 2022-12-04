extends Node2D

onready var ismim = $"." 

func Islev_Oynat(Fare_yer):

	if ismim.name == "Duvar":
		Genel._YapiYapma("Koy",Genel.yapi_duvar,Fare_yer)

	elif ismim.name == "CamliDuvar":
		Genel._YapiYapma("Koy",Genel.yapi_duvar_camli,Fare_yer)
