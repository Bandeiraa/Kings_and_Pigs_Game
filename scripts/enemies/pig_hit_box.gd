extends HitBox

signal animate
signal dead

func on_area_entered(area: Object):
	health -= area.damage
	instance_popup(area.damage, "Attack")
	emit_signal("animate")
	if health <= 0:
		emit_signal("dead")
