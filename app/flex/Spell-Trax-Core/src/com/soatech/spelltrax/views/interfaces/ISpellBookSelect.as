package com.soatech.spelltrax.views.interfaces
{
	import spark.components.Button;
	import spark.components.List;

	public interface ISpellBookSelect
	{
		function get addBtn():Button;
		function get bookList():List;
	}
}