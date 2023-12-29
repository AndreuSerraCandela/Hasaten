/// <summary>
/// PageExtension CardTimeSheet (ID 90100) extends Record HGWA TimeSheet Card.
/// </summary>
pageextension 90100 CardTimeSheet extends "HGWA TimeSheet Card"
{
    // layout
    // {
    //     modify("Resource No.")
    //     {
    //         trigger OnLookup(var Text: Text): Boolean
    //         var
    //             Resource: Record Resource;
    //         begin
    //             If Page.RunModal(0, Resource) = Action::LookupOK Then
    //                 Rec.Validate("Resource No.", Resource."No.");
    //         end;
    //     }
    // }

    actions
    {
        modify("Refresh Job planning")
        {
            Visible = false;
        }

        addafter("Refresh Job planning")
        {

            action("Refresh Job assignation.")
            {
                Caption = 'Actualizar asignación de proyecto';
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    recTSLine: Record "HGWA TimeSheets Lines";
                    recRecursoProyectos: Record "HGWA Resource Jobs";
                    jobNo: Code[20];
                    jobTaskNo: Code[20];
                begin

                    recTSLine.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    if recTSLine.FindSet() then begin
                        repeat

                            //obtiene el proyecto asignado en el día
                            jobNo := '';
                            jobTaskNo := '';
                            recRecursoProyectos.Reset();
                            recRecursoProyectos.SetRange("Resource No.", Rec."Resource No.");
                            recRecursoProyectos.SetFilter("From Date", '..%1', recTSLine."Date");
                            recRecursoProyectos.SetFilter("Until Date", '%1..', recTSLine."Date");
                            if recRecursoProyectos.FindFirst() then begin
                                jobNo := recRecursoProyectos."Resource No.";
                                jobTaskNo := recRecursoProyectos."Job Task No.";
                            end;

                            if recTSLine."Job No." <> jobNo then begin
                                recTSLine.Validate("Job No.", jobNo);
                                recTSLine.Validate("Job Task No.", jobTaskNo);
                                recTSLine.Modify(true);
                            end;

                        until recTSLine.Next = 0;
                    end;
                end;
            }

            action("Create Invoice by TimeSheet")
            {
                ApplicationArea = All;
                Caption = 'Create Invoice by Resource';
                Image = NewInvoice;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    Lines.SetRange(Marked, true);
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.Facturar(Lines);
                end;
            }

            action("Undo Invoice by TimeSheet")
            {
                ApplicationArea = All;
                Caption = 'Undo Invoice by Resource';
                Image = Undo;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.UndoFacturar(Lines);
                end;
            }
            action(Vacaciones)
            {
                ApplicationArea = All;
                Image = Holiday;
                trigger OnAction()
                var
                    Control: Codeunit ControlDeProcesos;
                begin
                    Control.vacas('', '');
                end;
            }
        }
    }
}
