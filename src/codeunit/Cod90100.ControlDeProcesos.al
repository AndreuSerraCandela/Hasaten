/// <summary>
/// Codeunit ControlDeProcesos (ID 90100).
/// </summary>
codeunit 90100 ControlDeProcesos
{
    Permissions = tabledata "Job Planning Line" = rimd, tabledata "HGWA TimeSheets Lines" = rimd, tabledata "Job Planning Line Invoice" = rimd;

    trigger OnRun()
    var
        Employee: Record Employee;
    begin
        if Employee.FindFirst() then
            repeat
                Employee.Consumidas := 0;
                Employee.Validate("Disponible Año Anterior", Employee."Por Consumir");
                Employee.Modify();
            until Employee.Next() = 0;
    end;

    internal procedure Facturar(var Lines: Record "HGWA TimeSheets Lines")
    var
        JobPlaning: Record "Job Planning Line";
        JobPlaning2: Record "Job Planning Line";
        Line: Integer;
        Res: Record Resource;
        Emply: Record Employee;
        Lines2: Record "HGWA TimeSheets Lines";
        Usr: Record "HGWA Users";
        Vacaciones: Decimal;
        JobCreateInvoice: Codeunit "Job Create-Invoice";
        JobSetup: Record "Jobs Setup";
        Vaca: Code[20];
        Job: Record Job;
        Hist: Record "Lin Hist contrato empleado";
        JobJnlManagement: Codeunit JobJnlManagement;
    begin
        Lines.Setrange(JobLine, 0);
        Lines.SetRange("Unit Price", 0);
        //    lines.SetRange(Marked, true);
        If Lines.FindSet() then
            repeat
                Res.Get(Lines."Resource No.");
                Emply.SetRange("Resource No.", Res."No.");
                If Emply.FindFirst() then begin
                    Hist.SetRange(Empleado, Emply."No.");
                    // Hist.SetRange(Proyecto, Lines."Job No.");
                    Hist.SetFilter("Fecha Inicio", '%1|<%2', Lines.Date);
                    Hist.SetFilter("Fecha Fin", '%1|>%2', 0D, Lines.Date); //vlrangel
                    //Hist.SetRange("Tarifa Actúal", true);
                    If Hist.FindLast() then
                        Lines."Unit Price" := Hist."Tarifa 1" else
                        Lines."Unit Price" := Emply.Tarifa;
                    Lines.Modify();
                end;
            until Lines.Next() = 0;
        Lines.SetRange("Unit Price");
        If Lines.FindSet() then
            repeat
                JobSetup.Get();
                //JobSetup.TestField("Holidays Code");
                Job.Get(Lines."Job No.");
                If (JobSetup."Holidays Code" = Lines."Activity Code") or
                (Job.Holiday) or (JobSetup."Holidays Code" = Lines."Job No.") then begin
                    //TimeSheet.Get(Lines."TimeSheet No.");
                    Res.Get(Lines."Resource No.");
                    Emply.SetRange("Resource No.", Res."No.");
                    If Emply.FindFirst() then begin
                        Lines2.Reset();
                        Lines2.SetRange("Resource No.", Res."No.");
                        Vacaciones := 0;

                        Lines2.SetRange(Date, CalcDate('PA+1d-1A', Today), CalcDate('PA', Today));
                        Lines2.SetRange("Job No.", Job."No.");
                        //Lines2.SetRange(Holiday, true);
                        Vacaciones += Lines2.Count;
                        Emply.Consumidas := Vacaciones;
                        Emply."Por Consumir" := Emply.Disponible + Emply."Disponible Año Anterior" - Vacaciones;
                        Emply.Modify();
                        JobPlaning.Init();
                        JobPlaning."Contract Line" := true;
                        JobPlaning2.SetRange("Job No.", Lines."Job No.");
                        JobPlaning2.SetRange("Job Task No.", Lines."Job Task No.");
                        If JobPlaning2.FindLast() then Line := JobPlaning2."Line No.";
                        JobPlaning."Job No." := Lines."Job No.";
                        JobPlaning."Planning Date" := Lines.Date;
                        JobPlaning."Job Task No." := Lines."Job Task No.";
                        JobPlaning."Line No." := Line + 10000;
                        JobPlaning."Line Type" := JobPlaning."Line Type"::Billable;
                        JobPlaning.Type := JobPlaning.Type::Resource;
                        JobPlaning.Validate("No.", Lines."Resource No.");
                        JobPlaning.Validate(Quantity, Lines.Hours);
                        JobPlaning.TimeSheet := lines."TimeSheet No.";
                        JobPlaning.Validate("Unit Price", Lines."Unit Price");


                        //JobPlaning.Validate("Qty. to Invoice", Lines.Hours);
                        //JobPlaning.Validate("Qty. to Transfer to Invoice", Lines.Hours);
                        While not JobPlaning.Insert() do begin
                            JobPlaning."Line No." := Line;
                            line += 10000;
                        end;
                        Lines.JobLine := JobPlaning."Line No.";
                        Lines.Modify();
                    end;

                end else begin
                    JobPlaning.SetRange("Job No.", Lines."Job No.");
                    JobPlaning.SetRange("Job Task No.", Lines."Job Task No.");
                    JobPlaning.SetRange(Type, JobPlaning.Type::Resource);
                    JobPlaning.SetRange("Line Type", JobPlaning."Line Type"::Billable);
                    JobPlaning.SetRange("Planning Date", CalcDate('PM', Lines.Date));
                    JobPlaning.SetRange("Unit Price", Lines."Unit Price");
                    JobPlaning.SetRange("No.", Lines."Resource No.");
                    If JobPlaning.FindLast() AND NOT (LineaFacturada(JobPlaning, Lines)) Then begin
                        JobPlaning.Validate(Quantity, JobPlaning.Quantity + Lines.Hours);
                        JobPlaning.TimeSheet := lines."TimeSheet No.";
                        //JobPlaning.Validate("Qty. to Invoice", JobPlaning."Qty. to Invoice" + Lines.Hours);
                        // JobPlaning.Validate("Qty. to Transfer to Invoice", JobPlaning."Qty. to Transfer to Invoice" + Lines.Hours);
                        JobPlaning.Modify();
                    end else begin

                        ////////////////////
                        JobPlaning.Init();
                        JobPlaning."Contract Line" := true;
                        JobPlaning2.SetRange("Job No.", Lines."Job No.");
                        JobPlaning2.SetRange("Job Task No.", Lines."Job Task No.");
                        If JobPlaning2.FindLast() then Line := JobPlaning2."Line No.";
                        JobPlaning."Job No." := Lines."Job No.";
                        JobPlaning."Planning Date" := CalcDate('PM', Lines.Date);
                        //JobPlaning."Planning Date" := Lines.Date;
                        JobPlaning."Job Task No." := Lines."Job Task No.";
                        JobPlaning."Line No." := Line + 10000;
                        JobPlaning."Job Contract Entry No." := JobJnlManagement.GetNextEntryNo();
                        JobPlaning."Line Type" := JobPlaning."Line Type"::Billable;
                        JobPlaning.Type := JobPlaning.Type::Resource;
                        JobPlaning."No." := Lines."Resource No.";
                        JobPlaning.Validate("No.", Lines."Resource No.");

                        //JobPlaning.Validate(Quantity, Lines.Hours);
                        JobPlaning.Quantity := Lines.Hours;
                        JobPlaning.TimeSheet := lines."TimeSheet No.";
                        //JobPlaning.Validate("Unit Price", Lines."Unit Price");
                        JobPlaning."Unit Price" := Lines."Unit Price";


                        //////////////////
                        /*   JobPlaning.Init();
                           JobPlaning.Reset();
                           JobPlaning."Contract Line" := true;
                           JobPlaning2.SetRange("Job No.", Lines."Job No.");
                           If JobPlaning2.FindLast() then Line := JobPlaning2."Line No.";
                           JobPlaning."Job No." := Lines."Job No.";
                           JobPlaning."Planning Date" := CalcDate('PM', Lines.Date);
                           JobPlaning."Job Task No." := Lines."Job Task No.";
                           JobPlaning."Line No." := Line + 10000;
                           JobPlaning."Job Contract Entry No." := JobJnlManagement.GetNextEntryNo();
                           JobPlaning."Line Type" := JobPlaning."Line Type"::Billable;
                           JobPlaning.Type := JobPlaning.Type::Resource;
                           // JobPlaning.Validate("No.", Lines."Resource No.");
                           JobPlaning."No." := Lines."Resource No.";
                           //JobPlaning.Validate(Quantity, Lines.Hours);
                           JobPlaning.Quantity := Lines.Hours;
                           JobPlaning.TimeSheet := lines."TimeSheet No.";
                           //JobPlaning.Validate("Unit Price", Lines."Unit Price");
                           JobPlaning."Unit Price" := Lines."Unit Price";

   */
                        //JobPlaning.Validate("Qty. to Invoice", Lines.Hours);
                        //JobPlaning.Validate("Qty. to Transfer to Invoice", Lines.Hours);
                        While not JobPlaning.Insert() do begin

                            if line = 0 then
                                line += 10000;
                            JobPlaning."Line No." := Line;
                            line += 10000;


                        end;
                    end;

                    Lines.JobLine := JobPlaning."Line No.";
                    Lines.Modify();
                end;
            until Lines.Next() = 0;
        Commit();
        JobPlaning.Reset();
        JobPlaning.SetRange("Job No.", Lines."Job No.");
        Commit();
        if JobPlaning.FindFirst() then
            repeat
                if JobPlaning."Line Type" = JobPlaning."Line Type"::Billable Then begin
                    JobPlaning."Contract Line" := true;

                    JobPlaning.CalcFields("Qty. Transferred to Invoice");
                    JobPlaning.Validate("Qty. to Transfer to Invoice", JobPlaning.Quantity - JobPlaning."Qty. Invoiced" - JobPlaning."Qty. Transferred to Invoice");
                    JobPlaning.Modify();

                    //JobPlaning.Validate("No.", Lines."Resource No.");
                    //JobPlaning.Modify();
                end;
            until JobPlaning.Next() = 0;
        Commit();
        JobCreateInvoice.CreateSalesInvoice(JobPlaning, false);
    end;

    internal procedure LineaFacturada(var planing: Record "Job Planning Line"; plineas: Record "HGWA TimeSheets Lines"): Boolean
    var
        Linea: Record "HGWA TimeSheets Lines";
    begin
        plineas.SetRange("Job No.", planing."Job No.");
        plineas.SetRange("Resource No.", planing."No.");
        plineas.SetRange("Job Task No.", planing."Job Task No.");
        plineas.SetRange(JobLine, planing."Line No.");
        plineas.SetRange(plineas.Invoiced, true);
        if plineas.FindLast() then begin
            if plineas.Invoiced = TRUE then begin
                exit(TRUE)
            END ELSE
                exit(false);
        end else
            exit(false);
    end;


    internal procedure UndoFacturar(var Lines: Record "HGWA TimeSheets Lines")
    var
        JobPlaning: Record "Job Planning Line";
        JobPlaning2: Record "Job Planning Line";
        Line: Integer;
        Res: Record Resource;
        Emply: Record Employee;
        Lines2: Record "HGWA TimeSheets Lines";
        Usr: Record "HGWA Users";
        Vacaciones: Decimal;
        JobCreateInvoice: Codeunit "Job Create-Invoice";
        jobSetup: Record "Jobs Setup";
    begin
        Lines.SetFilter(JobLine, '<>%1', 0);
        If Lines.FindFirst() then
            repeat
                JobSetup.Get();
                JobSetup.TestField("Holidays Code");

                If (JobSetup."Holidays Code" = Lines."Activity Code") then begin


                end else begin
                    JobPlaning.SetRange("Job No.", Lines."Job No.");
                    JobPlaning.SetRange("Job Task No.", Lines."Job Task No.");
                    JobPlaning.SetRange(Type, JobPlaning.Type::Resource);
                    JobPlaning.SetRange("Line Type", JobPlaning."Line Type"::Billable);
                    JobPlaning.SetRange("Planning Date", CalcDate('PM', Lines.Date));
                    If JobPlaning.FindFirst() Then begin
                        JobPlaning.Validate(Quantity, JobPlaning.Quantity - Lines.Hours);
                        JobPlaning.TimeSheet := '';
                        //JobPlaning.Validate("Qty. to Invoice", JobPlaning."Qty. to Invoice" + Lines.Hours);
                        // JobPlaning.Validate("Qty. to Transfer to Invoice", JobPlaning."Qty. to Transfer to Invoice" + Lines.Hours);
                        JobPlaning.Modify();
                    end
                end;
            until Lines.Next() = 0;
        Lines.ModifyAll(JobLine, 0);

    end;

    internal procedure BorrarLinea(var Rec: Record "Job Planning Line Invoice")
    var
        JobPl: Record "Job Planning Line";
        TimeL: Record "HGWA TimeSheets Lines";
        JobPlIn: Record "Job Planning Line Invoice";
    begin
        JobPl.SetRange("Job No.", Rec."Job No.");
        JobPl.SetRange("Job Task No.", Rec."Job Task No.");
        JobPl.SetRange("Line No.", Rec."Job Planning Line No.");
        TimeL.SetRange("Job No.", Rec."Job No.");
        Timel.SetRange("Job Task No.", Rec."Job Task No.");
        TImel.SetRange("JobLine", Rec."Job Planning Line No.");
        TimeL.ModifyAll(Invoiced, false);
        TimeL.ModifyAll(JobLine, 0);
        JobPl.DeleteAll();
        JobPlin.SetRange("Job No.", Rec."Job No.");
        JobPlIn.DeleteAll();
        Rec.Delete();
    end;


    procedure CrearPartesMensual()
    var
        RResurso: Record "Resource";
        // RecursoPorProyecto: Record "WAPP Resource Jobs";
        RecursoPorProyecto: Record "HGWA Resource Jobs";
        dlgDateTime: Page "Date-Time Dialog";
        //  CabeceraPArte: Record "WAPP TimeSheets";
        CabeceraPArte: Record "HGWA TimeSheets";
        Month: Code[20];
        pMonth: Code[20];
        iMonth: Integer;
        iYear: Integer;
        iterDate: Date;
        fromDate: Date;
        untilDate: Date;
        //  CabParteExiste: Record "WAPP TimeSheets";
        CabParteExiste: Record "HGWA TimeSheets";
    //  WebRecurso: Record "WAPP Users";

    begin
        if Confirm('Desea crear partes a los Recurso', true, false) then begin
            dlgDateTime.UseDateOnly();
            if dlgDateTime.RunModal() = Action::OK then begin
                Month := Format(dlgDateTime.GetDate(), 0, '<Year4>-<Month,2>');
                // If (CabeceraPArte."TimeSheet No." = '') and (CabeceraPArte."Resource No." <> '') and (CabeceraPArte.Month <> '') then begin
                //     CabeceraPArte."TimeSheet No." := StrSubstNo('%1_%2', CabeceraPArte."Resource No.", CabeceraPArte.Month);
                // end;
                pMonth := Month;

                Evaluate(iMonth, Format(pMonth).Split('-').Get(2));
                Evaluate(iYear, Format(pMonth).Split('-').Get(1));
                fromDate := DMY2Date(1, iMonth, iYear);
                untilDate := CALCDATE('<CM>', fromDate);
                iterDate := fromDate;

                RResurso.SetRange(Blocked, false);
                if RResurso.FindFirst() then begin
                    //si devuelve un false entonces ok al proceso, si devulve true el recurso esta bloqueado por la web.               
                    repeat
                        if RecursoEmpleado(RResurso."No.") then begin
                            RecursoPorProyecto.SetRange("Resource No.", RResurso."No.");
                            RecursoPorProyecto.SetFilter("From Date", '..%1', iterDate);
                            RecursoPorProyecto.SetFilter("Until Date", '%1..', iterDate);
                            // RecursoPorProyecto.SetFilter();
                            if RecursoPorProyecto.FindFirst() then begin

                                CabeceraPArte.Init();
                                CabeceraPArte."TimeSheet No." := StrSubstNo('%1_%2', RResurso."No.", Month);
                                CabeceraPArte.Validate(CabeceraPArte.Month, Month);
                                CabeceraPArte.Validate("Resource No.", RResurso."No.");

                                CabParteExiste.SetRange("TimeSheet No.", CabeceraPArte."TimeSheet No.");
                                if not CabParteExiste.FindFirst() then begin
                                    CabeceraPArte.Insert(true);
                                    LineasPartes(Month, CabeceraPArte);
                                end;

                            end;
                        end;
                    until RResurso.Next = 0;
                end;
            end;
        end;
    end;

    //local procedure LineasPartes(pMonth: code[20]; var pCabParte: Record "WAPP TimeSheets")
    local procedure LineasPartes(pMonth: code[20]; var pCabParte: Record "HGWA TimeSheets")
    var
        //  recTSLine: Record "WAPP TimeSheets Lines";
        //  recResourceJobs: Record "WAPP Resource Jobs";
        recTSLine: Record "HGWA TimeSheets Lines";
        recResourceJobs: Record "HGWA Resource Jobs";
        jobNo: Code[20];
        jobTaskNo: Code[20];
        jobHour: Decimal;
        jobType: Code[20];
        recResCapacity: Record "Res. Capacity Entry";
        fromDate: Date;
        untilDate: Date;
        iterDate: Date;
        iMonth: Integer;
        iYear: Integer;
        iWeekDay: Integer;
        isHoliday: Boolean;
        dHours: Decimal;
        WorkTypeCod: Code[20];
    // controlProcesos: Codeunit EventosRadial;
    begin
        //genera las líneas
        //CALCULAMOS FECHAS.
        Evaluate(iMonth, Format(pMonth).Split('-').Get(2));
        Evaluate(iYear, Format(pMonth).Split('-').Get(1));
        fromDate := DMY2Date(1, iMonth, iYear);
        untilDate := CALCDATE('<CM>', fromDate);
        iterDate := fromDate;

        repeat
            //obtiene el proyecto asignado en el día
            isHoliday := false;
            jobNo := '';
            jobTaskNo := '';
            recResourceJobs.Reset();
            recResourceJobs.SetRange("Resource No.", pCabParte."Resource No.");
            recResourceJobs.SetFilter("From Date", '..%1', iterDate);
            recResourceJobs.SetFilter("Until Date", '%1..', iterDate);
            if recResourceJobs.FindFirst() then begin
                jobNo := recResourceJobs."Job No.";
                jobTaskNo := recResourceJobs."Job Task No.";
                // jobHour := recResourceJobs.Hours;
                // jobType := recResourceJobs."Activity Code";
                // WorkTypeCod := recResourceJobs."Work Type Code";
            end;

            // if rec.Festivos = false then
            //     controlProcesos.DiasFestivos(iterDate, rec.Festivos);


            //obtiene la capacidad del recurso para el día
            dHours := 0;
            recResCapacity.Reset();
            recResCapacity.SetRange("Resource No.", pCabParte."Resource No.");
            recResCapacity.SetRange("Date", iterDate);
            if recResCapacity.Find('-') then
                repeat
                    dHours += recResCapacity.Capacity;
                until recResCapacity.Next = 0;

            isHoliday := FestivoNACIONAL(iterDate);
            // PagCalendarioBaseVerFestivo.FindeSemana(fromDate, isHoliday);
            //buscarfestivo

            recTSLine.Reset();
            // recTSLine.SetRange("TimeSheet No.", Rec."TimeSheet No.");
            recTSLine.SetRange("TimeSheet No.", pCabParte."TimeSheet No.");
            recTSLine.SetRange("Date", iterDate);
            if recTSLine.FindFirst() then begin
                recTSLine.Validate("Job No.", jobNo);
                recTSLine.Validate("Job Task No.", jobTaskNo);
                //  recTSLine.Validate("Work Type Code", WorkTypeCod);
                recTSLine.Validate("Activity Code", jobType);

                //(pCabParte."Fines De Semana" = false) and 
                if (isHoliday = true) then begin
                    recTSLine.Validate("Hours", 0);
                end else begin
                    recTSLine.Validate("Hours", dHours);
                end;
                recTSLine.Modify(true);
            end else begin
                recTSLine.Init();
                recTSLine.Validate("TimeSheet No.", pCabParte."TimeSheet No.");
                recTSLine.Validate("Date", iterDate);
                // (pCabParte."Fines De Semana" = false) and
                if (isHoliday = true) then begin
                    recTSLine.Validate("Hours", 0);

                end else begin

                    if jobHour = 0 then begin
                        recTSLine.Validate("Hours", dHours);
                    end else
                        recTSLine.Validate("Hours", jobHour);
                end;

                recTSLine.Validate("Job No.", jobNo);
                recTSLine.Validate("Job Task No.", jobTaskNo);
                recTSLine.Validate(Holiday, isHoliday);
                recTSLine.Validate("Resource No.", pCabParte."Resource No.");
                recTSLine.Validate("Activity Code", jobType);
                //  recTSLine.Validate("Work Type Code", WorkTypeCod);
                recTSLine.Insert(true);
            end;

            iterDate := CALCDATE('1D', iterDate);
        until iterDate > untilDate;
    end;

    procedure RecursoEmpleado(pResurso: Code[20]): Boolean
    var
        empleadoRecurso: Record Employee;
    begin

        empleadoRecurso.SetRange("Resource No.", pResurso);
        if empleadoRecurso.FindFirst() then begin
            if empleadoRecurso.Status = empleadoRecurso.Status::Active then begin
                exit(true);
            end else begin
                exit(false);
            end;
        end;


    end;



    /// <summary>
    /// vacas.
    /// </summary>
    /// <param name="No">Code[20].</param>
    /// <param name="JobNo">Code[20].</param>
    procedure vacas(No: Code[20]; JobNo: Code[20])
    var
        Emply: Record Employee;
        Lines2: Record "HGWA TimeSheets Lines";
        Vacaciones: Integer;
        Job: Record Job;
    begin
        If No <> '' tHEN
            Emply.SetRange(Emply."No.", No);
        if Emply.FindFirst() Then
            repeat
                Lines2.Reset();
                Lines2.SetRange("Resource No.", Emply."Resource No.");
                Vacaciones := 0;

                Lines2.SetRange(Date, CalcDate('PA+1d-1A', Today), CalcDate('PA', Today));
                Job.SetRange(Holiday, true);
                IF jOBnO <> '' tHEN jOB.sETRANGE("No.", JobNo);
                If Job.FindFirst() then
                    repeat
                        Lines2.SetRange("Job No.", Job."No.");
                        //Lines2.SetRange(Holiday, true);
                        Vacaciones += Lines2.Count;
                    until Job.Next() = 0;
                Emply.Consumidas := Vacaciones;
                Emply."Por Consumir" := Emply.Disponible + Emply."Disponible Año Anterior" - Vacaciones;
                Emply.Modify();
            until Emply.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnAfterJobPlanningLineModify', '', false, false)]
    local procedure OnAfterJobPlanningLineModify(var JobPlanningLine: Record "Job Planning Line")
    var
        TimeSheetLine: Record "HGWA TimeSheets Lines";
    begin
        if JobPlanningLine.TimeSheet <> '' Then begin
            TimeSheetLine.SetRange("TimeSheet No.", JobPlanningLine.TimeSheet);
            TimeSheetLine.SetRange("Resource No.", JobPlanningLine."No.");
            TimeSheetLine.SetRange("Job No.", JobPlanningLine."Job No.");
            TimeSheetLine.SetRange("Job Task No.", JobPlanningLine."Job Task No.");//vlrangel 15112023
            TimeSheetLine.SetRange(JobLine, JobPlanningLine."Line No."); //vlrangel
            TimeSheetLine.ModifyAll(Invoiced, true);
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertLine(var Rec: Record "HGWA TimeSheets Lines")
    var
        JobSetup: Record "Jobs Setup";
        Cab: Record "HGWA TimeSheets";
        Res: Record Resource;
        Emply: Record Employee;
        recRecursoProyectos: Record "HGWA Resource Jobs";
        Hist: Record "Lin Hist contrato empleado";
        Job: Record Job;
    begin
        // If JobSetup.Get() Then begin
        //     If JobSetup."Holidays Code" <> '' then begin
        //         if JobSetup."Holidays Code" = Rec."Activity Code" Then Rec.Holiday := true;
        //     end;
        // end;
        If not Res.Get(Rec."Resource No.") Then begin
            If Cab.Get(Rec."TimeSheet No.") Then Rec."Resource No." := Cab."Resource No.";
            IF Res.Get(Rec."Resource No.") then;
        end;

        recRecursoProyectos.Reset();
        recRecursoProyectos.SetRange("Resource No.", Rec."Resource No.");
        recRecursoProyectos.SetFilter("From Date", '..%1', Rec.Date);
        recRecursoProyectos.SetFilter("Until Date", '%1..', Rec.Date);
        if recRecursoProyectos.FindFirst() then begin
            Rec."Job No." := recRecursoProyectos."Job No.";
            rec."Job Task No." := recRecursoProyectos."Job Task No.";

        end;
        Emply.SetRange("Resource No.", Res."No.");
        If Emply.FindFirst() then begin
            If Rec."Unit Price" = 0 Then begin
                Hist.SetCurrentKey(Empleado, "Fecha Inicio", "Fecha Fin");
                Hist.SetRange(Empleado, Emply."No.");
                Hist.SetRange(Proyecto, Rec."Job No.");
                Hist.SetFilter("Fecha Inicio", '%1|<=%2', 0D, Rec.Date);
                Hist.SetFilter("Fecha Fin", '%1|>=%2', 0D, Rec.Date);
                //Hist.SetRange("Tarifa Actúal", true);
                If Hist.FindLast() then
                    Rec."Unit Price" := Hist."Tarifa 1" else
                    Rec."Unit Price" := Emply.Tarifa;
            end;

        end;

        FindCostResourceEmployContract(REc);

    end;

    // [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterDeleteEvent', '', false, false)]
    // local procedure OnAfterDeleteLine(var Rec: Record "HGWA TimeSheets Lines")
    // var
    //     Empleado: Code[20];
    //     Res: Record Resource;
    //     Cab: Record "HGWA TimeSheets";
    //     Emply: Record Employee;
    //     JobPlaningLine: Record "Job Planning Line";
    //     Job: Record Job;
    // begin
    //     // If JobSetup.Get() Then begin
    //     //     If JobSetup."Holidays Code" <> '' then begin
    //     //         if JobSetup."Holidays Code" = Rec."Activity Code" Then Rec.Holiday := true;
    //     //     end;
    //     // end;
    //     If not Res.Get(Rec."Resource No.") Then begin
    //         If Cab.Get(Rec."TimeSheet No.") Then Rec."Resource No." := Cab."Resource No.";
    //         Res.Get(Rec."Resource No.");
    //     end;
    //     If job.Get(Rec."Job No.") Then begin
    //         If job.Holiday Then begin
    //             If JobPlaningLine.Get(Rec."Job No.", Rec."Job Task No.", Rec.JobLine) then
    //                 JobPlaningLine.Delete();
    //         end;
    //     end;
    //     Emply.SetRange("Resource No.", Res."No.");
    //     If Emply.FindFirst() then begin
    //         vacas(Emply."No.", Job."No.");
    //     end;

    // end;

    [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterValidateEvent', 'Resource No.', false, false)]
    local procedure OnAfterModifyLine(var Rec: Record "HGWA TimeSheets Lines")
    var
        JobSetup: Record "Jobs Setup";
        Cab: Record "HGWA TimeSheets";
        Res: Record Resource;
        Emply: Record Employee;
        ErrorBlo: Label 'Bloked';
        Hist: Record "Lin Hist contrato empleado";
    begin
        If Rec.Bloked Then Error(ErrorBlo);
        If not Res.Get(Rec."Resource No.") Then begin
            If Cab.Get(Rec."TimeSheet No.") Then Rec."Resource No." := Cab."Resource No.";
            Res.Get(Rec."Resource No.");
        end;
        Emply.SetRange("Resource No.", Res."No.");
        If Emply.FindFirst() then begin
            if Rec."Job No." <> '' then begin
                If Rec."Unit Price" = 0 Then begin
                    Hist.SetRange(Empleado, Emply."No.");
                    // Hist.SetRange(Proyecto, Rec."Job No.");                
                    Hist.SetFilter("Fecha Inicio", '%1|<%2', 0D, Rec.Date);
                    Hist.SetFilter("Fecha Fin", '%1|>%2', 0D, rec.Date); //vlrangel
                    //Hist.SetRange("Tarifa Actúal", true);
                    If Hist.FindLast() then
                        Rec."Unit Price" := Hist."Tarifa 1" else
                        Rec."Unit Price" := Emply.Tarifa;
                end;
                FindCostResourceEmployContract(rec);
            end;
        end;

    end;


    [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterValidateEvent', 'Job No.', false, false)]
    local procedure OnAfterModifyLineJOB(var Rec: Record "HGWA TimeSheets Lines")
    var
        JobSetup: Record "Jobs Setup";
        Cab: Record "HGWA TimeSheets";
        Res: Record Resource;
        Emply: Record Employee;
        ErrorBlo: Label 'Bloked';
        Hist: Record "Lin Hist contrato empleado";
    begin
        If Rec.Bloked Then Error(ErrorBlo);
        If not Res.Get(Rec."Resource No.") Then begin
            If Cab.Get(Rec."TimeSheet No.") Then Rec."Resource No." := Cab."Resource No.";
            Res.Get(Rec."Resource No.");
        end;
        Emply.SetRange("Resource No.", Res."No.");
        If Emply.FindFirst() then begin
            if Rec."Job No." <> '' then begin
                // If Rec."Unit Price" = 0 Then begin
                Hist.SetRange(Empleado, Emply."No.");
                Hist.SetRange(Proyecto, Rec."Job No.");
                Hist.SetFilter("Fecha Inicio", '%1|<=%2', 0D, Rec.Date);
                Hist.SetFilter("Fecha Fin", '%1|>=%2', 0D, rec.Date); //vlrangel
                //Hist.SetRange("Tarifa Actúal", true);
                If Hist.FindLast() then
                    Rec."Unit Price" := Hist."Tarifa 1" else
                    Rec."Unit Price" := Emply.Tarifa;
                // end;
            end;
        end;

    end;

    // [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterValidateEvent', 'Job No.', false, false)]
    // local procedure OnAfterModifyJobLine(var Rec: Record "HGWA TimeSheets Lines")
    // var
    //     JobSetup: Record "Jobs Setup";
    //     Cab: Record "HGWA TimeSheets";
    //     Res: Record Resource;
    //     Emply: Record Employee;
    //     ErrorBlo: Label 'Bloked';
    //     Hist: Record "Lin Hist contrato empleado";
    // begin
    //     If not Res.Get(Rec."Resource No.") Then begin
    //         If Cab.Get(Rec."TimeSheet No.") Then Rec."Resource No." := Cab."Resource No.";
    //         Res.Get(Rec."Resource No.");
    //     end;
    //     Emply.SetRange("Resource No.", Res."No.");
    //     If Emply.FindFirst() then begin
    //         vacas(Emply."No.", Rec."Job No.");
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"HGWA TimeSheets Lines", 'OnAfterValidateEvent', 'Job No.', false, false)]
    // local procedure OnAfterModifyJobLine(var Rec: Record "HGWA TimeSheets Lines")
    // var
    //     JobSetup: Record "Jobs Setup";
    //     recTSLine: Record "HGWA TimeSheets Lines";
    //     recRecursoProyectos: Record "Recurso por Proyectos";
    //     jobNo: Code[20];
    //     ErrorBlo: Label 'Bloked';
    //     jobTaskNo: Code[20];
    // begin
    //     If Rec.Bloked Then Error(ErrorBlo);
    //     recRecursoProyectos.Reset();
    //     recRecursoProyectos.SetRange("No.Recurso", Rec."Resource No.");
    //     recRecursoProyectos.SetFilter("Fecha Desde", '..%1', Rec."Date");
    //     recRecursoProyectos.SetFilter("Fecha Hasta", '%1..', Rec."Date");
    //     if recRecursoProyectos.FindFirst() then begin
    //         jobNo := recRecursoProyectos."No. Proyecto";
    //         Rec."Job Task No." := recRecursoProyectos.Tarea;
    //         Rec.Modify();
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OndeleteJobPlaningLine(var Rec: Record "Job Planning Line")
    var
        Lines: Record "HGWA TimeSheets Lines";
        Lines2: Record "HGWA TimeSheets Lines";
        JobPlaning: Record "Job Planning Line";
        JobSetup: Record "Jobs Setup";
        Job: Record Job;
        Res: Record Resource;
        Emply: Record Employee;
        Vacaciones: Integer;
        JobPlaning2: Record "Job Planning Line";
    begin
        If Rec."Line Type" = Rec."Line Type"::Billable Then begin
            Lines.SetRange("Job No.", Rec."Job No.");
            Lines.SetRange("Job Task No.", Rec."Job Task No.");
            Lines.SetRange(JobLine, Rec."Line No.");
            If Lines.FindSet() then
                repeat
                    JobSetup.Get();
                    //JobSetup.TestField("Holidays Code");
                    Job.Get(Lines."Job No.");
                    If (JobSetup."Holidays Code" = Lines."Activity Code") or
                    (Job.Holiday) or (JobSetup."Holidays Code" = Lines."Job No.") then begin
                        //TimeSheet.Get(Lines."TimeSheet No.");
                        Res.Get(Lines."Resource No.");
                        Emply.SetRange("Resource No.", Res."No.");
                        If Emply.FindFirst() then begin
                            Lines2.Reset();

                            Lines2.SetRange("Resource No.", Res."No.");
                            Vacaciones := 0;

                            Lines2.SetRange(Date, CalcDate('PA+1d-1A', Today), CalcDate('PA', Today));
                            Lines2.SetRange("Job No.", Job."No.");
                            //Lines2.SetRange(Holiday, true);
                            Vacaciones += Lines2.Count;
                            Emply.Consumidas := Vacaciones;
                            Emply."Por Consumir" := Emply.Disponible + Emply."Disponible Año Anterior" - Vacaciones;
                            Emply.Modify();

                        end;

                    end;

                until Lines.Next() = 0;
            Lines.SetRange(Invoiced, false);
            Lines.ModifyAll(JobLine, 0);
        end;

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnDeleteSalesLineOnBeforeJobPlanningLineModify', '', false, false)]
    // local procedure OnDeleteSalesLineOnBeforeJobPlanningLineModify(var JobPlanningLine: Record "Job Planning Line")

    // var
    //     Lines: Record "HGWA TimeSheets Lines";
    //     Lines2: Record "HGWA TimeSheets Lines";
    //     JobPlaning: Record "Job Planning Line";
    //     JobSetup: Record "Jobs Setup";
    //     Job: Record Job;
    //     Res: Record Resource;
    //     Emply: Record Employee;
    //     Vacaciones: Integer;
    //     JobPlaning2: Record "Job Planning Line";

    // begin
    //     //error('Se ve a proceder a acturalizar Proyecto %1 Tarea %2 Linea %3', JobPlanningLine."Job No.", JobPlanningLine."Job Task No.", JobPlanningLine."Line No.");
    //     Lines.SetRange("Job No.", JobPlanningLine."Job No.");
    //     Lines.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
    //     Lines.SetRange(Date, JobPlanningLine."Document Date");
    //     If Job.Get(JobPlanningLine."Job No.") Then If Job.Holiday Then exit;
    //     If JobPlanningLine.Type <> JobPlanningLine.Type::Resource Then Exit;
    //     If JobPlanningLine."Line Type" <> JobPlanningLine."Line Type"::Billable Then exit;
    //     Lines.SetRange(Date, Calcdate('PM+1D-1M', JobPlanningLine."Planning Date"), CalcDate('PM', JobPlanningLine."Planning Date"));
    //     Lines.SetRange("Unit Price", Lines."Unit Price");
    //     Lines.SetRange("Resource No.", JobPlanningLine."No.");
    //     Lines.SetRange(Invoiced, false);
    //     Lines.ModifyAll(JobLine, 0);

    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeDeleteSalesLine', '', false, false)]
    // local procedure OnBeforeDeleteSalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    // begin
    //     // Message('Se ve a proceder a acturalizar Proyecto %1 Tarea %2 Linea %3', SalesLine."Job No.", SalesLine."Job Task No.", SalesLine."Job Contract Entry No.");
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnDeleteOnBeforeTestStatusOpen', '', false, false)]
    local procedure OnDelete(var SalesLine: Record "Sales Line"; IsHandled: Boolean)
    var
        Lines: Record "HGWA TimeSheets Lines";
        Lines2: Record "HGWA TimeSheets Lines";
        JobPlanningLine: Record "Job Planning Line";
        JobSetup: Record "Jobs Setup";
        Job: Record Job;
        Res: Record Resource;
        Emply: Record Employee;
        Vacaciones: Integer;
        JobPlaning2: Record "Job Planning Line";
        JobPlanningLineInvoice: Record "Job Planning Line Invoice";
    begin
        IsHandled := true;
        //with JobPlanningLineInvoice do begin
        case SalesLine."Document Type" of
            SalesLine."Document Type"::Invoice:
                JobPlanningLineInvoice.SetRange("Document Type", JobPlanningLineInvoice."Document Type"::Invoice);
            SalesLine."Document Type"::"Credit Memo":
                JobPlanningLineInvoice.SetRange("Document Type", JobPlanningLineInvoice."Document Type"::"Credit Memo");
        end;
        JobPlanningLineInvoice.SetRange("Document No.", SalesLine."Document No.");
        JobPlanningLineInvoice.SetRange("Line No.", SalesLine."Line No.");
        if JobPlanningLineInvoice.FindSet() then begin
            repeat
                JobPlanningLine.Get(JobPlanningLineInvoice."Job No.", JobPlanningLineInvoice."Job Task No.", JobPlanningLineInvoice."Job Planning Line No.");
                JobPlanningLineInvoice.Delete();
                JobPlanningLine.UpdateQtyToTransfer();
                // Lines.SetRange("Job No.", SalesLine."Job No.");
                // Lines.SetRange("Job Task No.", SalesLine."Job Task No.");
                // Lines.SetRange(Date, JobPlanningLine."Document Date");
                // If Job.Get(JobPlanningLine."Job No.") Then If Job.Holiday Then exit;
                // If JobPlanningLine.Type <> JobPlanningLine.Type::Resource Then Exit;
                // If JobPlanningLine."Line Type" <> JobPlanningLine."Line Type"::Billable Then exit;
                // Lines.SetRange(Date, Calcdate('PM+1D-1M', JobPlanningLine."Planning Date"), CalcDate('PM', JobPlanningLine."Planning Date"));
                // Lines.SetRange("Unit Price", Lines."Unit Price");
                // Lines.SetRange("Resource No.", JobPlanningLine."No.");
                // Lines.SetRange(Invoiced, false);
                // Lines.ModifyAll(JobLine, 0);
                JobPlanningLine.Modify();
            until JobPlanningLineInvoice.Next() = 0;
        end else begin
            JobPlanningLine.SetRange("Job No.", SalesLine."Job No.");
            JobPlanningLine.SetRange("Job Task No.", SalesLine."Job Task No.");
            JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
            JobPlanningLine.SetRange("No.", SalesLine."No.");
            If JobPlanningLine.FindFirst() Then begin
                JobPlanningLineInvoice.SetRange("Job No.", JobPlanningLine."Job No.");
                JobPlanningLineInvoice.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
                JobPlanningLineInvoice.SetRange("Job Planning Line No.", JobPlanningLine."Line No.");
                If JobPlanningLine.Findset then
                    repeat
                        If (JobPlanningLineInvoice."Document No." = SalesLine."Document No.") and (JobPlanningLineInvoice."Document Type" = SalesLine."Document Type")
                        and (JobPlanningLineInvoice."Line No." = SalesLine."Line No.") Then
                            JobPlanningLineInvoice.Delete();

                    until JobPlanningLineInvoice.Next() = 0;
                JobPlanningLine.UpdateQtyToTransfer();
            end;

        end;
        //end;
        JobPlanningLine.SetRange("Job No.", SalesLine."Job No.");
        JobPlanningLine.SetRange("Job Task No.", SalesLine."Job Task No.");
        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
        JobPlanningLine.SetRange("No.", SalesLine."No.");
        if JobPlanningLine.FindFirst() then
            repeat
                if JobPlanningLine."Line Type" = JobPlanningLine."Line Type"::Billable Then begin
                    JobPlanningLine."Contract Line" := true;
                    JobPlanningLine.CalcFields("Qty. Transferred to Invoice");
                    JobPlanningLine.Validate("Qty. to Transfer to Invoice", JobPlanningLine.Quantity - JobPlanningLine."Qty. Invoiced" - JobPlanningLine."Qty. Transferred to Invoice");
                    JobPlanningLine.Modify();
                end;
            until JobPlanningLine.Next() = 0;
        Commit();
    end;


    procedure FindCostResourceEmployContract(var pHGWATimeSheetsLines: Record "HGWA TimeSheets Lines")
    var
        LinHisContractEmploy: Record "Lin Hist contrato empleado";
    begin
        LinHisContractEmploy.SetCurrentKey(Empleado, "Fecha Inicio");
        LinHisContractEmploy.SetRange(Empleado, pHGWATimeSheetsLines."Resource No.");
        LinHisContractEmploy.SetFilter("Fecha Inicio", '%1|<=%2', 0D, pHGWATimeSheetsLines.Date);
        IF LinHisContractEmploy.FindLast() then begin
            pHGWATimeSheetsLines.Validate("Cost of resources", LinHisContractEmploy.Coste);
            pHGWATimeSheetsLines.Validate("Unit Price", LinHisContractEmploy."Tarifa 1");
        end;
    end;


    procedure FestivoNACIONAL(fechaFestiva: Date): Boolean
    var
        CalendarioBaseChange: Record 7601;
        BalenCalendario: Record 7600;
        ConfSetupProyecto: Record "Jobs Setup";
    begin
        ConfSetupProyecto.Get();
        ConfSetupProyecto.TestField("Calendario Oficial");

        BalenCalendario.SetRange(Code, ConfSetupProyecto."Calendario Oficial");
        if BalenCalendario.FindFirst() then begin
            CalendarioBaseChange.SetRange(CalendarioBaseChange."Base Calendar Code", BalenCalendario.Code);
            CalendarioBaseChange.SetRange(Date, fechaFestiva);
            if CalendarioBaseChange.FindSet(true) then begin
                exit(CalendarioBaseChange.Nonworking)
            end else
                exit(false);
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    //  procedure OnBeforeOnInsert(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    procedure OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    var
        pag42: Page 43;
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            if SalesHeader."Posting Date" <= 20241231D then
                SalesHeader."Do Not Send To SII" := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidatePostingDateOnBeforeResetInvoiceDiscountValue', '', false, false)]
    procedure OnValidatePostingDateOnBeforeResetInvoiceDiscountValue(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            if SalesHeader."Posting Date" <= 20241231D then begin
                SalesHeader."Do Not Send To SII" := true;
            end else
                SalesHeader."Do Not Send To SII" := false;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidatePostingDate', '', false, false)]
    procedure OnBeforeValidatePostingDate(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::"Credit Memo"] then
            if SalesHeader."Posting Date" <= 20241231D then begin
                SalesHeader."Do Not Send To SII" := true;
            end else
                SalesHeader."Do Not Send To SII" := false;
    end;


    //OnBeforeValidatePostingDate
    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnBeforeValidatePostingDate', '', false, false)]
    procedure OnBeforeValidatePostingDateCompra(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] then
            if PurchaseHeader."Posting Date" <= 20241231D then begin
                PurchaseHeader."Do Not Send To SII" := true;
            end else
                PurchaseHeader."Do Not Send To SII" := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."Document Type" in [PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::"Credit Memo"] then
            if PurchHeader."Posting Date" <= 20241231D then begin
                PurchHeader."Do Not Send To SII" := true;
            end else
                PurchHeader."Do Not Send To SII" := false;
    end;

    /*
    OnValidatePostingDateOnBeforeResetInvoiceDiscountValue(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
    end;
    */
}
