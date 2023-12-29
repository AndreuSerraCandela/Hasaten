// /// <summary>
// /// Page Concepto por Proyecto (ID 90152).
// /// </summary>
// page 90152 "Concepto por Proyecto"
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "Concepto Proyecto";

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {

//                 field(Codigo; Rec.Codigo)
//                 {
//                     ToolTip = 'Specifies the value of the Codigo field.';
//                 }
//                 field(Descripcion; Rec.Descripcion)
//                 {
//                     ToolTip = 'Specifies the value of the Descripcion field.';
//                 }
//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }