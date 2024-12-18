page 50256 LineasPartesWeb
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HGWA TimeSheets Lines";
    Editable = true;

    Caption = 'Lineas de Partes de Horas';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nº Recurso field.';
                    TableRelation = Resource."No.";
                    Editable = ppagEditable;
                }
                field("Nombre Recurso"; "Nombre Recurso")
                {
                    ApplicationArea = all;
                    Editable = ppagEditable;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fecha field.';
                    // Editable = ppagEditable;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Horas field.';
                    Editable = ppagEditable;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    Editable = ppagEditable;
                    Caption = 'Precio Unitario de Venta';

                }
                field("Cost of resources"; Rec."Cost of resources")
                {
                    ToolTip = 'Specifies the value of the Cost of resources field.';
                    Caption = 'Precio Unitario de Coste';
                }

                field(Sales; Rec.Sales)
                {
                    ToolTip = 'Specifies the value of the Sales field.';
                    Caption = 'Total Venta';
                }

                field("Total Cost"; Rec."Total Cost")
                {
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field(Benefic; Rec.Benefic)
                {
                    ToolTip = 'Specifies the value of the Bº field.';
                    Caption = 'Total Bº';
                }


                field("% Benefic"; Rec."% Benefic")
                {
                    ToolTip = 'Specifies the value of the % Benefic field.';
                    Caption = '% Bº';
                }


                field(Precio2; Precio2)
                {
                    ApplicationArea = all;
                    Editable = ppagEditable;
                    Visible = false;
                }



                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nº Proyecto field.';
                    TableRelation = Job."No.";
                    Editable = ppagEditable;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proyecto field.';
                    Editable = ppagEditable;
                }
                field(JobLine; Rec.JobLine)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Line field.';
                    Editable = ppagEditable;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nº Tarea field.';
                    TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
                    Editable = ppagEditable;
                }

                field("Job Task Description"; Rec."Job Task Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tarea field.';
                    Editable = ppagEditable;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cód. Actividad field.';
                    Editable = ppagEditable;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actividad field.';
                    Editable = ppagEditable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descripción field.';
                    Editable = ppagEditable;
                }

                field(Bloked; Rec.Bloked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                    Editable = ppagEditable;
                }
                field(Holiday; Rec.Holiday)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Festivo field.';
                    Editable = ppagEditable;
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoiced field.';
                    Editable = ppagEditable;
                }

                field(Marked; Rec.Marked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marked field.';
                    Editable = ppagEditable;
                }


                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bloqueado field.';
                    Editable = ppagEditable;
                }
                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completado field.';
                    Editable = ppagEditable;
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nº Línea field.';
                    Editable = ppagEditable;
                }
                field("TimeSheet No."; Rec."TimeSheet No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nº Parte Horas field.';
                    Editable = ppagEditable;
                }

                field(Precio1; Precio1)
                {
                    ApplicationArea = all;
                    Editable = ppagEditable;
                    Caption = 'Precio Venta Activo';

                }
                field("Coste Recurso"; "Coste Recurso")
                {
                    ApplicationArea = all;
                    ToolTip = 'Especifica el coste del Recurso de la Ficha';
                    Editable = ppagEditable;
                    Caption = 'Precio Coste Activo';
                }
                field(SalarioAnual; SalarioAnual)
                {
                    ApplicationArea = all;
                    Editable = ppagEditable;
                    caption = 'Salario Activo';
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

            action("Control imputacion Recursos")
            {
                ApplicationArea = All;

                //   RunObject = page "Horas recursos";
            }
            action(EditarPagina)
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin
                    ppagEditable := false;
                    CurrPage.Editable(ppagEditable);
                    CurrPage.Update(true);
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        ppagEditable := true;
        CurrPage.Editable(ppagEditable);
        CurrPage.Update(true);
    end;

    procedure PaginaEditable()
    begin
        ppagEditable := true;
        CurrPage.Editable(ppagEditable);
        CurrPage.Update(true);
    end;

    trigger OnAfterGetRecord()
    begin
        Clear("Nombre Recurso");
        Clear("Coste Recurso");
        if RResource.Get(rec."Resource No.") then begin
            "Nombre Recurso" := RResource.Name;
            "Coste Recurso" := RResource."Unit Cost";
        end else begin
            Clear("Nombre Recurso");
            Clear("Coste Recurso");
        end;

        ///>>>>
        Clear(Precio1);
        Clear(Precio2);
        Clear(SalarioAnual);
        LinesHisContrato.SetRange(Empleado, Rec."Resource No.");
        LinesHisContrato.SetRange("Tarifa Actúal", true);
        if LinesHisContrato.FindFirst() then begin
            Precio1 := LinesHisContrato."Tarifa 1";
            Precio2 := LinesHisContrato."Tarifa 2";
            SalarioAnual := LinesHisContrato."Salario Año";
        end else begin
            Clear(Precio1);
            Clear(Precio2);
            Clear(SalarioAnual);
        end;
        ///>>>>>

    end;

    var
        "Nombre Recurso": Text[150];
        RResource: Record Resource;
        RProyecto: Record Job;
        "Nombre Proyecto": Text[150];
        "Coste Recurso": Decimal;
        LinesHisContrato: Record "Lin Hist contrato empleado";
        Precio1: Decimal;
        Precio2: Decimal;
        SalarioAnual: Decimal;
        ppagEditable: Boolean;
        p50252: Page 50252;
}