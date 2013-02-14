package com.soatech.spelltrax.services
{
	import com.probertson.data.QueuedStatement;
	import com.soatech.spelltrax.models.DataBaseProxy;
	import com.soatech.spelltrax.models.vo.Spell;
	import com.soatech.spelltrax.models.vo.SpellBook;
	import com.soatech.spelltrax.services.interfaces.ISpellService;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class SpellService implements ISpellService
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
		
		protected var _spell:Spell;
		
		//---------------------------------------------------------------------
		//
		// SQL
		//
		//---------------------------------------------------------------------
		
		protected const SQL_SELECT_ALL:String = "SELECT pid, description, isDomain, " +
			"level, name, notes FROM spells";
		
		protected const SQL_SELECT_ALL_BY_BOOK:String = "SELECT s.pid, description, " +
			"isDomain, level, name, notes, used FROM spells s " +
			"INNER JOIN spellBookSpells sbs ON s.pid = sbs.spellId " +
			"AND sbs.spellBookId = :spellBookId";
		
		protected const SQL_INSERT:String = "INSERT INTO spells (description, " +
			"isDomain, level, name, notes) VALUES (:description, :isDomain, :level, " +
			":name, :notes)";

        protected const SQL_UPDATE:String = "UPDATE spells SET (description = :description, " +
                "isDomain = :isDomain, level = :level, name = :name, notes = :notes) " +
                "WHERE pid = :pid";
		
		//---------------------------------------------------------------------
		//
		// Methods
		//
		//---------------------------------------------------------------------
		
		public function create(spell:Spell, responder:IResponder):void
		{
			this._responder = responder;
			this._spell = spell;
			
			var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			sb.push(new QueuedStatement(SQL_INSERT, {
                description: spell.description,
                isDomain: spell.isDomain,
                level: spell.level,
                name: spell.name,
                notes: spell.notes
            }));
			dbProxy.applicationDb.executeModify(sb, this.create_resultHandler, 
				this.create_errorHandler);
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
		
		/**
		 * 
		 * @param book
		 * @param responder
		 * 
		 */		
		public function loadByBook(book:SpellBook, responder:IResponder):void
		{
			this._responder = responder;
			
			dbProxy.applicationDb.execute(SQL_SELECT_ALL_BY_BOOK, {spellBookId: book.pid}, 
				this.load_resultHandler, null, this.loadbyBook_errorHandler);
		}

        /**
         *
         * @param book
         * @param responder
         */
        public function save(spell:Spell, responder:IResponder):void
        {
            this._responder = responder;
            this._spell = spell;

            var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
            sb.push(new QueuedStatement(SQL_UPDATE, {
                description: spell.description,
                isDomain: spell.isDomain,
                level: spell.level,
                name: spell.name,
                notes: spell.notes,
                pid: spell.pid
            }));
            dbProxy.applicationDb.executeModify(sb, this.save_resultHandler,
                    this.save_errorHandler);
        }
		
		//---------------------------------------------------------------------
		//
		// Event Handlers
		//
		//---------------------------------------------------------------------
		
		/**
		 * 
		 * @param error
		 * 
		 */		
		protected function create_errorHandler(error:SQLError):void
		{
			CONFIG::debugtrace{ trace("SpellService::create_errorHandler: " + error.toString()); }
		}
		
		/**
		 * 
		 * @param results
		 * 
		 */		
		protected function create_resultHandler(results:Vector.<SQLResult>):void
		{
			this._spell.pid = results[0].lastInsertRowID;
			
			this._responder.result(results);
		}
		
		/**
		 * 
		 * @param error
		 * 
		 */
		protected function loadbyBook_errorHandler(error:SQLError):void
		{
			CONFIG::debugtrace{ trace("SpellService::loadbyBook_errorHandler: " + error.toString()); }
		}
		
		/**
		 * 
		 * @param error
		 * 
		 */		
		protected function load_errorHandler(error:SQLError):void
		{
			CONFIG::debugtrace{ trace("SpellService::load_errorHandler: " + error.toString()); }
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
				list.addItem(Spell.createFromObject(item));
			}
			
			this._responder.result(list);
		}

        /**
         *
         * @param error
         */
        protected function save_errorHandler(error:SQLError):void
        {
            CONFIG::debugtrace{ trace("SpellService::save_errorHandler: " + error.toString()); }
        }

        /**
         *
         * @param results
         */
        protected function save_resultHandler(results:Vector.<SQLResult>):void
        {
            this._responder.result(this._spell);
        }
    }
}