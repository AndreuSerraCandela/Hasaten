/// <summary>
/// Page Cualificaciones Empleados (ID 90104).
/// </summary>
page 90104 "Cualificaciones Empleados"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Qualification";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number for the employee.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the qualification.';
                }
                field("Employee Status"; Rec."Employee Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Status field.';
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a qualification code for the employee.';
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the institution from which the employee obtained the qualification.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the qualification on this line expires.';
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost of the qualification.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a comment was entered for this entry.';
                }
                field("Course Grade"; Rec."Course Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the grade that the employee received for the course, specified by the qualification on this line.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee started working on obtaining this qualification.';
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