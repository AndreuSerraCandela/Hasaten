/// <summary>
/// TableExtension 90106.
/// </summary>
tableextension 90106 Empleado extends Employee
{
    fields
    {
        field(50000; "Tipo Empleado"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo Empleado';
            TableRelation = "Tipo Empleado";

        }
        field(50001; Perfil; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Perfil';
            TableRelation = Perfil;
        }
        field(50002; Departamento; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Departamento';
            TableRelation = Departamento;
        }
        field(50003; DNI; Text[20])
        {
            Caption = 'DNI';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin

                IsHandled := false;
                //  OnBeforeValidateVATRegistrationNo(Rec, xRec, CurrFieldNo, IsHandled);
                if IsHandled then
                    exit;
                /*
                                "VAT Registration No." := UpperCase("VAT Registration No.");
                                if "VAT Registration No." <> xRec."VAT Registration No." then
                                    VATRegistrationValidation();
                                    */

            end;
        }
        field(50004; "Salario Año"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Salario Año';
            Editable = false;
        }
        field(50005; "Salario Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Salario Total';
        }
        field(50006; Edad; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Edad';
        }
        field(50007; Tarifa; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tarifa';
            Editable = false;
        }
        field(50008; "Dias de Alta"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dias de Alta';
            Editable = false;
            trigger OnValidate()
            begin
                Calculavacaciones();
            end;
        }
        field(50009; "Fin Asignacion"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fin Asignacion';
            trigger OnValidate()
            begin
                Calculavacaciones();
            end;
        }
        field(50010; "Fin Periodo de Prueba"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fin Periodo de Prueba';
        }
        field(50011; "Customer No."; Code[20])
        {
            Caption = 'Cliente';
            // DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50012; "Vacaciones Anuales"; Decimal)
        {
            Caption = 'Vacaciones Anuales';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Calculavacaciones();
                //Validate(Disponible, "Vacaciones Anuales");
            end;
        }
        field(50013; Disponible; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disponible';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Calculavacaciones();

            end;
        }
        field(50014; Consumidas; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Consumidas';
            Editable = false;
            trigger OnValidate()
            var
            begin
                Calculavacaciones();

            end;
        }
        field(50015; "Por Consumir"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            Caption = 'Por Consumir';
        }
        field(50016; "Servicio"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Servicio';
        }
        field(50017; "Disponible Año Anterior"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disponible año anterior';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Calculavacaciones();

            end;
        }

        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                AnhoNacimiento: Integer;
                AnhoActual: Integer;

            begin

                AnhoNacimiento := Date2DMY("Birth Date", 3);
                AnhoActual := Date2DMY(Today, 3);
                Edad := abs(AnhoActual - AnhoNacimiento);

            end;
        }
        modify("Employment Date")
        {
            trigger OnAfterValidate()
            begin
                CalculaVacaciones();
            end;
        }
    }

    /// <summary>
    /// CalculaVacaciones.
    /// </summary>
    procedure CalculaVacaciones()
    var
        Bisiesto: Boolean;
        Dias: Integer;
        DiasAlta: Integer;
    begin
        If Rec."Employment Date" = 0D then begin
            Message('No puedo calcular las vacaciones si no se cuendo empieza y cuando termina');
            exit;
        end;
        If Rec."Vacaciones Anuales" = 0 Then Rec."Vacaciones Anuales" := 23;
        If Rec."Fin Asignacion" = 0D then Rec."Fin Asignacion" := Today;
        //=REDONDEAR.MAS((DIAS(C4;B4))*F4/366;0)
        Rec."Dias de Alta" := Rec."Fin Asignacion" - Rec."Employment Date";
        If Rec."Dias de Alta" > 365 Then Rec."Dias de Alta" := 365;
        Bisiesto := (Date2DMY(CalcDate('-1D', DMY2Date(1, 3, Date2DMY(Today, 3))), 1) = 29);
        If Bisiesto Then Dias := 365 else Dias := 365;
        If ("Dias de Alta" > 365) Or (Date2DMY(Rec."Employment Date", 3) < Date2DMY(Today, 3))
         Then
            DiasAlta := Dias else
            DiasAlta := Rec."Dias de Alta";
        Rec.Disponible := Round((DiasAlta * "Vacaciones Anuales") / Dias, 1, '>');
        "Por Consumir" := Disponible + "Disponible Año Anterior" - Consumidas;

    end;

    /* procedure VATRegistrationValidation()
     var
         VATRegistrationNoFormat: Record "VAT Registration No. Format";
         VATRegistrationLog: Record "VAT Registration Log";
         VATRegNoSrvConfig: Record "VAT Reg. No. Srv Config";
         VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
         ResultRecordRef: RecordRef;
         ApplicableCountryCode: Code[10];
         IsHandled: Boolean;
         LogNotVerified: Boolean;
     begin
         IsHandled := false;
         // OnBeforeVATRegistrationValidation(Rec, IsHandled);
         if IsHandled then
             exit;

         if not VATRegistrationNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", DATABASE::Customer) then
             exit;

         LogNotVerified := true;
         if ("Country/Region Code" <> '') or (VATRegistrationNoFormat."Country/Region Code" <> '') then begin
             ApplicableCountryCode := "Country/Region Code";
             if ApplicableCountryCode = '' then
                 ApplicableCountryCode := VATRegistrationNoFormat."Country/Region Code";
             if VATRegNoSrvConfig.VATRegNoSrvIsEnabled then begin
                 LogNotVerified := false;
                 VATRegistrationLogMgt.ValidateVATRegNoWithVIES(
                     ResultRecordRef, Rec, "No.", VATRegistrationLog."Account Type"::Customer.AsInteger(), ApplicableCountryCode);
                 ResultRecordRef.SetTable(Rec);
             end;
         end;

         // if LogNotVerified then
         //  VATRegistrationLogMgt.LogCustomer(Rec);
         //  VATRegistrationLogMgt.
     end;
 */

}