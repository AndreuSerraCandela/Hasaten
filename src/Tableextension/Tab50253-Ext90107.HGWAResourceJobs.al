tableextension 90107 HGWAResourceJobs extends "HGWA Resource Jobs" //50253
{
    fields
    {
        field(50100; SubProyecto; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = SubProyecto.Codigo;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}