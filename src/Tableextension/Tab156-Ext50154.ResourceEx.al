//SE RENUMERA 50154, XQ 90154 ESTA EN irf 90154
tableextension 50154 ResourceEx extends Resource //156
{
    fields
    {
        field(50000; "Capacity Word"; Decimal)
        {
            CalcFormula = Sum("HGWA TimeSheets Lines".Hours WHERE("Resource No." = FIELD("No."),
                                                                    Date = FIELD("Date Filter"),
                                                                    "Job No." = field("Job Filter"),
                                                                    "Unit Price" = field(Tarifa)));
            Caption = 'Capacity Word';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;


        }
        field(50001; "Job Filter"; Code[50])
        {
            // DataClassification = ToBeClassified;
            //filtro proyecto:
            FieldClass = FlowFilter;
            TableRelation = Job."No.";
        }
        field(50002; Tarifa; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowFilter;
        }
    }

    var
        myInt: Integer;
}