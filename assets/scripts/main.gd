"""
scripts/main.gd

Sets up the main survival game mode. Protect the crown! 
"""

const GUY_ENTITY: StringName = "base:GUY"
const CROWN_ENTITY: StringName = "base:CROWN"
const PLAYER_TEAM: StringName = "base:player"
const KING_GLOBAL_STATE: StringName = "global:king"
const WARP_TO_KING_INPUT: StringName = "base:warp_to_king"
const WALK_TARGET_STATE: StringName = "walk_target"
const WALK_COMMAND_PLAN: StringName = "base:walk_command"
const WALK_PRIORITY_CONSTANT: StringName = "walk_priority"
const FORCE_WALK_PRIORITY_CONSTANT: StringName = "force_walk_priority"

"""
Called when the world is created.
Spawn group of Lil Guys and their King. Setup the camera.
"""
static func init_world(api):
	var util = api.util
	var world = api.world

	var count: int = api.config.get_constant("start_guy_count")
	var center: Vector2i = api.util.get_map_size_in_pixels() / 2

	for i in range(count):
		world.spawn(GUY_ENTITY, center + util.get_random_vector2i(64), PLAYER_TEAM)
	
	var king = world.spawn(GUY_ENTITY, center, PLAYER_TEAM)
	king.equip("head", CROWN_ENTITY)

	api.camera.set_offset(center)

"""
Called once when a world is created or loaded.
"""
static func play_game(api):
	_connect_events(api)

"""
Game over!
"""
static func end_game(api):
	_pan_to_king(api)

"""
Handle custom inputs events.
"""
static func input(api, event: InputEvent):
	if event.is_action_pressed(WARP_TO_KING_INPUT):
		_pan_to_king(api)
		api.get_viewport().set_input_as_handled()

static func _pan_to_king(api):
	var king = api.global_state.get(KING_GLOBAL_STATE)
	api.camera.set_target(king.get_position())

"""
Listen to game events to update the current King. 
"""

static func _on_flee(api, character, from):
	if (
		character == api.global_state.get(KING_GLOBAL_STATE) and
		from.get_team() != api.config.get_client_team()
	):
		api.ui.marker.alert(character)

static func _on_equip(api, character, item_type):
	if item_type == CROWN_ENTITY:
		_replace_king(api, character)
		character.quit_job()

static func _on_spawn(api, entity):
	if entity.get_type() == CROWN_ENTITY:
		_replace_king(api, entity)

static func _replace_king(api, king):
	var old_king = api.global_state.get(KING_GLOBAL_STATE)
	api.ui.marker.remove(old_king)
	api.ui.marker.add(king)
	api.global_state.set(KING_GLOBAL_STATE, king)

static func _on_marker_entity_visible(api, entity, is_visible):
	if entity == api.global_state.get(KING_GLOBAL_STATE):
		api.ui.show_hint(WARP_TO_KING_INPUT, not is_visible)

static func _connect_events(api):
	var events = api.events
	events.flee.connect(_on_flee)
	events.equip.connect(_on_equip)
	events.spawn.connect(_on_spawn)
	events.marker_entity_visible.connect(_on_marker_entity_visible)
	events.command_to_position.connect(_on_command_to_position)

static func _on_command_to_position(api, entities, position, is_forced):
	var priority: int
	if is_forced:
		priority = api.config.get_constant(FORCE_WALK_PRIORITY_CONSTANT)
	else:
		priority = api.config.get_constant(WALK_PRIORITY_CONSTANT)

	for entity in entities:
		if is_forced:
			entity.quit_job()
		else:
			entity.quit_task()
		
		entity.set_state(WALK_TARGET_STATE, position)
		entity.assign_job(WALK_COMMAND_PLAN, priority)
