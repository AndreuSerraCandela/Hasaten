/// <summary>
/// TableExtension LineasJobPlaning (ID 90101) extends Record Job Planning Line.
/// </summary>
tableextension 90101 LineasJobPlaning extends "Job Planning Line" //1003
{
    fields
    {
        field(90100; TimeSheet; Code[20])
        {
            Caption = 'TimeSheet';
            DataClassification = ToBeClassified;
        }
    }
}
