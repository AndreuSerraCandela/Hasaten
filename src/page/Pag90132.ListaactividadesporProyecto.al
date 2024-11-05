page 90132 "Lista actividades por Proyecto"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HGWA Job Activities";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Codigo; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Codigo field.';
                }
                field(Descripcion; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}