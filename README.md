# starling zindex support
Simple class to help sorting objects by zindex.
Useful if you need to integrete some kind of visual editor project in starling.

Usage:

Add object: 
	LayerSorter.add_obj(display_object_container,display_object,zindex);
Remove object:
	LayerSorter.remove_obj(display_object_container,display_object);
Remove all from container:
	LayerSorter.remove_all(display_object_container);
	
Every child of the container must be added using this class.
You can't mix normal AddChild with LayerSorter.add_obj.