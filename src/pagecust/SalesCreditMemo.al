/// <summary>
/// PageExtension SalesCreditMemoEx (ID 90101) extends Record Sales Credit Memo.
/// </summary>
pageextension 90105 "SalesCreditMemoEx" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Applies-to ID")
        {

            field("Posting No."; Rec."Posting No.")
            {
                ToolTip = 'Specifies the number of the posted invoice that will be created if you post the sales invoice.';
                ApplicationArea = All;
            }

            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ToolTip = 'Specifies the value of the Posting No. Series field.';
                ApplicationArea = All;
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