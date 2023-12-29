/// <summary>
/// Page Tipo Empleado (ID 50101).
/// </summary>
page 90101 "Tipo Empleado"
{
     PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable="Tipo Empleado";
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Detalle)
            {
                field(Code; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
            }
        }
    }
}