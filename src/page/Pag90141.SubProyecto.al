page 90141 SubProyecto
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SubProyecto;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(Codigo; Rec.Codigo)
                {
                    ToolTip = 'Specifies the value of the Codigo field.', Comment = '%';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Descripcion field.', Comment = '%';
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

                trigger OnAction()
                begin

                end;
            }
        }
    }
}