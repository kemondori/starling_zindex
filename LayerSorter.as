package
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.errors.AbstractClassError;
	import flash.utils.Dictionary;

	public class LayerSorter
	{
		
		private static var data:Dictionary;
		
		private static var current_sprite:DisplayObjectContainer;
		
		
		public function LayerSorter()
		{
			throw new AbstractClassError("");
		}
		
		public static function add_obj(sprite:DisplayObjectContainer,obj:DisplayObject,new_layer:int):DisplayObject
		{
			if(data == null)
				data = new Dictionary(true);
			if(data[sprite] == null)
				data[sprite] = new Dictionary(true);
			
			current_sprite = sprite;
			
			if(data[sprite][obj] != null)
			{
				data[sprite][obj].cont++;
			}
			else
			{
				data[sprite][obj] = new Dictionary(true);
				data[sprite][obj].ori_layers = new_layer;
				data[sprite][obj].cont = 1;
			}
			
			sprite.addChild(obj);
			
			sprite.sortChildren(compareFunc);
			
			return obj;
		}
		
		public static function remove_obj(sprite:DisplayObjectContainer,obj:DisplayObject):void
		{
			current_sprite = sprite;
			
			if(data[sprite][obj] != null)
			{
				if(data[sprite][obj].cont <= 0)
					data[sprite][obj] = null;
				else
					data[sprite][obj].cont--;
			}
			else
				throw new Error("remove_obj - LayerSorter not used for all objects");
			sprite.removeChild(obj);
			sprite.sortChildren(compareFunc);
		}
		
		public static function remove_all(sprite:DisplayObjectContainer):void
		{
			current_sprite = sprite;
			sprite.removeChildren(0);
			data[sprite] = new Dictionary(true);
		}
		
		private static function compareFunc(a:DisplayObject,b:DisplayObject):int
		{
			if(data[current_sprite][a] == null || data[current_sprite][b] == null)
				throw new Error("compareFunc -  LayerSorter not used for all objects");
			if(data[current_sprite][a].ori_layers > data[current_sprite][b].ori_layers)
				return 1;
			else if(data[current_sprite][a].ori_layers < data[current_sprite][b].ori_layers)
				return -1;
			return 0;
		}
		
	}
}