/// <summary>
/// Page Hist contrato empleado (ID 50159).
/// </summary>
page 90139 "Hist contrato empleado"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Lin Hist contrato empleado";
    PopulateAllFields = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;

                }

                field(Empleado; Rec.Empleado)
                {
                    ApplicationArea = All;

                }


                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;

                }
                field("Fecha Fin"; Rec."Fecha Fin")
                {
                    ApplicationArea = All;

                }
                field(Proyecto; Rec.Proyecto)
                {
                    ApplicationArea = All;

                }
                field(CustomerName; CustTomer('Name'))
                {
                    ApplicationArea = All;
                }
                field(CustomerNo; CustTomer('No'))
                {
                    ApplicationArea = All;
                }
                field("Tarifa 1"; Rec."Tarifa 1")
                {
                    ApplicationArea = All;

                }
                field("Tarifa 2"; Rec."Tarifa 2")
                {
                    ApplicationArea = All;

                }
                field(Coste; Rec.Coste)
                {
                    ToolTip = 'Specifies the value of the Coste field.';
                }
                field(Beneficio; Rec.Beneficio)
                {
                    ToolTip = 'Specifies the value of the Bº field.';
                }
                field("Salario Año"; Rec."Salario Año")
                {
                    ApplicationArea = All;
                }
                field("Tarifa Actúal"; Rec."Tarifa Actúal")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRex: boolean)

    begin
        Rec.Codigo := IncStr(xRec.Codigo);
        if Rec.Codigo = '' then Rec.Codigo := '1';
    end;

    local procedure CustTomer(arg: Text): Text
    var
        Cust: Record 18;
        Job: Record Job;
    begin
        If Job.Get(Rec.Proyecto) then
            If Cust.Get(Job."Bill-to Customer No.") Then begin
                Case arg of
                    'Name':
                        exit(Cust.Name);
                    'No':
                        exit(Cust."No.");
                End;
            end;
    end;
}