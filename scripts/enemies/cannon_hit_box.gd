extends HitBox

func on_area_entered(area: Object):
	health -= area.damage
	instance_popup(area.damage, "Attack")
