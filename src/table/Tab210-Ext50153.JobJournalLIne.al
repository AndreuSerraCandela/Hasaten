/// <summary>
/// TableExtension JobJournalLIne (ID 90153) extends Record Job Journal Line //210.
/// </summary>
tableextension 90153 "JobJournalLIne" extends "Job Journal Line" //210
{
    fields
    {
        field(50100; "Codigo Concepto"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HGWA Job Activities".Code;
        }
    }

    var
        myInt: Integer;
}