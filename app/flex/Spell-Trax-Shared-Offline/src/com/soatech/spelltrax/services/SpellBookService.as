package com.soatech.spelltrax.services
{
	import com.probertson.data.QueuedStatement;
	import com.soatech.spelltrax.models.DataBaseProxy;
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.services.interfaces.ISpellBookService;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.states.State;
	
	public class SpellBookService implements ISpellBookService
	{
		//---------------------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------------------
		
		[Inject]
		public var dbProxy:DataBaseProxy;
		
		//---------------------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------------------
		
		protected var _responder:IResponder;
		
		protected var _book:SpellBook;
		
		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------
		
		protected const SQL_SELECT_ALL:String = "SELECT pid, name FROM spellBooks";
		
		protected const SQL_INSERT:String = "INSERT INTO spellBooks (name) VALUES (:name)";
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param book
		 * @param responder
		 * 
		 */		
		public function create(book:SpellBook, responder:IResponder):void
		{
			this._book = book;
			
			var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			sb.push(new QueuedStatement(SQL_INSERT, {name: book.name}));
			dbProxy.applicationDb.executeModify(sb, this.create_resultHandler, this.create_errorHandler);
		}
		
		/**
		 * 
		 * @param responder
		 * 
		 */		
		public function load(responder:IResponder):void
		{
			this._responder = responder;
			
			dbProxy.applicationDb.execute(SQL_SELECT_ALL, {}, this.load_resultHandler, 
				null, this.load_errorHandler);
		}
		
		//---------------------------------------------------------------------
		//
		// Result Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param error
		 * 
		 */		
		protected function create_errorHandler(error:SQLError):void
		{
			CONFIG::debugtrace{ trace("SpellBookService::create_errorHandler: " + error.toString()); }
		}
		
		/**
		 * 
		 * @param results
		 * 
		 */		
		protected function create_resultHandler(results:Vector.<SQLResult>):void
		{
			this._book.pid = results[0].lastInsertRowID;
			
			this._responder.result(this._book);
		}
		
		/**
		 * 
		 * @param error
		 * 
		 */		
		protected function load_errorHandler(error:SQLError):void
		{
			CONFIG::debugtrace{ trace("SpellBookService::load_errorHandler: " + error.toString()); }
		}
		
		/**
		 * 
		 * @param result
		 * 
		 */		
		protected function load_resultHandler(result:SQLResult):void
		{
			var list:ArrayCollection = new ArrayCollection();
			var item:Object;
			
			for each( item in result.data ) 
			{
				list.addItem(SpellBook.createFromObject(item));
			}
			
			this._responder.result(list);
		}
	}
}