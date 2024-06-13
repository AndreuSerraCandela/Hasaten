/// <summary>
/// Table Tipo Empleado (ID 90101).
/// /// /// </summary>
table 90101 "Tipo Empleado"
{
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Codigo';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Descripcion';
        }
    }
    keys
    {
        key(Key1; Code)
        {
        }
    }
    var
        myInt: Integer;
}