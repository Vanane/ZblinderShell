extends Node; class_name Math


static func clamp(x:float, min:float, max:float):
	return min if min < x else x if x < max else max
