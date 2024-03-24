extends TileMap

class_name DestructableTileMap;

@export var destruction_particles: PackedScene = preload("res://assets/vfx/particles/destruction/wall_destroy_particles.tscn");

func destroy_tiles_at_point(point: Vector2, range: float) -> void:
	var hit_cell_location: Vector2i = local_to_map(point);
	for tile in get_used_cells(0):
		if(Vector2(hit_cell_location).distance_to(Vector2(tile)) < range):
			erase_cell(0, tile);
			
			var neighboring_cells: Array[Vector2i] = get_surrounding_cells(tile);
			
			for neighbor in neighboring_cells:
				if(get_cell_tile_data(0, neighbor) != null):
					set_cell(0, neighbor, 0, Vector2i(0,0));
			
			var particle_instance: GPUParticles2D = destruction_particles.instantiate();
			add_child(particle_instance);
			particle_instance.position = map_to_local(tile);
			particle_instance.emitting = true;
