package com.soatech.spelltrax.commands
{
	import com.soatech.spelltrax.db.Migration;
	import com.soatech.spelltrax.db.Migrator;
	import com.soatech.spelltrax.events.MigrationEvent;
	import com.soatech.spelltrax.models.DataBaseProxy;
	
	import org.robotlegs.mvcs.Command;
	
	public class MigrationsBuildCommand extends Command
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var event:MigrationEvent;
		
		[Inject]
		public var dbProxy:DataBaseProxy;

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
			var list:Vector.<Migration> = new Vector.<Migration>();
			var migration:Migration;
			var version:int = 0;
			var migrator:Migrator;
			
			// 1
			
			migration = new Migration();
			migration.version = ++version;
			migration.queries = new Vector.<String>();
			migration.queries.push("CREATE TABLE schemaVersion (currentVersion integer)");
			migration.queries.push("INSERT INTO schemaVersion (currentVersion) VALUES (1)");
			
			list.push(migration);
			
			// 2
			
			migration = new Migration();
			migration.version = ++version;
			migration.queries = new Vector.<String>();
			
			// spellBooks
			migration.queries.push("CREATE TABLE spellBooks ( pid integer primary key autoincrement, " +
				"name text)");
			migration.queries.push("CREATE TRIGGER insert_spellBooks_timestamp " +
				"AFTER INSERT ON spellBooks BEGIN UPDATE spellBooks SET createdOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");
			migration.queries.push("CREATE TRIGGER update_spellBooks_timestamp " +
				"AFTER UPDATE ON spellBooks BEGIN UPDATE spellBooks SET updatedOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");
			
			// spells
			migration.queries.push("CREATE TABLE spells ( pid integer primary key autoincrement, " +
				"description text, isDomain integer, level integer, name text, " +
				"notes text )");
			migration.queries.push("CREATE TRIGGER insert_spells_timestamp " +
				"AFTER INSERT ON spells BEGIN UPDATE spells SET createdOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");
			migration.queries.push("CREATE TRIGGER update_spells_timestamp " +
				"AFTER UPDATE ON spells BEGIN UPDATE spells SET updatedOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");

			
			// spellBookSpells
			migration.queries.push("CREATE TABLE spellBookSpells( spellBookId integer, " +
				"spellId integer, used integer )");
			migration.queries.push("CREATE TRIGGER insert_spellBookSpells_timestamp " +
				"AFTER INSERT ON spellBookSpells BEGIN UPDATE spellBookSpells SET createdOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");
			migration.queries.push("CREATE TRIGGER update_spellBookSpells_timestamp " +
				"AFTER UPDATE ON spellBookSpells BEGIN UPDATE spellBookSpells SET updatedOn = " +
				"DATETIME('NOW') WHERE pid = new.pid; END");
			
			list.push(migration);
			
			dbProxy.applicationMigrations = list;
		}
	}
}