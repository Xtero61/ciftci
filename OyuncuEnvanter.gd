extends Node

const ENVANTER_SLOT = 17

var envanter = {
	0: ["Taş Kazma", 1]
}

func esya_ekleme(esya_isim, esya_miktar):
	for esya in envanter :
		if envanter[esya][0] == esya_isim:
			envanter[esya][1] += esya_miktar
			return

	for i in range(ENVANTER_SLOT):
		if envanter.has(i) == false :
			envanter[i] = [esya_isim, esya_miktar]
			return
