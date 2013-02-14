package com.soatech.spelltrax.services
{
import com.probertson.data.QueuedStatement;
import com.soatech.spelltrax.models.DataBaseProxy;
import com.soatech.spelltrax.models.vo.Spell;
import com.soatech.spelltrax.models.vo.SpellBook;
import com.soatech.spelltrax.services.interfaces.ISpellBookService;

import flash.data.SQLResult;
import flash.errors.SQLError;
import flash.sampler.getSavedThis;

import mx.collections.ArrayCollection;
import mx.rpc.IResponder;

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

    protected var _spell:Spell;

    //---------------------------------------------------------------------
    //
    // SQL
    //
    //---------------------------------------------------------------------

    protected const SQL_SELECT_ALL:String = "SELECT pid, name FROM spellBooks";

    protected const SQL_INSERT:String = "INSERT INTO spellBooks (name) " +
            "VALUES (:name)";

    protected const SQL_UPDATE:String = "UPDATE spellBooks SET name = :name " +
            "WHERE pid = :pid";

    protected const SQL_DELETE:String = "DELETE FROM spellBooks WHERE pid = :pid";

    protected const SQL_DELETE_SPELLS:String = "DELETE from spellBookSpells " +
            "WHERE spellBookId = :spellBookId";

    protected const SQL_LINK_SPELL:String = "INSERT INTO spellBookSpells (spellBookId, spellId) " +
            "VALUES (:spellBookId, :spellId)";

    protected const SQL_UNLINK_SPELL:String = "DELETE FROM spellBookSpells " +
            "WHERE spellBookId = :spellBookId AND spellId = :spellId";

    protected const SQL_SELECT_LINK:String = "SELECT pid FROM spellBookSpells " +
            "WHERE spellbookId = :spellBookId AND spellId = :spellId";

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
        this._responder = responder;

        var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
        sb.push(new QueuedStatement(SQL_INSERT, {name: book.name}));
        dbProxy.applicationDb.executeModify(sb, this.create_resultHandler, this.create_errorHandler);
    }

    /**
     *
     * @param book
     * @param spell
     * @param responder
     */
    public function linkSpell(book:SpellBook, spell:Spell, responder:IResponder):void
    {
        this._responder = responder;
        this._book = book;
        this._spell = spell;

        // make sure it isn't already linked
        dbProxy.applicationDb.execute(SQL_SELECT_LINK, {spellBookId: book.pid,  spellId: spell.pid},
                this.selectLink_resultHandler, null, this.selectLink_errorHandler);
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
     */
    public function remove(book:SpellBook, responder:IResponder):void {
        this._book = book;
        this._responder = responder;

        var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
        sb.push(new QueuedStatement(SQL_DELETE_SPELLS, {spellBookId: book.pid}));
        sb.push(new QueuedStatement(SQL_DELETE, {pid: book.pid}));
        dbProxy.applicationDb.executeModify(sb, this.delete_resultHandler, this.delete_errorHandler);
    }

    /**
     *
     * @param book
     * @param responder
     */
    public function save(book:SpellBook, responder:IResponder):void
    {
        this._book = book;
        this._responder = responder;

        var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
        sb.push(new QueuedStatement(SQL_UPDATE, {name: book.name, pid: book.pid}));
        dbProxy.applicationDb.executeModify(sb, this.save_resultHandler, this.save_errorHandler);
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
        this._responder.fault(error);
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
     */
    protected function delete_errorHandler(error:SQLError):void
    {
        CONFIG::debugtrace{ trace("SpellBookService::delete_errorHandler: " + error.toString()); }
        this._responder.fault(error);
    }

    /**
     *
     * @param results
     */
    protected function delete_resultHandler(results:Vector.<SQLResult>):void
    {
        this._responder.result(this._book);
    }

    /**
     *
     * @param error
     */
    protected function linkSpell_errorHandler(error:SQLError):void
    {
        CONFIG::debugtrace{ trace("SpellBookService::linkSpell_errorHandler: " + error.toString()); }
        this._responder.fault(error);
    }

    /**
     *
     * @param results
     */
    protected function linkSpell_resultHandler(results:Vector.<SQLResult>):void
    {
        this._responder.result(null);
    }

    /**
     *
     * @param error
     *
     */
    protected function load_errorHandler(error:SQLError):void
    {
        CONFIG::debugtrace{ trace("SpellBookService::load_errorHandler: " + error.toString()); }
        this._responder.fault(error);
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

    /**
     *
     * @param error
     */
    protected function save_errorHandler(error:SQLError):void
    {
        CONFIG::debugtrace{ trace("SpellBookService::save_errorHandler: " + error.toString()); }
        this._responder.fault(error);
    }

    /**
     *
     * @param results
     */
    protected function save_resultHandler(results:Vector.<SQLResult>):void
    {
        this._responder.result(this._book);
    }

    /**
     *
     * @param result
     */
    protected function selectLink_resultHandler(result:SQLResult):void
    {
        if( !result.data || !result.data.length )
        {
            var sb:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
            sb.push(new QueuedStatement(SQL_LINK_SPELL, {spellBookId: _book.pid, spellId: _spell.pid}));
            dbProxy.applicationDb.executeModify(sb,  this.linkSpell_resultHandler, this.linkSpell_errorHandler);
        } else {
            this._responder.result(null);
        }
    }

    /**
     *
     * @param error
     */
    protected function selectLink_errorHandler(error:SQLError):void
    {
        CONFIG::debugtrace{ trace("SpellBookService::selectLink_errorHandler: " + error.toString()); }
        this._responder.fault(error);
    }
}
}