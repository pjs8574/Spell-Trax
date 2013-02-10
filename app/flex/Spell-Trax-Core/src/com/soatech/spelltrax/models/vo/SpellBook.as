package com.soatech.spelltrax.models.vo
{
	import mx.utils.ObjectUtil;

	public class SpellBook
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public var name:String;
		public var pid:uint;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param pid
		 * @param name
		 * 
		 */		
		public function SpellBook(pid:uint=0, name:String=null)
		{
			this.pid = pid;
			this.name = name;
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
		public static function createFromObject(item:Object):SpellBook
		{
			var book:SpellBook = new SpellBook();
			book.loadFromObject(item);
			
			return book;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function clone():SpellBook
		{
			return SpellBook(ObjectUtil.copy(this));
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
		}
	}
}