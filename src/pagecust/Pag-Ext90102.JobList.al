/// <summary>
/// PageExtension JobList (ID 90102) extends Record Job List.
/// </summary>
pageextension 90102 JobList extends "Job List"
{
    actions
    {
        addafter("Create Job &Sales Invoice")
        {
            action("Create Invoice by Job")
            {
                ApplicationArea = All;
                Caption = 'Create Invoice from TimeSheet';
                Image = NewInvoice;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("Job No.", Rec."No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.Facturar(Lines);
                end;

            }
            action("Undo Invoice by Job")
            {
                ApplicationArea = All;
                Caption = 'Undo Invoice by Job';
                Image = Undo;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("Job No.", Rec."No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.UndoFacturar(Lines);
                end;
            }


        }
        addfirst(Promoted)
        {
            actionref("Create Invoice"; "Create Invoice by Job")
            {

            }

        }


    }
}
pageextension 90103 JobCard extends "Job Card"
{
    layout
    {
        addafter(Blocked)
        {
            field(Holiday; Rec.Holiday)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SalesInvoicesCreditMemos)
        {

            action("Create Invoice by Job")
            {
                ApplicationArea = All;
                Caption = 'Create Invoice from TimeSheet';
                Image = NewInvoice;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("Job No.", Rec."No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.Facturar(Lines);
                end;

            }
            action("Undo Invoice by Job")
            {
                ApplicationArea = All;
                Caption = 'Undo Invoice by Job';
                Image = Undo;
                trigger OnAction()
                var
                    Lines: Record "HGWA TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                    ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("Job No.", Rec."No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.UndoFacturar(Lines);
                end;
            }
        }
        addfirst(Promoted)
        {
            actionref("Create Invoice"; "Create Invoice by Job")
            {

            }

        }
    }
}