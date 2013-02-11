package com.soatech.spelltrax.models
{
	import com.probertson.data.SQLRunner;
	import com.soatech.spelltrax.db.Migration;
	
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DataBaseProxy extends Actor
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		public const APPLICATION_KEY_ELS_ID:String = "SpellTrax-ApplicationDb";
		
		//-----------------------------
		// applicationDb
		//-----------------------------
		
		public var applicationDb:SQLRunner;
		
		//-----------------------------
		// applicationKey
		//-----------------------------
		
		public var applicationKey:ByteArray;

		//-----------------------------
		// applicationMigrations
		//-----------------------------
		
		public var applicationMigrations:Vector.<Migration>;
		
		
	}
}