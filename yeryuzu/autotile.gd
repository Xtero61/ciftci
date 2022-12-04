tool
extends TileSet

#hepsinii birleştirir
func _is_tile_bound(_id, neighbour_id):
	return neighbour_id in get_tiles_ids()

#birleştirmek istediğini secebilirsin
#const BRIDGE = 4
#const BRICKS = 5
#
#var binds = {
#	BRIDGE: [BRICKS],
#	BRICKS: [BRIDGE],
#}
#
#func _is_tile_bound(id, neighbour_id):
#	if id in binds:
#		return neighbour_id in binds[id]
#	return false
