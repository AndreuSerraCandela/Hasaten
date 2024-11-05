/// <summary>
/// PageExtension EmployeeList (ID 90102) extends Record Employee List //5201.
/// </summary>
pageextension 90136 "EmployeeList" extends "Employee List" //5201
{
    layout
    {
        addlast(Control1)
        {

            field(Address; Rec.Address)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s address.';
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies additional address information.';
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the city of the address.';
            }
            field("Birth Date"; Rec."Birth Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s date of birth.';
            }


            field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
            }

            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s email address at the company.';
            }
            field(Consumidas; Rec.Consumidas)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumidas field.';
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the county of the employee.';
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer No. field.';
            }
            field(Gender; Rec.Gender)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s gender.';
            }
            field(DNI; Rec.DNI)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Registration No. field.';
            }
            field(Edad; Rec.Edad)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Edad field.';
            }
            field(Departamento; Rec.Departamento)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Departamento field.';
            }
            field("Dias de Alta"; Rec."Dias de Alta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dias de Alta field.';
            }
            field(Disponible; Rec.Disponible)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Disponible field.';
            }

            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the employee began to work for the company.';
            }
            field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employment contract code for the employee.';
            }
            field(IBAN; Rec.IBAN)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bank account''s international bank account number.';
            }
            field(Perfil; Rec.Perfil)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Perfil field.';
            }
            field(Pager; Rec.Pager)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employee''s pager number.';
            }
            field("Por Consumir"; Rec."Por Consumir")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Por Consumir field.';
            }

            field("Salario Año"; Rec."Salario Año")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salario Año field.';
            }
            field(Servicio; Rec.Servicio)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Servicio field.';
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the employment status of the employee.';
            }
            field("Salario Total"; Rec."Salario Total")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salario Total field.';
            }
            field(Tarifa; Rec.Tarifa)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tarifa field.';
            }
            field("Tipo Empleado"; Rec."Tipo Empleado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tipo Empleado field.';
            }
            field(Title; Rec.Title)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Title field.';
            }
            field("Termination Date"; Rec."Termination Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
            }
            field("Vacaciones Anuales"; Rec."Vacaciones Anuales")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vacaciones Anuales field.';
            }
            field("SWIFT Code"; Rec."SWIFT Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                Visible = false;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}