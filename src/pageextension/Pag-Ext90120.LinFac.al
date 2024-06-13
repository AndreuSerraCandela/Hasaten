/// <summary>
/// PageExtension EmployeeListEx (ID 90120) extends Record 1029.
/// </summary>
pageextension 90120 LinFac extends 1029
{
    actions
    {
        addlast("F&unctions")
        {
            action(Eliminar)
            {
                ApplicationArea = All;
                Image = Delete;
                Visible = false;
                trigger OnAction()
                var
                    JobPl: Record "Job Planning Line";
                    TimeL: Record "HGWA TimeSheets Lines";
                    Control: Codeunit ControlDeProcesos;
                begin
                    Control.BorrarLinea(Rec);
                end;
            }
        }
    }
}
