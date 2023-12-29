// /// <summary>
// /// Table Recurso por Proyectos (ID 90150).
// /// </summary>
// table 90150 "Recurso por Proyectos"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "No.Recurso"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Resource."No.";

//         }
//         field(2; "No. Proyecto"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Job."No.";
//         }
//         field(3; "Fecha Desde"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; "Fecha Hasta"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(5; "Proyecto Actual"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }

//     }

//     keys
//     {
//         key(Key1; "No.Recurso", "No. Proyecto", "Fecha Desde")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnInsert()
//     begin

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }