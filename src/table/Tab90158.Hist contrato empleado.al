/// <summary>
/// Table Hist contrato empleado (ID 50159).
/// </summary>
table 90158 "Lin Hist contrato empleado"
{
    Caption = 'Hist contrato empleado';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Empleado; Code[20])
        {
            TableRelation = Employee;
            DataClassification = ToBeClassified;
        }


        field(3; Descripcion; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Fecha Inicio"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Fecha Fin"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Proyecto; Code[20])
        {
            TableRelation = Job;
            DataClassification = ToBeClassified;
        }


        field(7; "Tarifa 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Tarifa 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Salario Año"; Decimal)
        { }
        field(10; "Tarifa Actúal"; Boolean)
        {
            trigger OnValidate()
            var
                HistContr: Record "Lin Hist contrato empleado";
                Rrecurso: Record Resource;
            begin
                HistContr.SetRange(Empleado, rec.Empleado);
                HistContr.SetRange("Tarifa Actúal", true);
                if HistContr.FindFirst() then begin
                    HistContr."Tarifa Actúal" := false;
                    HistContr.Modify();
                end;
                Rrecurso.SetRange("No.", rec.Empleado);
                if Rrecurso.FindFirst() then begin
                    Rrecurso."Sales (Price)" := rec."Tarifa 1";
                    Rrecurso.validate("Unit Cost", rec.Coste);
                    Rrecurso.Modify(true);
                end;
            end;
        }
        field(20; Coste; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Setup: Record "General Ledger Setup";
            begin
                //"% Benefic" := Round((rec.Benefic / rec.Sales) / 100, Setup."Unit-Amount Rounding Precision") * 100;
                //"% Benefic" := ("% Benefic" * 100);

                if ("Tarifa 1" <> 0) and (Coste <> 0) then begin
                    //  Beneficio := (("Tarifa 1" - Coste) / "Tarifa 1");
                    Beneficio := Round((("Tarifa 1" - Coste) / "Tarifa 1") / 100, Setup."Unit-Amount Rounding Precision") * 100;
                    Beneficio := (Beneficio * 100);
                end else
                    Beneficio := 0;

            end;

        }
        field(21; Beneficio; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '% Bº';
            //funcionalidad: calculo: Bf:= (tarifa1-coste)/tarifa1.
        }
    }

    keys
    {
        key(Key1; Codigo, Empleado)
        {
            Clustered = true;
        }
        key(Key2; Empleado, "Fecha Inicio") { }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        rEmpl: Record Employee;
        rRes: Record Resource;
        JSetup: Record "Jobs Setup";
        Cust: Record 18;
        Job: Record Job;
    begin
        JSetup.Get();
        If rEmpl.Get(Rec.Empleado) Then begin
            rEmpl.Tarifa := "Tarifa 1";
            rEmpl."Salario Año" := "Salario Año";
            If Job.Get(Rec.Proyecto) then
                rEmpl."Customer No." := Job."Bill-to Customer No.";
            rEmpl.Modify();
            If rRes.Get(rEmpl."Resource No.") Then begin
                rRes."Unit Price" := "Tarifa 1";
                if JSetup."Prices in Resources" Then
                    If "Tarifa Actúal" then
                        rRes.Modify();
            end;
        end;

    end;

    trigger OnModify()
    var
        rEmpl: Record Employee;
        rRes: Record Resource;
        JSetup: Record "Jobs Setup";
        Cust: Record 18;
        Job: Record Job;
    begin
        JSetup.Get();
        If rEmpl.Get(Rec.Empleado) Then begin
            If "Tarifa Actúal" then
                rEmpl.Tarifa := "Tarifa 1";
            rEmpl."Salario Año" := "Salario Año";
            If Job.Get(Rec.Proyecto) then
                rEmpl."Customer No." := Job."Bill-to Customer No.";
            rEmpl.Modify();
            If rRes.Get(rEmpl."Resource No.") Then begin
                If "Tarifa Actúal" then
                    rRes."Unit Price" := "Tarifa 1";
                if JSetup."Prices in Resources" Then
                    rRes.Modify();
            end;
        end;

    end;

    trigger OnDelete()
    var
        rHist: Record "Lin Hist contrato empleado";
        rEmpl: Record Employee;
        rRes: Record Resource;
        JSetup: Record "Jobs Setup";
        Cust: Record 18;
        Job: Record Job;
    begin
        JSetup.Get();
        rHist.SetRange(Empleado, Rec.Empleado);
        rHist.SetCurrentKey(Empleado, "Fecha Inicio");
        rHist.Setfilter("Fecha Fin", '%1|>=%2', 0D, Today);
        rHist.SetFilter("Tarifa 1", '<>%1', 0);
        If rHist.FindLast() then begin
            If rEmpl.Get(Rec.Empleado) Then begin
                If rHist."Tarifa Actúal" then
                    rEmpl.Tarifa := rHist."Tarifa 1";
                rEmpl."Salario Año" := rHist."Salario Año";
                If Job.Get(rHist.Proyecto) then
                    rEmpl."Customer No." := Job."Bill-to Customer No.";
                rEmpl.Modify();
                If rRes.Get(rEmpl."Resource No.") Then begin
                    if JSetup."Prices in Resources" Then
                        If rHist."Tarifa Actúal" then
                            rRes."Unit Price" := rEmpl.Tarifa;
                    rRes.Modify();
                end;
            end;
        end;
    end;

    trigger OnRename()
    begin
        Error('No se puede renombrar');
    end;

}
/// <summary>
/// Table Hist contrato empleado (ID 50159).
/// </summary>
table 90159 "Hist contrato empleado"
{
    ObsoleteState = Removed;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Empleado; Code[20])
        {
            TableRelation = Employee;
            DataClassification = ToBeClassified;
        }


        field(3; Descripcion; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Fecha Inicio"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Fecha Fin"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Proyecto; Code[20])
        {
            TableRelation = Job;
            DataClassification = ToBeClassified;
        }


        field(7; "Tarifa 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Tarifa 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Salario Año"; Decimal)
        { }
    }

    keys
    {
        key(Key1; Codigo)
        {
            Clustered = true;
        }
        key(Key2; Empleado, "Fecha Inicio") { }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        rHist: Record "Hist contrato empleado";
        rEmpl: Record Employee;
    begin
        rHist.SetRange(Empleado, Rec.Empleado);
        rHist.SetCurrentKey(Empleado, "Fecha Inicio");
        rHist.Setfilter("Fecha Fin", '%1|>=%2', 0D, Today);
        rHist.SetFilter("Tarifa 1", '<>%1', 0);
        If rHist.FindLast() then begin
            If rEmpl.Get(Rec.Empleado) Then begin
                rEmpl.Tarifa := rHist."Tarifa 1";
                rEmpl."Salario Año" := rHist."Salario Año";
                rEmpl.Modify();
            end;
        end;
    end;

    trigger OnModify()
    var
        rHist: Record "Hist contrato empleado";
        rEmpl: Record Employee;
    begin
        rHist.SetRange(Empleado, Empleado);
        rHist.SetCurrentKey(Empleado, "Fecha Inicio");
        rHist.Setfilter("Fecha Fin", '%1|>=%2', 0D, Today);
        rHist.SetFilter("Tarifa 1", '<>%1', 0);
        If rHist.FindLast() then begin
            If rEmpl.Get(Rec.Empleado) Then begin
                rEmpl.Tarifa := rHist."Tarifa 1";
                rEmpl."Salario Año" := rHist."Salario Año";
                rEmpl.Modify();
            end;
        end;
    end;

    trigger OnDelete()
    var
        rHist: Record "Hist contrato empleado";
        rEmpl: Record Employee;
    begin
        rHist.SetRange(Empleado, xRec.Empleado);
        rHist.SetCurrentKey(Empleado, "Fecha Inicio");
        rHist.Setfilter("Fecha Fin", '%1|>=%2', 0D, Today);
        rHist.SetFilter("Tarifa 1", '<>%1', 0);
        If rHist.FindLast() then begin
            If rEmpl.Get(Rec.Empleado) Then begin
                rEmpl.Tarifa := rHist."Tarifa 1";
                rEmpl."Salario Año" := rHist."Salario Año";
                rEmpl.Modify();
            end;
        end;
    end;

    trigger OnRename()
    begin

    end;

}
