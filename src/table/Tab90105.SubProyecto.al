table 90105 SubProyecto
{
    DataClassification = ToBeClassified;
    LookupPageId = SubProyecto;
    DrillDownPageId = SubProyecto;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Descripcion; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}