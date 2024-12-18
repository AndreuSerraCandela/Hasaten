/// <summary>
/// PageExtension CardTimeSheet (ID 90100) extends Record HGWA TimeSheet Card.
/// </summary>
pageextension 90100 CardTimeSheet extends "HGWA TimeSheet Card" //50252
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
        modify("Refresh Job planning 2")
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

            action("Refresh Job planning 3")
            {
                Caption = 'Actualizar planificación de proyectos';
                ApplicationArea = All;
                Image = Refresh;

                trigger OnAction()
                var
                    recTSLine: Record "HGWA TimeSheets Lines";
                    recResourceJobs: Record "HGWA Resource Jobs";
                    jobNo: Code[20];
                    jobTaskNo: Code[20];
                    /////
                    recResCapacity: Record "Res. Capacity Entry";
                    fromDate: Date;
                    untilDate: Date;
                    iterDate: Date;
                    iMonth: Integer;
                    iYear: Integer;
                    iWeekDay: Integer;
                    isHoliday: Boolean;
                    dHours: Decimal;
                    CtrolProcesos: Codeunit ControlDeProcesos;
                begin

                    //////////////////////////////////////
                    //genera las líneas
                    Evaluate(iMonth, Format(Rec.Month).Split('-').Get(2));
                    Evaluate(iYear, Format(Rec.Month).Split('-').Get(1));
                    fromDate := DMY2Date(1, iMonth, iYear);
                    untilDate := CALCDATE('<CM>', fromDate);
                    iterDate := fromDate;
                    repeat

                        //obtiene el proyecto asignado en el día
                        jobNo := '';
                        jobTaskNo := '';
                        recResourceJobs.Reset();
                        recResourceJobs.SetRange("Resource No.", Rec."Resource No.");
                        recResourceJobs.SetFilter("From Date", '..%1', iterDate);
                        recResourceJobs.SetFilter("Until Date", '%1..', iterDate);
                        if recResourceJobs.FindFirst() then begin
                            jobNo := recResourceJobs."Job No.";
                            jobTaskNo := recResourceJobs."Job Task No.";
                        end;

                        //obtiene la capacidad del recurso para el día
                        dHours := 0;
                        recResCapacity.Reset();
                        recResCapacity.SetRange("Resource No.", Rec."Resource No.");
                        recResCapacity.SetRange("Date", iterDate);
                        if recResCapacity.Find('-') then
                            repeat
                                dHours += recResCapacity.Capacity;
                            until recResCapacity.Next = 0;

                        //comprueba si el día es festivo o sin carga
                        // iWeekDay := Date2DWY(iterDate, 1);
                        // if (iWeekDay = 6) or (iWeekDay = 7) then
                        //     isHoliday := true
                        // else
                        //     isHoliday := false;


                        isHoliday := CtrolProcesos.FestivoNACIONAL(iterDate);

                        recTSLine.Reset();
                        recTSLine.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                        recTSLine.SetRange("Date", iterDate);
                        if recTSLine.FindFirst() then begin
                            recTSLine.Validate("Job No.", jobNo);
                            recTSLine.Validate("Job Task No.", jobTaskNo);
                            recTSLine.Modify(true);
                        end
                        else begin
                            recTSLine.Init();
                            recTSLine.Validate("TimeSheet No.", Rec."TimeSheet No.");
                            recTSLine.Validate("Date", iterDate);
                            recTSLine.Validate("Hours", dHours);
                            recTSLine.Validate("Job No.", jobNo);
                            recTSLine.Validate("Job Task No.", jobTaskNo);
                            recTSLine.Validate(Holiday, isHoliday);
                            recTSLine.Validate("Resource No.", Rec."Resource No.");
                            recTSLine.Insert(true);
                        end;

                        iterDate := CALCDATE('1D', iterDate);
                    until iterDate > untilDate;
                end;
            }
        }
    }
}
