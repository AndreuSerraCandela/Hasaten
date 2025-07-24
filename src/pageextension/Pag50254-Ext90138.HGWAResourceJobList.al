pageextension 90138 HGWAResourceJobList extends "HGWA Resource Job List" //50254
{
    layout
    {

        addafter("Job Task No.")
        {

            field(SubProyecto; Rec.SubProyecto)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SubProyecto field.', Comment = '%';
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