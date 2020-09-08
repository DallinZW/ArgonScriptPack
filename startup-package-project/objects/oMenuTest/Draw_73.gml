var hinp = input_value(0, input_values.horizontal)
var vinp = input_value(0, input_values.vertical)
var conf = input_pressed(0, input_action.confirm)

menu_render_stacked(10, 0, hinp, vinp, conf, 10, 5)
x+=200
menu_render_stacked_center(10, 0, hinp, vinp, conf, 10, -1)
x-=200