table 90157 "Resource by Job Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Resource No."; Code[20])
        {
            Caption = ' No. Recurso';
            DataClassification = SystemMetadata;

        }
        field(2; "Resource Name"; Text[200])
        {
            Caption = 'Nombre Recurso';
            DataClassification = SystemMetadata;

        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'No.Proyecto';
            DataClassification = SystemMetadata;

        }

        field(4; "Tarifa"; Decimal)
        {
            Caption = 'Tarifa';
            DataClassification = SystemMetadata;

        }
        field(5; "Period Type"; Option)
        {
            Caption = 'Tipo Periodo';
            OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
            OptionMembers = Day,Week,Month,Quarter,Year,Period;
            DataClassification = SystemMetadata;
        }
        field(6; "Period Name"; Text[50])
        {
            Caption = 'Nombre Periodo';
            DataClassification = SystemMetadata;
        }
        field(7; Capacidad; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Horas L"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Desviacion; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Horas; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Horas Totales';
        }
        field(11; Importe; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Importe';
        }


    }

    keys
    {
        key(Key1; "Resource No.", "Job No.", Tarifa)
        {
            Clustered = true;
        }
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