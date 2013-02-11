package com.soatech.spelltrax.commands
{
	import com.probertson.data.SQLRunner;
	import com.soatech.spelltrax.db.Migrator;
	import com.soatech.spelltrax.events.DataBaseEvent;
	import com.soatech.spelltrax.events.MigrationEvent;
	import com.soatech.spelltrax.helpers.ELSHelper;
	import com.soatech.spelltrax.models.DataBaseProxy;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Command;
	
	public class DatabaseConnectCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var dbProxy:DataBaseProxy;

		[Inject]
		public var event:DataBaseEvent;
		
		[Inject]
		public var elsHelper:ELSHelper;
		
		[Inject]
		public var migrator:Migrator;
		
		//---------------------------------------------------------------------
		//
		// Overridden Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * 
		 */		
		override public function execute():void
		{
			var db:SQLRunner;
			var key:ByteArray;
			var file:File;
			
			if( elsHelper.isSupported && 0 )
			{
				CONFIG::debugtrace{ trace("ELS Supported"); }
				file = File.applicationStorageDirectory.resolvePath(dbProxy.APPLICATION_KEY_ELS_ID + ".enc.db");
				key = elsHelper.getEncryptedKey(dbProxy.APPLICATION_KEY_ELS_ID);
			
				dbProxy.applicationKey = key;
				db = new SQLRunner(file, 5, key);
			}
			else
			{
				CONFIG::debugtrace{ trace("ELS NOT Supported"); }
				file = File.applicationStorageDirectory.resolvePath(dbProxy.APPLICATION_KEY_ELS_ID + ".db");
				db = new SQLRunner(file);
			}
			
			dbProxy.applicationDb = db;
			
			migrator.eventDispatcher.addEventListener(MigrationEvent.MIGRATION_COMPLETE, onMigrationComplete);
			migrator.migrations = dbProxy.applicationMigrations;
			migrator.db = dbProxy.applicationDb;
			migrator.migrateTo();
		}
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------

		/**
		 * 
		 * @param event
		 * 
		 */
		private function onMigrationComplete(event:MigrationEvent):void
		{
			migrator.eventDispatcher.removeEventListener(MigrationEvent.MIGRATION_COMPLETE, onMigrationComplete);
			
			dispatch( new DataBaseEvent( DataBaseEvent.CONNECTED ) );
		}
	}
}