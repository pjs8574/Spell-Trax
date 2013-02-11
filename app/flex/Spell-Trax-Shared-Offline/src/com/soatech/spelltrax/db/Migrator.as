package com.soatech.spelltrax.db
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	import com.soatech.spelltrax.events.MigrationEvent;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.mvcs.Actor;

	[Event(name="MIGRATION_COMPLETE", type="com.soatech.spelltrax.events.MigrationEvent")]
	public class Migrator extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public static const NO_DATABASE_EXISTS_DO_COMPLETE_MIGRATION:int = 0;
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set migrations(value:Vector.<Migration>):void
		{
			_migrations = value;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set db(value:SQLRunner):void
		{
			_dbi = value;
		}
		
		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------
		
		private const SQL_SELECT_VERSION:String = "SELECT currentVersion FROM schemaVersion";
		private const SQL_UPDATE_VERSION:String = "UPDATE schemaVersion SET currentVersion = :currentVersion";
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		protected var _dbi:SQLRunner;
		
		/**
		 * @private 
		 */		
		protected var _migrations:Vector.<Migration>;
		
		/**
		 * @private 
		 */		
		protected var _currentVersion:int;
		
		/**
		 * @private 
		 */		
		private var _requestedVersion:int;
		
		//----------------------------------------------------------------------
		// 
		// Constructor
		//
		//----------------------------------------------------------------------
		
		public function Migrator()
		{
		}
		
		//----------------------------------------------------------------------
		// 
		// Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Checks against the DB to find what version the schema is at
		 * @private
		 */		
		protected function determineVersion():void
		{
			var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			sb.push(new QueuedStatement(SQL_SELECT_VERSION));
			_dbi.executeModify(sb, onSelectVersionResult, onSelectVersionFault);
		}
		
		/**
		 * Runs through the migrations up to the requested version number
		 * If left blank, it will run all migrations 
		 * @param version
		 * 
		 */		
		public function migrateTo(version:int = 0):void
		{
			_requestedVersion = version;
			
			determineVersion();
		}
		
		protected function runMigrations():void
		{
			var migration:Migration;
			var sql:String;
			var statementBatch:Vector.<QueuedStatement>;
			
			// find the upper limit of migrations
			if( _requestedVersion == NO_DATABASE_EXISTS_DO_COMPLETE_MIGRATION )
			{
				_requestedVersion = _migrations[_migrations.length-1].version;
			}
			
			statementBatch = new Vector.<QueuedStatement>();
			for( var i:int = 0; i < _migrations.length; ++i )
			{
				migration = _migrations[i];
				
				if(migration.version > _currentVersion && migration.version <= _requestedVersion )
				{
					for each( sql in migration.queries )
					{
						statementBatch.push(new QueuedStatement(sql));
					}

					statementBatch.push(new QueuedStatement(SQL_UPDATE_VERSION, {currentVersion: migration.version}));
				}
			}

            if( statementBatch.length )
			    _dbi.executeModify(statementBatch, onMigrationComplete, onMigrationFault);
            else
                onMigrationComplete(null);
		}
		
		//----------------------------------------------------------------------
		// 
		// Result Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function onMigrationComplete(results:Vector.<SQLResult>):void
		{
			dispatch(new MigrationEvent( MigrationEvent.MIGRATION_COMPLETE ));
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		public function onSelectVersionResult(results:Vector.<SQLResult>):void
		{
			if( !results[0].data || !results[0].data.length )
				_currentVersion = 0;
			else
				_currentVersion = int(results[0].data[0]['currentVersion']);
			
			runMigrations();
		}
		
		//----------------------------------------------------------------------
		// 
		// Fault Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
		 * @param info
		 * 
		 */
		private function onMigrationFault(error:SQLError):void
		{
			trace("Migrator::onMigrationFault " + error.toString());
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public function onSelectVersionFault(error:SQLError):void
		{
			_currentVersion = 0;
			runMigrations();
		}
	}
}