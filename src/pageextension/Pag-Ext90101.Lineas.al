/// <summary>
/// PageExtension Lineas (ID 90101) extends Record HGWA TimeSheet Lines.
/// </summary>
pageextension 90101 Lineas extends "HGWA TimeSheet Lines"
{
    layout
    {
        addafter(Completed)
        {
            field(Holiday; Rec.Holiday)
            {
                ApplicationArea = All;
            }
            field(Invoiced; Rec.Invoiced)
            {
                Caption = 'Invoiced';
                ApplicationArea = All;
                Editable = not BlbEditable;
            }
            field(Marked; Rec.Marked)
            {
                Caption = 'Marked';
                ApplicationArea = All;
            }
            field(JobLine; Rec.JobLine)
            {
                Caption = 'Job Line';
                ApplicationArea = All;
                Editable = not BlbEditable;

            }
            field(SubProyecto; Rec.SubProyecto)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SubProyecto field.', Comment = '%';
            }
            // field(Bloked; Rec.Bloked)
            // {
            //     Caption = 'Bloqueado';
            //     ApplicationArea = All;
            // }
            field("Unit Price"; Rec."Unit Price")
            {
                Caption = 'Unit Price';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.CalculosLineas();
                end;
            }
            field(Sales; Rec.Sales)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales field.';
            }
            field(Benefic; Rec.Benefic)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bº field.';
            }
            field("% Benefic"; Rec."% Benefic")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the % Benefic field.';
            }
            field("Cost of resources"; Rec."Cost of resources")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cost of resources field.';
                trigger OnValidate()
                begin
                    rec.CalculosLineas();
                end;
            }
            field("Total Cost"; Rec."Total Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Cost field.';
            }

        }
        modify("Activity Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                CP: Record "HGWA Job Activities";
            begin
                If Page.RunModal(Page::"Lista actividades por Proyecto", CP) = Action::LookupOK Then Rec."Activity Code" := Cp.Code;
            end;
        }
        modify("Job No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Job: Record Job;
            begin
                If Page.RunModal(0, Job) = Action::LookupOK Then
                    Rec.Validate("Job No.", Job."No.");
            end;
        }

    }
    actions
    {
        addlast(Processing)
        {
            action("Mark Selected")
            {
                Caption = 'Mark Selected';
                ApplicationArea = All;
                Image = Select;
                trigger OnAction()
                var
                    TimeLines: Record "HGWA TimeSheets Lines";
                begin
                    CurrPage.SetSelectionFilter(TimeLines);
                    TimeLines.ModifyAll(Marked, true);
                end;

            }
            action("Un Mark Selected")
            {
                Caption = 'Unmark Selected';
                ApplicationArea = All;
                Image = Select;
                trigger OnAction()
                var
                    TimeLines: Record "HGWA TimeSheets Lines";
                begin
                    CurrPage.SetSelectionFilter(TimeLines);
                    TimeLines.ModifyAll(Marked, false);
                end;

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        BlbEditable := LineaFacturada(Rec);
    end;

    local procedure LineaFacturada(var pHGWLineas: Record "HGWA TimeSheets Lines"): Boolean
    var
        myInt: Integer;
        plineasPlanificacion: Record "Job Planning Line";
    begin

        plineasPlanificacion.SetRange("Job No.", pHGWLineas."Job No.");
        plineasPlanificacion.SetRange("Job Task No.", pHGWLineas."Job Task No.");
        plineasPlanificacion.SetRange("Line No.", pHGWLineas.JobLine);
        plineasPlanificacion.SetRange(Type, plineasPlanificacion.type::Resource);
        plineasPlanificacion.SetRange("No.", pHGWLineas."Resource No.");
        if plineasPlanificacion.FindFirst() then begin
            plineasPlanificacion.CalcFields("Qty. Invoiced");
            if plineasPlanificacion."Qty. Invoiced" <> 0 then begin
                exit(true);
            end else
                exit(false)
        end;
    end;


    var
        BlbEditable: Boolean;
}
