package com.soatech.spelltrax.views.interfaces
{
	import spark.components.Button;
	import spark.components.List;

	public interface ISpellSelect
	{
		function get addBtn():Button;
		function get spellList():List;
	}
}