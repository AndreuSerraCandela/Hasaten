/// <summary>
/// TableExtension ConfJob (ID 90102) extends Record Jobs Setup.
/// </summary>
tableextension 90102 ConfJob extends "Jobs Setup" //315
{
    fields
    {
        field(90100; "Holidays Code"; Code[20])
        {
            Caption = 'Job Code';
            DataClassification = ToBeClassified;
            TableRelation = "Job";
        }
        field(90101; "Prices in Resources"; Boolean)
        {
            Caption = 'Prices in resources';

        }
        field(50104; "Calendario Oficial"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".Code;
        }
    }
}
