/// <summary>
/// Page Perfil (ID 90102).
/// </summary>
page 90102 Perfil
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Perfil;
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
            action("Recalcular Vacaciones Anuales")
            {
                ApplicationArea = All;
                Image = Calculate;
                trigger OnAction()
                var
                    ControldeProcesos: Codeunit "ControlDeProcesos";
                begin
                    ControldeProcesos.Run();
                end;
            }
        }
    }
}