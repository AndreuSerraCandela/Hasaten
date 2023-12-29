/// <summary>
/// Page Plazos recursos reservados (ID 50022).
/// </summary>
page 90120 "Horas recursos"
{
    Caption = 'Horas recurso';
    SaveValues = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    LinksAllowed = false;
    SourceTable = Resource;
    PageType = ListPlus;
    UsageCategory = Tasks;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            Group("Opciones matriz")
            {
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = all;
                    Caption = 'Ver por';
                    ToolTip = 'Especifica para qué periodos se muestran';
                    //OptionCaption = 'Día,Semana,Mes';

                    trigger OnValidate()
                    BEGIN
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                        UpdateMatrixSubPage2;
                    END;
                }

                field(Desde; Desde)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    BEGIN
                        //vlrangel
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                        UpdateMatrixSubPage2;
                    End;
                }
                field(Hasta; Hasta)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    BEGIN
                        //vlrangel
                        SetColumns(SetWanted::Initial);
                        UpdateMatrixSubPage;
                        UpdateMatrixSubPage2;
                    End;

                }

                field(Nombre; Nombre)
                {
                    ShowCaption = false;
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            Part(Matrix; "Recursos Matrix")
            {
                ApplicationArea = all;

            }

        }
    }

    actions

    {
        area(Navigation)
        {
            action("Previous Set")
            {
                Caption = 'Conjunto anterior';
                ToolTip = 'Permite desplazarse al conjunto de datos anterior.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = PreviousSet;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::Previous);
                    UpdateMatrixSubPage;
                END;
            }
            action("Previous Column")
            {
                Caption = 'Columna anterior';
                ToolTip = 'Permite desplazarse a la columna anterior.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = PreviousRecord;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::PreviousColumn);
                    UpdateMatrixSubPage;
                END;
            }
            action("Next Column")
            {
                Caption = 'Columna siguiente';
                ToolTip = 'Permite desplazarse a la columna siguiente.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = NextRecord;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::NextColumn);
                    UpdateMatrixSubPage;
                END;
            }
            action("Next Set")
            {
                Caption = 'Conjunto siguiente';
                ToolTip = 'Permite desplazarse al conjunto de datos siguiente.';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = NextSet;
                PromotedCategory = Process;
                trigger OnAction()
                BEGIN
                    SetColumns(SetWanted::Next);
                    UpdateMatrixSubPage;
                END;
            }
            action("Cargar Matrix")
            {
                ApplicationArea = All;
                Image = ShowMatrix;

                trigger OnAction()
                begin
                    CargarMatrix();
                end;
            }

        }
    }
    VAR
        Lunes: Boolean;
        Martes: Boolean;
        Miercoles: Boolean;
        Jueves: Boolean;
        Viernes: Boolean;
        Sabado: Boolean;
        Domingo: Boolean;
        Contratos: Option "Pendiente de Firma",Firmado,Anulado,Cancelado,"Sin Montar","Sin Contrato","Con Contrato","Todos";// Enum "Filtro Estado Contrato";
        MatrixRecords: ARRAY[32] OF Record 2000000007;
        PeriodType: Enum "Analysis Period Type";
        MatrixColumnCaptions: ARRAY[32] OF Text[1024];
        ColumnSet: Text[1024];
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;
        Nombre: Text;
        Fzona: Text;
        FDzona: Text;
        Familia: Text;
        Tipus: Text;
        rRecurs: Record Resource;
        Desde: Date;
        Hasta: Date;
        Recurso: Record Resource temporary;
        InicioReserva: Date;
        FinReserva: Date;

    trigger OnOpenPage()
    BEGIN


    END;

    trigger OnAfterGetRecord()
    begin

    end;


    PROCEDURE SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn);
    VAR
        MatrixMgt: Codeunit 9200;
    BEGIN
        if (Desde <> 0D) And (Hasta = 0D) Then Hasta := Desde;
        If (Desde <> 0D) and (Hasta <> 0D) Then If Hasta < Desde Then Hasta := Desde;
        If (Desde = 0D) Or (Hasta = 0D) Then begin
            MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, FALSE, PeriodType, '',
              PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
            Rec.SetRange("Date Filter")
        end else begin
            Rec.SetRange("Date Filter", Desde, Hasta);
            MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, FALSE, PeriodType, Rec.GetFilter("Date Filter"),
              PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
        End;

    END;

    procedure UpdateMatrixSubPage2()
    var
        myInt: Integer;
    begin
        CurrPage.Matrix.PAGE.CalcLine();
    end;

    LOCAL PROCEDURE UpdateMatrixSubPage();
    BEGIN
        If Lunes Then begin
            Martes := false;
            Miercoles := false;
            Jueves := false;
            Viernes := false;
            Sabado := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Martes Then begin
            Lunes := false;
            Miercoles := false;
            Jueves := false;
            Viernes := false;
            Sabado := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Miercoles Then begin
            Martes := false;
            Lunes := false;
            Jueves := false;
            Viernes := false;
            Sabado := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Jueves Then begin
            Martes := false;
            Miercoles := false;
            Lunes := false;
            Viernes := false;
            Sabado := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Viernes Then begin
            Martes := false;
            Miercoles := false;
            Jueves := false;
            Lunes := false;
            Sabado := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Sabado Then begin
            Martes := false;
            Miercoles := false;
            Jueves := false;
            Viernes := false;
            Lunes := false;
            Domingo := false;
            PeriodType := PeriodType::Week;
        end;
        If Domingo Then begin
            Martes := false;
            Miercoles := false;
            Jueves := false;
            Viernes := false;
            Sabado := false;
            Lunes := false;
            PeriodType := PeriodType::Week;
        end;
        CurrPage.Matrix.PAGE.Load(PeriodType, MatrixColumnCaptions,
        MatrixRecords, CurrSetLength, Tipus, Fzona, Familia, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo);
        CurrPage.UPDATE(FALSE);
    END;


    procedure CargarMatrix()
    var
        myInt: Integer;
    begin
        Rec.RESET;
        Rec.SETRANGE("No.", rRecurs."No.");

        IF Rec.FIND('-') THEN;
        SetColumns(SetWanted::Initial);
        UpdateMatrixSubPage;
        UpdateMatrixSubPage2;
    end;

}