/// <summary>
/// PageExtension ResourceCardWeb (ID 90151) extends Record Resource Card.
/// </summary>
pageextension 90131 "ResourceCardWeb" extends "Resource Card" //76
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("&Resource")
        {
            action("Recurso por Proyecto")
            {
                ApplicationArea = all;
                RunObject = page "Lista Recursos Por Proyectos";
                RunPageLink = "Resource No." = field("No.");
            }

        }
    }

    var
        myInt: Integer;
}