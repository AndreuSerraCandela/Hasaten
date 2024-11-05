/// <summary>
/// PageExtension EmployeeListEx (ID 90110) extends Record Employee Card //5200.
/// </summary>
pageextension 90135 "EmployeeListEx" extends "Employee Card" //5200
{
    layout
    {
        addafter(Personal)
        {
            group(HASTEN)
            {
                group("Datos Academicos")
                {

                    field("Tipo Empleado"; Rec."Tipo Empleado")
                    {
                        ToolTip = 'Specifies the value of the Tipo Empleado field.';
                        ApplicationArea = All;
                    }
                    field(Perfil; Rec.Perfil)
                    {
                        ToolTip = 'Specifies the value of the Perfil field.';
                        ApplicationArea = All;
                    }
                    field(Departamento; Rec.Departamento)
                    {
                        ToolTip = 'Specifies the value of the Departamento field.';
                        ApplicationArea = All;
                    }
                }


                group("Otros Datos")
                {
                    field("Dias de Alta"; Rec."Dias de Alta")
                    {
                        ToolTip = 'Specifies the value of the Dias de Alta field.';
                        ApplicationArea = All;
                    }
                    field("Fin Asignacion"; Rec."Fin Asignacion")
                    {
                        ToolTip = 'Specifies the value of the Fin Asignacion field.';
                        ApplicationArea = All;
                    }
                    field("Fin Periodo de Prueba"; Rec."Fin Periodo de Prueba")
                    {
                        ToolTip = 'Specifies the value of the Fin Periodo de Prueba field.';
                        ApplicationArea = All;
                    }
                    field("Salario Año"; Rec."Salario Año")
                    {
                        ToolTip = 'Specifies the value of the Salario Año field.';
                        ApplicationArea = All;
                    }
                    field("Salario Total"; Rec."Salario Total")
                    {
                        ToolTip = 'Specifies the value of the Salario Total field.';
                        ApplicationArea = All;
                    }

                    field(Tarifa; Rec.Tarifa)
                    {
                        ToolTip = 'Specifies the value of the Tarifa field.';
                        ApplicationArea = All;
                    }

                }
            }
            group(Vacaciones)
            {
                field("Disponible Año Anterior"; Rec."Disponible Año Anterior")
                {
                    Caption = 'Disponible Año Anterior';
                    ToolTip = 'Specifies the value of the Disponible field.';
                    ApplicationArea = All;
                }
                field(Disponible; Rec.Disponible)
                {
                    ToolTip = 'Specifies the value of the Disponible field.';
                    ApplicationArea = All;
                }
                field(Servicio; Rec.Servicio)
                {
                    ToolTip = 'Specifies the value of the Servicio field.';
                    ApplicationArea = All;
                }
                field(Consumidas; Rec.Consumidas)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Consumidas field.';
                    ApplicationArea = All;
                }

                field("Por Consumir"; Rec."Por Consumir")
                {
                    ToolTip = 'Specifies the value of the Por Consumir field.';
                    ApplicationArea = All;
                }
                field("Vacaciones Anuales"; Rec."Vacaciones Anuales")
                {
                    ToolTip = 'Specifies the value of the Vacaciones Anuales field.';
                    ApplicationArea = All;
                }
            }

        }
        addlast(Personal)
        {
            field("Customer No."; Rec."Customer No.")
            {
                ToolTip = 'Specifies the value of the Customer No. field.';
                ApplicationArea = All;
            }
            field(DNI; Rec.DNI)
            {
                ToolTip = 'Specifies the value of the VAT Registration No. field.';
                ApplicationArea = All;
            }
            field(Edad; Rec.Edad)
            {
                ToolTip = 'Specifies the value of the Edad field.';
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addafter("Ledger E&ntries")
        {
            action("Hist. Contrato")
            {
                ApplicationArea = All;
                Image = ContractPayment;
                trigger OnAction()
                var
                    Hist: Record "Lin Hist contrato empleado";
                begin
                    Hist.SetRange(Empleado, Rec."No.");
                    Page.RunModal(page::"Hist contrato empleado", Hist);
                end;

            }
            action("Recalcula Vacaciones")
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

    var
        myInt: Integer;
}