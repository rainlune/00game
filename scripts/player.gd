extends CharacterBody2D  # 角色节点继承自CharacterBody2D


const SPEED = 130.0  # 角色水平移动速度（单位：像素/秒
const JUMP_VELOCITY = -300.0  # 跳跃的垂直初速度

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. 重力处理：角色不在地面时，叠加重力到速度上
	if not is_on_floor():
		velocity += get_gravity() * delta   # is_on_floor()：判断角色是否站在碰撞体（地面）上
		# get_gravity()：获取当前场景/项目设置的重力值（默认向下，Y轴正方向）
		# 乘以delta：保证重力效果与帧率无关

	# 2. 跳跃处理：按下"确认键"（默认空格/回车）且在地面时触发跳跃
	# Input.is_action_just_pressed("ui_accept")：检测"ui_accept"动作是否刚被按下（只触发一次）
	# 加is_on_floor()限制：防止二段跳
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY   # 设置垂直速度为跳跃初速度，角色向上跳

	 # 3. 水平移动处理
	# Input.get_axis("ui_left", "ui_right")：获取左右输入轴的值（按左=-1，按右=1，都不按=0）
	var direction := Input.get_axis("move_left", "move_right")
	#翻转立绘
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	#播放动画
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
