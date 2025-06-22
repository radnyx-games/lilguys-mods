"""
scripts/main.gd

Sets up the main survival game mode. Protect the crown! 
"""

const GUY_ENTITY: StringName = "base:GUY"
const CROWN_ENTITY: StringName = "base:CROWN"

const PLAYER_TEAM: StringName = "base:player"

const WARP_TO_KING_INPUT: StringName = "base:warp_to_king"

const KING_GLOBAL_STATE: StringName = "global:king"
const ATTACK_PLAN_STATE: StringName = "attack_plan"
const WALK_TARGET_STATE: StringName = "walk_target"

const WALK_COMMAND_PLAN: StringName = "base:walk_command"
const GUY_ATTACK_PLAN: StringName = "base:guy_attack"

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
Listen to game events to update the current King. 
"""
static func _connect_events(api):
	var events = api.events
	events.on_end_game(_pan_to_king)
	events.on_input(_on_input)
	events.on_flee(_on_flee)
	events.on_marker_entity_visible(_on_marker_entity_visible)
	events.on_command_to_position(_on_command_to_position)

	# Called when an entity is spawned into the world for the first time.
	events.on_spawn(GUY_ENTITY, func(_api, guy):
		guy.set_state(ATTACK_PLAN_STATE, GUY_ATTACK_PLAN))

	# Called when an entity is loaded, either after spawning or from a save file.
	events.on_init(CROWN_ENTITY, func(_api, crown):
		api.global_state.set(KING_GLOBAL_STATE, crown))

	# Called when a character equips the given item type.
	events.on_equip(CROWN_ENTITY, func(_api, character):
		character.quit_job())

	# Called when we update the king entity in the global state.
	events.on_global_state_changed(KING_GLOBAL_STATE, func(_api, king):
		var old_king = _api.global_state.get(KING_GLOBAL_STATE)
		api.ui.marker.remove(old_king)
		api.ui.marker.add(king))

static func _pan_to_king(api):
	var king = api.global_state.get(KING_GLOBAL_STATE)
	api.camera.set_target(king.get_position())

static func _on_input(api, event: InputEvent):
	if event.is_action_pressed(WARP_TO_KING_INPUT):
		_pan_to_king(api)
		api.get_viewport().set_input_as_handled()

static func _on_flee(api, character, from):
	if (
		character == api.global_state.get(KING_GLOBAL_STATE) and
		from.get_team() != api.config.get_client_team()
	):
		api.ui.marker.alert(character)

static func _on_marker_entity_visible(api, entity, is_visible):
	if entity == api.global_state.get(KING_GLOBAL_STATE):
		api.ui.show_hint(WARP_TO_KING_INPUT, not is_visible)

static func _on_command_to_position(api, entities: Array, position: Vector2i, is_forced: bool):
	var constant = FORCE_WALK_PRIORITY_CONSTANT if is_forced else WALK_PRIORITY_CONSTANT
	var priority: int = api.config.get_constant(constant)

	for entity in entities:
		if is_forced: entity.quit_job()
		entity.set_state(WALK_TARGET_STATE, position)
		entity.set_plan(WALK_COMMAND_PLAN, priority)


# Custom cheat menu command. This will be removed.
static func __spawn_knight_guy(api, position: Vector2i):
	var world = api.world
	var guy = world.spawn(GUY_ENTITY, position, PLAYER_TEAM)
	guy.equip("tool", "base:SWORD")
	guy.equip("accessory", "base:SHIELD")
