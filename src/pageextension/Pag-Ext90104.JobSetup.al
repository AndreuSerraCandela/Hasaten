/// <summary>
/// PageExtension JobSetup (ID 90104) extends Record Jobs Setup.
/// </summary>
pageextension 90104 JobSetup extends "Jobs Setup"
{
    layout
    {
        addafter("Apply Usage Link by Default")
        {
            field("Holidays Code"; Rec."Holidays Code")
            {
                ApplicationArea = All;
                Caption = 'Proyecto Vacaciones';
            }
            field("Prices in Resources"; Rec."Prices in Resources")
            {
                ApplicationArea = All;
            }
            field("Calendario Oficial"; Rec."Calendario Oficial")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Calendario Oficial field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Cambiar divisa Local")
            {
                ApplicationArea = All;
                Image = Currency;
                trigger OnAction()
                var
                    GenLedgSetup: Record "General Ledger Setup";
                begin
                    if GenLedgSetup.Get() then begin
                        GenLedgSetup."LCY Code" := 'EUR';
                        GenLedgSetup.Modify();
                    end;
                end;
            }
        }
    }
}
