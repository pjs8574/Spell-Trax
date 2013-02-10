package com.soatech.spelltrax.models.vo
{
	import mx.utils.ObjectUtil;

	public class Spell
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var description:String;
		public var isDomain:Boolean;
		public var level:uint;
		public var name:String;
		public var notes:String;
		public var pid:uint;
		public var used:Boolean;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param pid
		 * @param name
		 * @param level
		 * @param isDomain
		 * @param description
		 * @param notes
		 * 
		 */		
		public function Spell(pid:uint=0, name:String=null, level:uint=0, 
							  isDomain:Boolean=false, description:String=null, 
							  notes:String=null, used:Boolean=false)
		{
			this.pid = pid;
			this.name = name;
			this.level = level;
			this.isDomain = isDomain;
			this.description = description;
			this.notes = notes;
			this.used = used;
		}
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param item
		 * @return 
		 * 
		 */		
		public static function createFromObject(item:Object):Spell
		{
			var spell:Spell = new Spell();
			spell.loadFromObject(item);
			
			return spell;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function clone():Spell
		{
			return Spell(ObjectUtil.copy(this));
		}
		
		/**
		 * 
		 * @param item
		 * 
		 */		
		public function loadFromObject(item:Object):void
		{
			if( item.hasOwnProperty('pid') )
				this.pid = uint(item['pid']);
			
			if( item.hasOwnProperty('name') )
				this.name = item['name'];
			
			if( item.hasOwnProperty('level') )
				this.level = uint(item['level']);
			
			if( item.hasOwnProperty('isDomain') )
				this.isDomain = (item['isDomain'] === 'true') ? true : false;
			
			if( item.hasOwnProperty('description') )
				this.description = item['description'];
			
			if( item.hasOwnProperty('notes') )
				this.notes = item['notes'];
			
			if( item.hasOwnProperty('used') )
				this.used = (item['used'] === 'true') ? true : false;
		}
	}
}