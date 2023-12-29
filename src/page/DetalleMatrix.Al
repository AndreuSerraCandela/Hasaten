/// <summary>
/// Page Recursos Matrix (ID 90121).
/// </summary>
page 90121 "Recursos Matrix"
{
    Caption = 'Lineas partes Horas Matrix';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Resource by Job Buffer";
    SourceTableTemporary = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."Resource No.")
                {
                    StyleExpr = "Seleccionado";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Nombre; Rec."Resource Name")

                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the resource.';
                }
                field(Capacidad; Rec.Capacidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capacidad field.';
                    DecimalPlaces = 2 : 2;
                }
                field("Horas L"; Rec."Horas L")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capacidad field.';
                    DecimalPlaces = 2 : 2;
                    Caption = 'Horas';
                }
                field(Horas; Rec.Horas)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Horas Totales field.';
                    Caption = 'Total Horas';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Importe field.';
                }



                //Desviacion
                field(Desviacion; rec.Desviacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Capacidad Recurso field.';
                    DecimalPlaces = 2 : 2;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job  No. field.';
                }
                field("Unit Price"; Rec.Tarifa)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    DecimalPlaces = 2 : 2;
                }






                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    StyleExpr = Color1;
                    DecimalPlaces = 2 : 2;

                    trigger OnDrillDown()
                    begin
                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(1)
                        end else
                            MatrixOnDrillDownVacaciones(1);
                    end;

                    trigger OnValidate()
                    begin
                        //  ValidateCapacity(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    StyleExpr = Color2;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(2)
                        end else
                            MatrixOnDrillDownVacaciones(2);
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    StyleExpr = Color3;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin

                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(3)
                        end else
                            MatrixOnDrillDownVacaciones(3);
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    StyleExpr = Color4;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(4)
                        end else
                            MatrixOnDrillDownVacaciones(4);
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    StyleExpr = Color5;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(5)
                        end else
                            MatrixOnDrillDownVacaciones(5);
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    StyleExpr = Color6;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        if not JobVacaciones(rec."Job No.") then begin
                            MatrixOnDrillDown(6)
                        end else
                            MatrixOnDrillDownVacaciones(6);
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    StyleExpr = Color7;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    StyleExpr = Color8;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    StyleExpr = Color9;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    StyleExpr = Color10;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    StyleExpr = Color11;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    StyleExpr = Color12;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    StyleExpr = Color13;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    StyleExpr = Color14;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    StyleExpr = Color15;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    StyleExpr = Color16;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    StyleExpr = Color17;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    StyleExpr = Color18;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    StyleExpr = Color19;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    StyleExpr = Color20;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(20)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(22);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    StyleExpr = Color21;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(21)
                    end;

                    trigger OnValidate()
                    begin
                        //ValidateCapacity(22);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    StyleExpr = Color22;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(22)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    StyleExpr = Color23;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(23)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    StyleExpr = Color24;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(24)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    StyleExpr = Color25;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    StyleExpr = Color26;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(26)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    StyleExpr = Color27;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    StyleExpr = Color28;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(28)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    StyleExpr = Color29;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    StyleExpr = Color30;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    StyleExpr = Color31;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(31)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    StyleExpr = Color32;
                    DecimalPlaces = 2 : 2;
                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(32)
                    end;

                    trigger OnValidate()
                    begin
                        // ValidateCapacity(32);
                    end;
                }
            }

        }

    }
    actions
    {

    }

    VAR
        GestionPagePeriodo: Codeunit PeriodPageManagement;
        Fecha: Record Date;
        TipoPeriodo: Enum "Analysis Period Type";//Option Día,Semana,Mes;

        rProy: Record 167;
        rRecurs: Record 156;
        Nom: Text[100];
        Familia: Code[20];
        Tipus: Code[10];
        Color1: Text;
        Color2: Text;
        Color3: Text;
        Color4: Text;
        Color5: Text;
        Color6: Text;
        Color7: Text;
        Color8: Text;
        Color9: Text;
        Color10: Text;
        Color11: Text;
        Color12: Text;
        Color13: Text;
        Color14: Text;
        Color15: Text;
        Color16: Text;
        Color17: Text;
        Color18: Text;
        Color19: Text;
        Color20: Text;
        Color21: Text;
        Color22: Text;
        Color23: Text;
        Color24: Text;
        Color25: Text;
        Color26: Text;
        Color27: Text;
        Color28: Text;
        Color29: Text;
        Color30: Text;
        Color31: Text;
        Color32: Text;


        Fzona: Code[20];
        MATRIX_CellData: array[32] of Decimal;
        MatrixRecords: ARRAY[32] OF Record 2000000007;
        FechaInicio: Date;
        FechaFin: Date;
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_ColumnCaption: ARRAY[32] of Text[1024];
        Recurso: Record Resource temporary;
        InicioReserva: Date;
        FinReserva: Date;
        "Seleccionado": Code[20];
        MATRIX_CurrentColumnOrdinal: Integer;


    trigger OnOpenPage()
    begin
        rec.Reset();
    end;

    trigger OnAfterGetRecord()
    var

    begin

        MATRIX_CurrentColumnOrdinal := 0;
        WHILE MATRIX_CurrentColumnOrdinal < MATRIX_NoOfMatrixColumns DO BEGIN
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            if DateRec.Get(rec."Period Type"::Day, MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start") then;

        END;



    end;

    procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        if not JobVacaciones(Rec."Job No.") then begin
            MATRIX_CellData[ColumnID] := Trae_Cantidad(MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End", ColumnID);
        end else
            MATRIX_CellData[ColumnID] := Trae_CantidadVacaciones(MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End", ColumnID);
    end;





    procedure Fechas(pInicio: Date; pFin: Date);
    begin
        InicioReserva := pInicio;
        FinReserva := pFin;
    end;

    procedure Recursos(var pRecurso: Record Resource temporary);
    begin
        If Recurso.FindFirst() Then
            Repeat
                pRecurso := Recurso;
                If pRecurso.Insert() Then;
            until Recurso.Next() = 0;

    end;

    procedure CalcLine()
    var
        LineasHora: Record "HGWA TimeSheets Lines";
        LineasTemporal: Record "Resource by Job Buffer" temporary;
        RCapacidad: Record "Res. Capacity Entry";
        pRecursoCode: Code[20];
        pProyecto: Code[20];
        pTarifa: Decimal;
        rRecurso: Record Resource;
        RRRecuros: Record Resource;
        R_Proyecto: Record job;
        RCapVacaciones: Record "Res. Capacity Entry";
    begin


        rec.Reset();
        LineasHora.SetFilter(Date, '%1..%2', MatrixRecords[1]."Period Start", MatrixRecords[MATRIX_NoOfMatrixColumns]."Period End");
        if LineasHora.FindFirst() then begin
            repeat
                if (LineasHora."Job No." <> pProyecto) or (pProyecto = '')
                    and (LineasHora."Unit Price" <> pTarifa) or (pTarifa = 0)
                    and (LineasHora."Resource No." <> pRecursoCode) or (pRecursoCode = '')
                then begin
                    pProyecto := LineasHora."Job No.";
                    pTarifa := LineasHora."Unit Price";
                    pRecursoCode := LineasHora."Resource No.";

                    //  if not JobVacaciones(pProyecto) then begin

                    LineasTemporal.SetRange(LineasTemporal."Resource No.", pRecursoCode);
                    LineasTemporal.SetRange(LineasTemporal."Job No.", pProyecto);
                    LineasTemporal.SetRange(LineasTemporal.Tarifa, pTarifa);
                    if not LineasTemporal.FindFirst() then begin
                        rec."Resource No." := LineasHora."Resource No.";

                        Clear(rRecurso);
                        rRecurso.SetRange(rRecurso."No.", LineasHora."Resource No.");
                        rRecurso.SetFilter("Date Filter", '%1..%2', MatrixRecords[1]."Period Start", MatrixRecords[MATRIX_NoOfMatrixColumns]."Period End");
                        IF rRecurso.FindFirst() THEN
                            rRecurso.CalcFields(Capacity);
                        rec."Resource Name" := rRecurso.Name;
                        rec."Job No." := LineasHora."Job No.";

                        rec.Tarifa := LineasHora."Unit Price";
                        rec.Capacidad := rRecurso.Capacity;

                        // calcula horas L
                        RRRecuros.Reset();
                        RRRecuros.SetRange(RRRecuros."No.", LineasHora."Resource No.");
                        RRRecuros.SetRange(RRRecuros."Job Filter", LineasHora."Job No.");
                        RRRecuros.SetRange(RRRecuros.Tarifa, LineasHora."Unit Price");
                        RRRecuros.SetFilter(RRRecuros."Date Filter", '%1..%2', MatrixRecords[1]."Period Start", MatrixRecords[MATRIX_NoOfMatrixColumns]."Period End");
                        if RRRecuros.FindFirst() then
                            RRRecuros.CalcFields("Capacity Word");

                        // CAPACIDAD
                        rec."Horas L" := RRRecuros."Capacity Word";

                        // horas total
                        RRRecuros.Reset();
                        RRRecuros.SetRange(RRRecuros."No.", LineasHora."Resource No.");
                        RRRecuros.SetFilter(RRRecuros."Date Filter", '%1..%2', MatrixRecords[1]."Period Start", MatrixRecords[MATRIX_NoOfMatrixColumns]."Period End");
                        if RRRecuros.FindFirst() then
                            RRRecuros.CalcFields("Capacity Word");

                        Rec.Horas := RRRecuros."Capacity Word";

                        Rec.Desviacion := rec.Capacidad - rec.Horas;

                        rec.Importe := rec."Horas L" * rec.Tarifa;
                        if NOT REC.Insert() then;
                    end;
                    /* end else begin
                         RRRecuros.Reset();
                         RRRecuros.SetRange(RRRecuros."No.", LineasHora."Resource No.");
                         RRRecuros.SetRange(RRRecuros."Job Filter", LineasHora."Job No.");
                         //  RRRecuros.SetRange(RRRecuros.Tarifa, LineasHora."Unit Price");
                         RRRecuros.SetFilter(RRRecuros."Date Filter", '%1..%2', MatrixRecords[1]."Period Start", MatrixRecords[MATRIX_NoOfMatrixColumns]."Period End");
                         if RRRecuros.FindFirst() then
                             RCapVacaciones.SetRange("Resource No.", LineasHora."Resource No.");
                         RCapVacaciones.setrange(Date, LineasHora.Date);
                         if RCapVacaciones.FindFirst() then begin

                             // CAPACIDAD
                             rec."Horas L" += RCapVacaciones.Capacity;
                             if NOT REC.Insert() then
                                 rec.Modify();
                         end;
                     end;
 */

                end;
            until LineasHora.Next = 0;
        end;


    end;

    PROCEDURE Trae_Cantidad(Desde: Date; Hasta: Date; ColumnID: Integer): Decimal;
    var
        Dias: Integer;

        rDia: Record "HGWA TimeSheets Lines";
    BEGIN
        If Lunes Then begin
            Desde := DWY2Date(1, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Martes Then begin
            Desde := DWY2Date(2, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Miercoles Then begin
            Desde := DWY2Date(3, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Jueves Then begin
            Desde := DWY2Date(4, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Viernes Then begin
            Desde := DWY2Date(5, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Sabado Then begin
            Desde := DWY2Date(6, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Domingo Then begin
            Desde := DWY2Date(7, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;



        Case ColumnId Of
            1:
                Color1 := '';
            2:
                Color2 := '';
            3:
                Color3 := '';
            4:
                Color4 := '';
            5:
                Color5 := '';
            6:
                Color6 := '';
            7:
                Color7 := '';
            8:
                Color8 := '';
            9:
                Color9 := '';
            10:
                Color10 := '';
            11:
                Color11 := '';
            12:
                Color12 := '';
            13:
                Color13 := '';
            14:
                Color14 := '';
            15:
                Color15 := '';
            16:
                Color16 := '';
            17:
                Color17 := '';
            18:
                Color18 := '';
            19:
                Color19 := '';
            20:
                Color20 := '';
            21:
                Color21 := '';
            22:
                Color22 := '';
            23:
                Color23 := '';
            24:
                Color24 := '';
            25:
                Color25 := '';
            26:
                Color26 := '';
            27:
                Color27 := '';
            28:
                Color28 := '';
            29:
                Color29 := '';
            30:
                Color30 := '';
            31:
                Color31 := '';
            32:
                Color32 := '';

        End;

        CLEAR(rDia);
        rDia.SETRANGE(rDia."Resource No.", Rec."Resource No.");
        rDia.SETRANGE(rDia.Date, Desde, Hasta);
        rDia.SetRange(rDia."Job No.", Rec."Job No.");
        rDia.SetRange(rDia."Unit Price", REC.Tarifa);
        IF rDia.FIND('-') THEN Begin
            rDia.Calcsums(rDia.Hours);
            EXIT(rdia.Hours);
        END;

    END;


    PROCEDURE Trae_CantidadVacaciones(Desde: Date; Hasta: Date; ColumnID: Integer): Decimal;
    var
        Dias: Integer;

        rDia: Record "HGWA TimeSheets Lines";
        VacacionesCdadDia: Decimal;

    BEGIN
        If Lunes Then begin
            Desde := DWY2Date(1, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Martes Then begin
            Desde := DWY2Date(2, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Miercoles Then begin
            Desde := DWY2Date(3, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Jueves Then begin
            Desde := DWY2Date(4, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Viernes Then begin
            Desde := DWY2Date(5, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Sabado Then begin
            Desde := DWY2Date(6, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Domingo Then begin
            Desde := DWY2Date(7, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;

        CLEAR(rDia);
        rDia.SETRANGE(rDia."Resource No.", Rec."Resource No.");
        rDia.SETRANGE(rDia.Date, Desde, Hasta);
        rDia.SetRange(rDia."Job No.", Rec."Job No.");
        rDia.SetRange(rDia."Unit Price", REC.Tarifa);
        VacacionesCdadDia := rDia.Count;
        if VacacionesCdadDia = 1 then begin
            Clear(RvacacionesCap);
            RvacacionesCap.SetRange(RvacacionesCap."Resource No.", Rec."Resource No.");
            RvacacionesCap.SetRange(RvacacionesCap.Date, Desde, Hasta);
            if RvacacionesCap.FindFirst() then
                VacacionesCdadDia := RvacacionesCap.Capacity;



            if VacacionesCdadDia <> 0 then begin

                Case ColumnId Of
                    1:
                        Color1 := 'Favorable';
                    2:
                        Color2 := 'Favorable';
                    3:
                        Color3 := 'Favorable';
                    4:
                        Color4 := 'Favorable';
                    5:
                        Color5 := 'Favorable';
                    6:
                        Color6 := 'Favorable';
                    7:
                        Color7 := 'Favorable';
                    8:
                        Color8 := 'Favorable';
                    9:
                        Color9 := 'Favorable';
                    10:
                        Color10 := 'Favorable';
                    11:
                        Color11 := 'Favorable';
                    12:
                        Color12 := 'Favorable';
                    13:
                        Color13 := 'Favorable';
                    14:
                        Color14 := 'Favorable';
                    15:
                        Color15 := 'Favorable';
                    16:
                        Color16 := 'Favorable';
                    17:
                        Color17 := 'Favorable';
                    18:
                        Color18 := 'Favorable';
                    19:
                        Color19 := 'Favorable';
                    20:
                        Color20 := 'Favorable';
                    21:
                        Color21 := 'Favorable';
                    22:
                        Color22 := 'Favorable';
                    23:
                        Color23 := 'Favorable';
                    24:
                        Color24 := 'Favorable';
                    25:
                        Color25 := 'Favorable';
                    26:
                        Color26 := 'Favorable';
                    27:
                        Color27 := 'Favorable';
                    28:
                        Color28 := 'Favorable';
                    29:
                        Color29 := 'Favorable';
                    30:
                        Color30 := 'Favorable';
                    31:
                        Color31 := 'Favorable';
                    32:
                        Color32 := 'Favorable';

                End;
            end;
        end;
        exit(VacacionesCdadDia);
    END;




    Procedure Load(PeriodType: Enum "Analysis Period Type"; MatrixColumns1: ARRAY[32] OF Text[1024];
                                   MatrixRecords1: ARRAY[32] OF Record 2000000007;
                                   NoOfMatrixColumns1: Integer
    ;
                                   Tipo: Text;
                                   fzona: Text;
                                   PFamilia: Text;
                                   pLunes: Boolean;
                                   pMartes: Boolean;
                                   pMiercoles: Boolean;
                                   pJueves: Boolean;
                                   pViernes: Boolean;
                                   pSabado: Boolean;
                                   pDomingo: Boolean)

    var
        i: Integer;
    Begin
        Lunes := pLunes;
        Martes := pMartes;
        Miercoles := pMiercoles;
        Jueves := pJueves;
        Viernes := pViernes;
        Sabado := pSabado;
        Domingo := pDomingo;
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);

        FOR i := 1 TO ARRAYLEN(MatrixRecords) DO
            MatrixRecords[i].COPY(MatrixRecords1[i]);
        MATRIX_NoOfMatrixColumns := NoOfMatrixColumns1;

        //**
        Evaluate(FechaInicio, (MatrixColumns1[1]));
        Evaluate(FechaFin, MatrixColumns1[ARRAYLEN(MatrixRecords)]);
        //**

        CurrPage.Update(false);
    End;





    procedure MatrixOnDrillDown(i: Integer)
    begin
        DrilDown(MatrixRecords[i]."Period Start", MatrixRecords[i]."Period End");

    end;

    procedure MatrixOnDrillDownVacaciones(i: Integer)
    begin
        DrilDownVacaciones(MatrixRecords[i]."Period Start", MatrixRecords[i]."Period End");

    end;

    procedure JobVacaciones(pProyecto: Code[20]): Boolean
    var
        pJob: Record Job;
    begin
        if pJob.Get(pProyecto) then begin
            if pJob.Holiday = true then begin
                exit(true);
            end else
                exit(false);
        end;
    end;


    PROCEDURE DrilDown(Desde: Date; Hasta: Date)
    var
        Dias: Integer;
        Nombre: Text;
        LineaPartesHoras: Page LineasPartesWeb;

    Begin
        If Lunes Then begin
            Desde := DWY2Date(1, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Martes Then begin
            Desde := DWY2Date(2, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Miercoles Then begin
            Desde := DWY2Date(3, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Jueves Then begin
            Desde := DWY2Date(4, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Viernes Then begin
            Desde := DWY2Date(5, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Sabado Then begin
            Desde := DWY2Date(6, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Domingo Then begin
            Desde := DWY2Date(7, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;

        CLEAR(rDia);
        rDia.SETRANGE(rDia."Resource No.", Rec."Resource No.");
        rDia.SETRANGE(rDia.Date, Desde, Hasta);
        rDia.SetRange(rDia."Job No.", Rec."Job No.");
        rDia.SetRange(rDia."Unit Price", REC.Tarifa);
        IF rDia.FIND('-') THEN Begin
            LineaPartesHoras.SetRecord(rDia);
            LineaPartesHoras.SetTableView(rDia);
            LineaPartesHoras.LookupMode(true);
            IF LineaPartesHoras.RUNMODAL = ACTION::OK then
                CurrPage.Update(true);
        end;

        //Page.Runmodal(50256, rDia);
    end;



    PROCEDURE DrilDownVacaciones(Desde: Date; Hasta: Date)
    var
        Dias: Integer;
        Nombre: Text;
        vacaciones: Decimal;
        RvacacionesCap: Record "Res. Capacity Entry";

    Begin
        If Lunes Then begin
            Desde := DWY2Date(1, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Martes Then begin
            Desde := DWY2Date(2, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Miercoles Then begin
            Desde := DWY2Date(3, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Jueves Then begin
            Desde := DWY2Date(4, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Viernes Then begin
            Desde := DWY2Date(5, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Sabado Then begin
            Desde := DWY2Date(6, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        If Domingo Then begin
            Desde := DWY2Date(7, Date2DWY(Desde, 2), Date2DWY(Desde, 3));
            Hasta := CalcDate('6D', Desde);
        end;
        /*
        CLEAR(rDia);
        rDia.SETRANGE(rDia."Resource No.", Rec."Resource No.");
        rDia.SETRANGE(rDia.Date, Desde, Hasta);
        rDia.SetRange(rDia."Job No.", Rec."Job No.");
        rDia.SetRange(rDia."Unit Price", REC.Tarifa);
        vacaciones := rDia.Count;
*/
        Clear(RvacacionesCap);
        RvacacionesCap.SetRange("Resource No.", Rec."Resource No.");
        RvacacionesCap.SetRange(Date, Desde, Hasta);
        if RvacacionesCap.FindFirst() then
            Page.RunModal(224, RvacacionesCap);
        //    Page.Runmodal(50256, rDia);

    End;


    var
        Lunes: Boolean;
        Martes: Boolean;
        Miercoles: Boolean;
        Jueves: Boolean;
        Viernes: Boolean;
        Sabado: Boolean;
        Domingo: Boolean;
        rDia: Record "HGWA TimeSheets Lines";
        DateRec: Record Date;
        Desviacion: Decimal;
        RvacacionesCap: Record "Res. Capacity Entry";

}