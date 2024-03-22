extends Node

class_name TitanVisualManager;

@export var sprite: TitanAnimator;
@export var left_hand_sprite: Sprite2D;
@export var right_hand_sprite: Sprite2D;
@export var left_shoulder_sprite: Sprite2D;
@export var right_shoulder_sprite: Sprite2D;

@export var shoulder_texture: Texture2D;
@export var current_visual_asset: TitanVisual;

func _ready() -> void:
	apply_visuals();

func apply_visuals() -> void:
	sprite.material.set_shader_parameter("primary_color", current_visual_asset.primary_color);
	sprite.material.set_shader_parameter("secondary_color", current_visual_asset.secondary_color);
	sprite.material.set_shader_parameter("tertiary_color", current_visual_asset.tertiary_color);
	sprite.material.set_shader_parameter("visor_color", current_visual_asset.visor_color);

	left_hand_sprite.material.set_shader_parameter("primary_color", current_visual_asset.primary_color);
	left_hand_sprite.material.set_shader_parameter("secondary_color", current_visual_asset.secondary_color);
	left_hand_sprite.material.set_shader_parameter("tertiary_color", current_visual_asset.tertiary_color);
	left_hand_sprite.material.set_shader_parameter("visor_color", current_visual_asset.visor_color);

	right_hand_sprite.material.set_shader_parameter("primary_color", current_visual_asset.primary_color);
	right_hand_sprite.material.set_shader_parameter("secondary_color", current_visual_asset.secondary_color);
	right_hand_sprite.material.set_shader_parameter("tertiary_color", current_visual_asset.tertiary_color);
	right_hand_sprite.material.set_shader_parameter("visor_color", current_visual_asset.visor_color);
	
	left_shoulder_sprite.material.set_shader_parameter("primary_color", current_visual_asset.primary_color);
	left_shoulder_sprite.material.set_shader_parameter("secondary_color", current_visual_asset.secondary_color);
	left_shoulder_sprite.material.set_shader_parameter("tertiary_color", current_visual_asset.tertiary_color);
	left_shoulder_sprite.material.set_shader_parameter("visor_color", current_visual_asset.visor_color);
	left_shoulder_sprite.texture = shoulder_texture;
	
	right_shoulder_sprite.material.set_shader_parameter("primary_color", current_visual_asset.primary_color);
	right_shoulder_sprite.material.set_shader_parameter("secondary_color", current_visual_asset.secondary_color);
	right_shoulder_sprite.material.set_shader_parameter("tertiary_color", current_visual_asset.tertiary_color);
	right_shoulder_sprite.material.set_shader_parameter("visor_color", current_visual_asset.visor_color);
	right_shoulder_sprite.texture = shoulder_texture;
