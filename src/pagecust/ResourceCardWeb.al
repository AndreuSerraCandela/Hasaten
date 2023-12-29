// /// <summary>
// /// PageExtension ResourceCardWeb (ID 50151) extends Record Resource Card.
// /// </summary>
// pageextension 90151 "ResourceCardWeb" extends "Resource Card"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addlast("&Resource")
//         {
//             action("Recurso por Proyecto")
//             {
//                 ApplicationArea = all;
//                 RunObject = page "Recursos Por Proyectos";
//                 RunPageLink = "No.Recurso" = field("No.");
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }