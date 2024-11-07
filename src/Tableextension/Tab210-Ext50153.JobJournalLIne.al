/// <summary>
/// TableExtension JobJournalLIne (ID 90153) extends Record Job Journal Line //210.
/// SE CAMBIA AL 50153,porque esta tabla esta en IRPF (90153)
/// </summary>
tableextension 50153 "JobJournalLIne" extends "Job Journal Line" //210
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