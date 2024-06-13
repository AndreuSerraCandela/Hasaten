/// <summary>
/// Table Perfil (ID 90102).
/// </summary>
table 90102 Perfil
{
    LookupPageId = Perfil;
    DrillDownPageId = Perfil;
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