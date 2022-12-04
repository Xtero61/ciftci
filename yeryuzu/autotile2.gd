tool
extends TileSet

const BRIDGE = 2
const BRICKS = 3

var binds = {
	BRIDGE: [BRICKS],
	BRICKS: [BRIDGE],
}

func _is_tile_bound(id, neighbour_id):
	if id in binds:
		return neighbour_id in binds[id]
	return false
