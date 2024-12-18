pageextension 90137 BaseCalendarChanges extends "Base Calendar List" //7601
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("&Base Calendar")
        {
            action("Marcar Fines de Semana")
            {
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Clear(dlgDateTime);
                    Message('Introduzca el dia del año a tratar');
                    dlgDateTime.UseDateOnly();
                    if dlgDateTime.RunModal() = Action::OK then begin
                        Year := Format(dlgDateTime.GetDate(), 0, '<Year4>');
                        GenerarFindeAhno(Year);
                    end;
                end;
            }
        }


    }

    procedure GenerarFindeAhno(pYeah: Code[4])
    var
        iYear: Integer;
        fromDate: Date;
        newfromdate: Date;
        untilDate: Date;

        isHoliday: Boolean;
        iterDate: Date;
        BaseCalen: Record "Base Calendar";
        CtrolProcesos: Codeunit ControlDeProcesos;
    begin
        Evaluate(iYear, Format(pYeah).Split('-').Get(1));
        fromDate := DMY2Date(1, 1, iYear);
        untilDate := CALCDATE('<CM>', fromDate);
        untilDate := CALCDATE('<1Y>', fromDate);
        iterDate := fromDate;
        while fromDate <= untilDate do begin
            FindeSemana(fromDate, isHoliday);
            if isHoliday then
                UpdateCalendarioBase(fromDate, isHoliday);
            newfromdate := CalcDate('<1D>', fromDate);
            fromDate := newfromdate;
        END;


    end;

    procedure FindeSemana(var pdia: Date; var pfinesSemanaFestivo: Boolean): Boolean
    var
        myInt: Integer;
        iWeekDay: Integer;
    begin
        iWeekDay := Date2DWY(pdia, 1);
        if (iWeekDay = 6) or (iWeekDay = 7) then
            pfinesSemanaFestivo := true
        else
            pfinesSemanaFestivo := false;

    end;



    procedure UpdateCalendarioBase(fechaFestiva: Date; finde: Boolean)
    var
        CalendarioBaseChange: Record 7601;
        BalenCalendario: Record 7600;
    begin
        BalenCalendario.SetRange(Code, Rec.Code);
        if BalenCalendario.FindFirst() then begin
            CalendarioBaseChange.SetRange(CalendarioBaseChange."Base Calendar Code", BalenCalendario.Code);
            CalendarioBaseChange.SetRange(Date, fechaFestiva);
            if not CalendarioBaseChange.FindSet(true) then begin
                CalendarioBaseChange."Base Calendar Code" := BalenCalendario.Code;
                CalendarioBaseChange.Validate(Date, fechaFestiva);
                CalendarioBaseChange.Nonworking := finde;
                CalendarioBaseChange.Insert();
            end;
        end;

    end;

    var
        myInt: Integer;
        Base: Page 7601;
        Month: Code[20];
        Year: Code[4];
        dlgDateTime: Page "Date-Time Dialog";
}

/*
  Evaluate(iMonth, Format(pMonth).Split('-').Get(2));
        Evaluate(iYear, Format(pMonth).Split('-').Get(1));
        fromDate := DMY2Date(1, iMonth, iYear);
        untilDate := CALCDATE('<CM>', fromDate);
        iterDate := fromDate;


          //comprueba si el día es festivo o sin carga
            iWeekDay := Date2DWY(iterDate, 1);
            if (iWeekDay = 6) or (iWeekDay = 7) then
                isHoliday := true
            else
                isHoliday := false;
*/
