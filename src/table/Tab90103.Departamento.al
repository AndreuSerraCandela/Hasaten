/// <summary>
/// Table Departamento (ID 90103).
/// </summary>
table 90103 Departamento
{
    LookupPageId = Departamento;
    DrillDownPageId = Departamento;
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