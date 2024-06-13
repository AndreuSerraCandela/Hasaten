/// <summary>
/// PageExtension JobJournalHasten (ID 90153) extends Record Job Journal //201.
/// </summary>
pageextension 90153 "JobJournalHasten" extends "Job Journal" //201
{
    layout
    {
        addlast(Control1)
        {

            field("Codigo Concepto"; Rec."Codigo Concepto")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Codigo Concepto field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}