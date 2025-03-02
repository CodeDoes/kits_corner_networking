# client.gd
extends HBoxContainer
func _enter_tree() -> void:
	set_multiplayer_authority(int(str(name)))
	if is_multiplayer_authority():
		print("RRR")
		set_username.rpc("Client "+str(name))
	else:
		$LineEdit.hide()
func _ready():
	$LineEdit.text_changed.connect(func(v):
		set_username.rpc(v)
	)
@rpc("call_local")
func set_username(new_username:String):
	$Label.text = new_username
	$LineEdit.text = new_username
	
	
