@tool
extends EditorPlugin

var copied_transform:Transform3D = Transform3D.IDENTITY

#Remember to add this script to Autoload or to an object
func _ready():
	add_tool_menu_item("Copy Transform", _copy_transform)
	add_tool_menu_item("Paste Transform", _paste_transform)

func _copy_transform():
	var nodes = get_editor_interface().get_selection().get_selected_nodes()
	if nodes.size() == 0: _show_message("Select a Node3D and try again.")
	elif nodes.size() > 1: _show_message("Too many nodes selected, only select one to copy.")
	else:
		var node = nodes[0]
		if !node is Node3D: _show_message("Selection must be a Node3D.")
		else:
			var sp = node as Node3D
			copied_transform = sp.transform
			print("Copied transform: ", copied_transform)

func _paste_transform():
	var nodes = get_editor_interface().get_selection().get_selected_nodes()
	if nodes.size() == 0: _show_message("Select a Node3D and try again.")
	else:
		for node in nodes:
			if node is Node3D:
				var sp = node as Node3D
				sp.transform = copied_transform
				print("Pasted transform: ", copied_transform)

func _show_message(message):
	var dialog = AcceptDialog.new()
	dialog.dialog_text = message
	add_child(dialog)
	dialog.popup_centered()
