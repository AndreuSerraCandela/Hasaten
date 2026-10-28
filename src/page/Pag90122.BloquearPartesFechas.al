page 90122 "Bloquear Partes Fechas"
{
    PageType = StandardDialog;
    Caption = 'Bloquear partes por fechas';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Rango';
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha desde';
                    ToolTip = 'Primera fecha del rango a bloquear o desbloquear.';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha hasta';
                    ToolTip = 'Última fecha del rango a bloquear o desbloquear.';
                }
                field(Bloquear; Bloquear)
                {
                    ApplicationArea = All;
                    Caption = 'Bloquear';
                    ToolTip = 'Si está marcado, bloquea las líneas. Si no, las desbloquea.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        FromDate := CalcDate('<-CM>', WorkDate());
        ToDate := CalcDate('<CM>', WorkDate());
        Bloquear := true;
    end;

    procedure GetParams(var pFromDate: Date; var pToDate: Date; var pBloquear: Boolean)
    begin
        pFromDate := FromDate;
        pToDate := ToDate;
        pBloquear := Bloquear;
    end;

    var
        FromDate: Date;
        ToDate: Date;
        Bloquear: Boolean;
}
