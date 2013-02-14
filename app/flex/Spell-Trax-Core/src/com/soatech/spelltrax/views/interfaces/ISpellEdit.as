package com.soatech.spelltrax.views.interfaces {
import spark.components.Button;
import spark.components.CheckBox;
import spark.components.TextArea;
import spark.components.TextInput;

public interface ISpellEdit {
    function get backBtn():Button;
    function get deleteBtn():Button;
    function get descTextArea():TextArea;
    function get domainCheckBox():CheckBox;
    function get levelInput():TextInput;
    function get nameInput():TextInput;
    function get notesTextArea():TextArea;
    function get saveBtn():Button;
}
}
