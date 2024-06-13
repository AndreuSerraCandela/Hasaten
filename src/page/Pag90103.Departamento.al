/// <summary>
/// Page Departamento (ID 90103).
/// </summary>
page 90103 Departamento
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable=Departamento;
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