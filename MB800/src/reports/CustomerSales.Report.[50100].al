report 50100 BarcodePrintToWord
{
    Caption = 'Barcode to Word';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName_Word;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';

            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(Unit_Price; "Unit Price")
            {
                IncludeCaption = true;
            }
            column(Barcode; EncodedText)
            {
            }
            column(BarCodeLbl; BarCodeLbl)
            {
            }

            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            var
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Codabar;
                EncodedText := BarcodeFontProvider.EncodeFont(GTIN, BarcodeSymbology)
            end;

            trigger OnPostDataItem()
            begin

            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName_Excel)
        {
            Type = Excel;
            LayoutFile = './src/reports/layouts/mySpreadsheet.xlsx';
            Caption = 'Excel example';
            Summary = 'An example of Excel';
        }
        layout(LayoutName_RDL)
        {
            Type = RDLC;
            LayoutFile = './src/reports/layouts/myRDL.rdl';
            Caption = 'RDL example';
            Summary = 'An example of RDL file';
        }
        layout(LayoutName_Word)
        {
            Type = Word;
            LayoutFile = './src/reports/layouts/myRDL.docx';
            Caption = 'Print Barcode';
            Summary = 'Print barcode of items';
        }
    }

    labels
    {
    }

    var
        EncodedText: Text;
        BarCodeLbl: Label 'Barcode';

}