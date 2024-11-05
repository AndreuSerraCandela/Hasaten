/// <summary>
/// Page Recursos Por Proyectos (ID 50150).
/// </summary>
page 90130 "Lista Recursos Por Proyectos"
{
    Caption = 'Recursos Por Proyectos';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HGWA Resource Jobs";

    layout
    {
        area(Content)
        {
            repeater(Geneal)
            {


                field("No.Recurso"; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No.Recurso field.';
                }
                field("No. Proyecto"; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Proyecto field.';
                }
                field(Tarea; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Fecha Desde"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fecha Desde field.';
                }
                field("Fecha Hasta"; Rec."Until Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fecha Hasta field.';
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
}