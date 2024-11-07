/// <summary>
/// TableExtension JobLedgEntry (ID 90152) extends Record Job Ledger Entry //169.
/// </summary>//SE RENUMERA 50158, XQ  ESTA EN irf 90158
tableextension 50158 "JobL" extends "Job" //167
{
    fields
    {
        field(50100; "Holiday"; Boolean)
        {
            Caption = 'Vacaciones';
            DataClassification = ToBeClassified;
        }

    }


}