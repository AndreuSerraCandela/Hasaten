/// <summary>
/// TableExtension TimeSheet (ID 90100) extends Record HGWA TimeSheets Lines.
/// </summary>
tableextension 90100 TimeSheet extends "HGWA TimeSheets Lines" //50252
{
    fields
    {
        field(90100; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = ToBeClassified;
        }
        field(90101; Marked; Boolean)
        {
            Caption = 'Marked';

        }
        field(90102; JobLine; Integer)
        {
            Caption = 'Job Line';
        }
        field(90103; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(90104; Bloked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(90110; "Cost of resources"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cost of resources';
            //Coste de recurso
        }
        field(90111; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Cost';
            Editable = false;
            //Cte Total
        }
        field(90112; Sales; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales';
            //Vta.
        }
        field(90113; Benefic; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bº';
            //Bº
        }
        field(90114; "% Benefic"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '% Benefic';
            //% Beneficio
        }
        field(90115; SubProyecto; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = SubProyecto.Codigo;
        }


        modify(Hours)
        {
            trigger OnAfterValidate()

            begin
                Setup.Get();
                CalculosLineas();
            end;


        }


        modify("Resource No.")
        {
            trigger OnAfterValidate()
            var
                Procesos: Codeunit ControlDeProcesos;
            begin
                Procesos.FindCostResourceEmployContract(rec); //para que actualice el coste por recursos antes de validar horas.
            end;
        }

    }
    trigger OnInsert()
    begin
        CalculosLineas();
    end;

    trigger OnAfterDelete()

    var
        Job: Record Job;
        JobSetup: Record "Jobs Setup";
        Res: Record Resource;
        Emply: Record Employee;
        Vacaciones: Integer;
        Lines2: Record "HGWA TimeSheets Lines";
        JobPlaning: Record "Job Planning Line";
    begin
        If Not Job.Get(Rec."Job No.") Then Job.Init();
        If (Job.Holiday) then begin
            //TimeSheet.Get(Lines."TimeSheet No.");
            Res.Get(Rec."Resource No.");
            Emply.SetRange("Resource No.", Res."No.");
            If Emply.FindFirst() then begin
                Lines2.Reset();

                Lines2.SetRange("Resource No.", Res."No.");
                Vacaciones := -1;

                Lines2.SetRange(Date, CalcDate('PA+1d-1A', Today), CalcDate('PA', Today));
                Lines2.SetRange("Job No.", Job."No.");
                //Lines2.SetRange(Holiday, true);
                Vacaciones += Lines2.Count;
                Emply.Consumidas := Vacaciones;
                Emply."Por Consumir" := Emply.Disponible + Emply."Disponible Año Anterior" - Vacaciones;
                Emply.Modify();
                JobPlaning.SetRange("Job No.", "Job No.");
                JobPlaning.SetRange("Job Task No.", "Job Task No.");
                JobPlaning.SetRange(Type, JobPlaning.Type::Resource);
                JobPlaning.SetRange("Line Type", JobPlaning."Line Type"::Billable);
                JobPlaning.SetRange("Line No.", JobLine);
                JobPlaning.DeleteAll();

            end;

        end
    end;



    trigger OnAfterInsert()
    begin
        //CalculosLineas();
    end;

    trigger OnBeforeInsert()
    begin
        CalculosLineas();
    end;


    procedure CalculosLineas()
    var

    begin
        if (rec.Hours <> 0) and (rec."Cost of resources" <> 0) then begin
            "Total Cost" := rec.Hours * rec."Cost of resources";
        end else
            if (Rec.Hours = 0) then
                "Total Cost" := 0;


        if (rec.Hours <> 0) and (Rec."unit price" <> 0) then begin
            sales := rec.hours * rec."unit price";
        end else
            if (Rec.Hours = 0) then
                Sales := 0;

        if (Sales <> 0) and ("Total Cost" <> 0) then begin
            Benefic := sales - "Total Cost";
            //"% Benefic" := Round((rec.Benefic / rec.Sales) / 100, Setup."Unit-Amount Rounding Precision") * 100;
            "% Benefic" := rec.Benefic / rec.Sales;
            "% Benefic" := ("% Benefic" * 100);
        end else begin
            if (Sales = 0) and ("Total Cost" = 0) then begin
                Benefic := 0;
                "% Benefic" := 0;
            end;
        end;
    end;

    var
        hisTContrato: Record "Lin Hist contrato empleado";

        Setup: Record "General Ledger Setup";

}
