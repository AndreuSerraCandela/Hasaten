/// <summary>
/// TableExtension JobLedgEntry (ID 90152) extends Record Job Ledger Entry //169.
/// </summary>
tableextension 90152 "JobLedgEntry" extends "Job Ledger Entry" //169
{
    fields
    {
        field(50100; "Concepto Proyecto"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Descripcion Concepto"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}