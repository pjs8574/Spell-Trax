package com.soatech.spelltrax.views.interfaces
{
	import spark.components.Button;
	import spark.components.List;
	import spark.components.TextInput;

	public interface ISpellBookEdit
	{
		function get addBtn():Button;
		function get backBtn():Button;
		function get deleteBtn():Button;
		function get nameInput():TextInput;
		function get refreshBtn():Button;
		function get saveBtn():Button;
		function get spellList():List;
	}
}