pageextension 90154 ResourceEx extends "Resource List" //77
{
    layout
    {
        addafter("Indirect Cost %")
        {

            field(Capacity; Rec.Capacity)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Capacity field.';
            }
            field("Capacity Word"; Rec."Capacity Word")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Capacity Word field.';
                DrillDownPageId = "HGWA TimeSheet Lines";
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