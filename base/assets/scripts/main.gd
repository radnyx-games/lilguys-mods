"""
scripts/main.gd

Sets up the main survival game mode. Protect the crown! 
"""

const GUY_ENTITY: StringName = "base:GUY"
const CROWN_ENTITY: StringName = "base:CROWN"
const SWORD_ENTITY: StringName = "base:SWORD"
const SHIELD_ENTITY: StringName = "base:SHIELD"
const SATCHEL_ENTITY: StringName = "base:SATCHEL"

const TUB_ENTITY: StringName = "base:TUB"

const DAMAGED_TAG: StringName = "base:DAMAGED"
const BASIC_CLASS_TAG: StringName = "base:BASIC_CLASS"
const FIGHTER_CLASS_TAG: StringName = "base:FIGHTER_CLASS"
const HAULER_CLASS_TAG: StringName = "base:HAULER_CLASS"

const PLAYER_TEAM: StringName = "base:player"

const WARP_TO_KING_INPUT: StringName = "base:warp_to_king"

const KING_GLOBAL_STATE: StringName = "global:king"
const ATTACK_PLAN_STATE: StringName = "attack_plan"
const WALK_TARGET_STATE: StringName = "walk_target"
const IS_PASSIVE_STATE: StringName = "is_passive"
const DEFAULT_ATTACK_STATE: StringName = "job:default_attack"

const WALK_COMMAND_PLAN: StringName = "base:walk_command"
const GUY_ATTACK_PLAN: StringName = "base:guy_attack"
const SWORD_ATTACK_PLAN: StringName = "base:sword_attack"

const WALK_PRIORITY_CONSTANT: StringName = "base:walk_priority"
const FORCE_WALK_PRIORITY_CONSTANT: StringName = "base:force_walk_priority"

const SWORD_ATTACK: StringName = "SwordAttack"

const GUARD_JOB_TYPE: int = 3

"""
Called when the world is created.
Spawn group of Lil Guys and their King. Setup the camera.
"""
static func init_world(api):
    var util = api.util
    var world = api.world

    var count: int = api.config.get_constant("base:start_guy_count")
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
    _connect_events(api.events)

    api.repos.tag.register(DAMAGED_TAG)

    api.repos.tag.register(BASIC_CLASS_TAG)
    api.repos.tag.register(FIGHTER_CLASS_TAG)
    api.repos.tag.register(HAULER_CLASS_TAG)

"""
Listen to game events to update the current King. 
"""
static func _connect_events(events):
    events.on_end_game(_pan_to_king)
    events.on_input(_on_input)
    events.on_flee(_on_flee)
    events.on_marker_entity_visible(_on_marker_entity_visible)
    events.on_command_to_position(_on_command_to_position)
    events.on_command_to_building(_on_command_to_building)

    # Called when an entity is spawned into the world for the first time.
    events.on_spawn(GUY_ENTITY, func(_api, guy):
        guy.add_tag(BASIC_CLASS_TAG)
        guy.add_tag(HAULER_CLASS_TAG)
        guy.set_state(ATTACK_PLAN_STATE, GUY_ATTACK_PLAN)
        guy.set_state(IS_PASSIVE_STATE, true))

    # Called when an entity is loaded, either after spawning or from a save file.
    events.on_init(CROWN_ENTITY, _set_king)

    # An entity whose primary tag is `tag` is moved from the container of `from` to `to`.
    events.on_transfer(func(api, from, to, tag):
        # E.g., if a king puts themself into a Tub/Cannon/Compactor, that building is now the king.
        if from == api.global_state.get(KING_GLOBAL_STATE) and tag == GUY_ENTITY:
            _set_king(api, to))

    # Called when we update the king entity in the global state.
    events.on_global_state_changed(KING_GLOBAL_STATE, func(api, king):
        var old_king = api.global_state.get(KING_GLOBAL_STATE)
        api.ui.marker.remove(old_king)
        api.ui.marker.add(king))

    events.on_dibs(func(_api, worker, job):
        var is_fighter = worker.has_tag(FIGHTER_CLASS_TAG)
        var is_guarding = job != null and job.get_job_type() == GUARD_JOB_TYPE
        worker.set_state(IS_PASSIVE_STATE, not (is_fighter or is_guarding)))

    _connect_equipment(events)
 
# Called when a character equips the given item type.
static func _connect_equipment(events):
    events.on_equip(CROWN_ENTITY, func(api, character):
        character.remove_tag(BASIC_CLASS_TAG)
        character.remove_tag(HAULER_CLASS_TAG)
        character.quit_job()
        _set_king(api, character))

    events.on_equip(SWORD_ENTITY, func(_api, character):
        character.remove_tag(BASIC_CLASS_TAG)
        character.remove_tag(HAULER_CLASS_TAG)
        character.add_tag(FIGHTER_CLASS_TAG)
        character.set_state(ATTACK_PLAN_STATE, SWORD_ATTACK_PLAN)
        character.set_state(DEFAULT_ATTACK_STATE, SWORD_ATTACK)
        character.set_state(IS_PASSIVE_STATE, false))

    events.on_equip(SHIELD_ENTITY, func(_api, character):
        character.buff_max_health(50))

    events.on_equip(SATCHEL_ENTITY, func(_api, character):
        # TODO: If a Bow tool is equipped, they should be a fighter.
        # Unless it's a Lyre Bow, in which case they should be a healer.
        character.remove_tag(BASIC_CLASS_TAG)
        # TODO: organize component APIs like `character.container` and `character.health`.
        character.set_container_max_limit(5))

static func _set_king(api, king):
    api.world.set_destruction_center(PLAYER_TEAM, king)
    api.global_state.set(KING_GLOBAL_STATE, king)

static func _pan_to_king(api):
    var king = api.global_state.get(KING_GLOBAL_STATE)
    api.camera.set_target(king.get_position())
    if king.get_type() == GUY_ENTITY:
        api.input.select(king)

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

static func _on_command_to_building(_api, entities: Array, building, _is_forced: bool):
    if building.get_type() == TUB_ENTITY:
        for entity in entities:
            # The "base:DAMAGED" tag is added when their health drops below 35%.
            # But if you player manually assigns them to heal, add the tag anyway.
            # That way, if the Tub is currently full, they will later heal themselves.
            if not entity.has_full_health():
                entity.add_tag(DAMAGED_TAG)

# Custom cheat menu commands. These will be removed.
static func __spawn_knight_guy(api, position: Vector2i):
    var world = api.world
    var guy = world.spawn(GUY_ENTITY, position, PLAYER_TEAM)
    guy.equip("tool", SWORD_ENTITY)
    guy.equip("accessory", SHIELD_ENTITY)

static func __spawn_hauler_guy(api, position: Vector2i):
    var world = api.world
    var guy = world.spawn(GUY_ENTITY, position, PLAYER_TEAM)
    guy.equip("accessory", SATCHEL_ENTITY)
