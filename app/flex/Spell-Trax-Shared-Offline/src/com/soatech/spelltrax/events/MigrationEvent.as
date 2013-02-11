package com.soatech.spelltrax.events
{
	import com.probertson.data.SQLRunner;
	import com.soatech.spelltrax.db.Migration;
	
	import flash.events.Event;
	
	public class MigrationEvent extends Event
	{
		//---------------------------------------------------------------------
		//
		// Events
		//
		//---------------------------------------------------------------------
		
		public static const MIGRATIONS_UPDATED:String = "MIGRATION_MIGRATIONS_UPDATED";
		public static const BUILD:String = "MIGRATION_GENERATE";
		public static const MIGRATE_UP:String = "MIGRATION_MIGRATE_UP";
		public static const MIGRATION_COMPLETE:String = "MIGRATION_COMPLETE";
		
		//-----------------------------
		// dbType
		//-----------------------------
		
		public var dbType:String;
		
		//-----------------------------
		// db
		//-----------------------------
		
		public var db:SQLRunner;
		
		//-----------------------------
		// migrations
		//-----------------------------
		
		public var migrations:Vector.<Migration>;
		
		//-----------------------------
		// targetVersion
		//-----------------------------
		
		public var targetVersion:int;
		
		//---------------------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function MigrationEvent(type:String, migrations:Vector.<Migration>=null, 
									   targetVersion:int = 0, dbType:String = null,
									   db:SQLRunner=null,
									   bubbles:Boolean=true, cancelable:Boolean=true)
		{
			this.migrations = migrations;
			this.targetVersion = targetVersion;
			this.dbType = dbType;
			this.db = db;
			
			super(type, bubbles, cancelable);
		}
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new MigrationEvent(this.type, this.migrations, this.targetVersion, this.dbType, this.db, this.bubbles, this.cancelable);
		}
	}
}