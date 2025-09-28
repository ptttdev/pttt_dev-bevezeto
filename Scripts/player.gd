extends CharacterBody2D #ez a script a CharacterBody2D-vel működhet


var speed = 150   #gyorsaság
var jump = -350   #ugrási erő
var gravity = 980 #gravitációs erő
var LowerY = 100  #alsó határ, hogy ne zuhanjon ki a játékos a világból

func _physics_process(delta): #minden pillanatban lejátszódik


	#Ugrás
	if Input.is_action_just_pressed("jump") and is_on_floor():
	# ha          ugrásgomb lenyomva               és a földön van
		velocity.y = jump # fel vagy le (y) erő hasson rá

	# mozgás
	var direction = Input.get_axis("left", "right") # balra vagy jobbra megy (-1, 0, 1) avagy irány
	velocity.x = direction * speed # menjen SPEED gyorsasággal abba az irányba
	
	if direction != 0: #ha mozog avagy mozgás iránya nem 0
		$Sprite.flip_h = direction < 0 # 'forgatás'
		$Sprite.play("walk") # séta animáció
	else:
		$Sprite.play("idle") # álló animáció
	
	#Gravitáció
	if not is_on_floor(): #ha nem a földön van
		velocity.y += gravity * delta #hasson rá laggmentesen gravitáció
		$Sprite.play("fall") # esés ha nem érintkezik a földdel
	
	#lezuhanás
	if position.y > LowerY: #ha y position kissebb mint a lowerY
		get_tree().reload_current_scene() # indíts újra a jelentete
		
	move_and_slide() # megengedi, hogy mozogjon a karakter
