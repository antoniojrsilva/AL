pageextension 50101 CustomerList extends "Customer List"
{
    actions
    {
        addfirst("&Customer")
        {
            action("Reward Levels")
            {
                ApplicationArea = All;
                Image = CustomerRating;
                ToolTip = 'Open the list of reward levels.';

                trigger OnAction();
                var
                    CustomerRewardsExtMgt: Codeunit CustomerRewardsExtMgt;
                begin
                    if CustomerRewardsExtMgt.IsCustomerRewardsActivated then
                        CustomerRewardsExtMgt.OpenRewardsLevelPage
                    else
                        CustomerRewardsExtMgt.OpenCustomerRewardsWizard;
                end;
            }
            action("Export Import Customer")
            {
                ApplicationArea = All;
                Caption = 'Import & Export Customers';
                ToolTip = 'Import & Export Customers in CSV from or to a choosen file';
                Image = CustomerSalutation;

                trigger OnAction()
                var

                    XmlImportExportCustomer: XmlPort CustomerImportExport;
                begin
                    XmlImportExportCustomer.Run();
                end;
            }
            action("Export Sales Query")
            {
                ApplicationArea = All;
                Caption = 'Export Xml Sales File';
                ToolTip = 'Export Xml Sales File';
                Image = ExportElectronicDocument;

                trigger OnAction()
                begin
                    SaveXmlFile();
                end;
            }
        }
        addfirst(Category_Process)
        {
            actionref("Reward Levels_Promoted"; "Reward Levels")
            {
            }
            actionref("ExportImport_Promoted"; "Export Import Customer")
            {
            }
            actionref("Export Sales Query_Promoted"; "Export Sales Query")
            {
            }
        }
    }

    local procedure SaveXmlFile();
    var
        SalesQuery: Query CustomerQuery;
        TempBlob: Codeunit "Temp Blob";
        FileNotSavedMessage: Label 'The file was not saved, the problem was %1';
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
    begin
        //Create an OutStream object for BLOB; You can now write data to BLOB
        TempBlob.CreateOutStream(OutStr);
        //Write the Query Result in the OutStream
        if not SalesQuery.SaveAsXml(OutStr) then
            Error(FileNotSavedMessage, GetLastErrorText());

        TempBlob.CreateInStream(InStr);
        FileName := 'Customer Sales' + '.xml';
        File.DownloadFromStream(InStr, 'Customer Sales Amount', '', '', FileName);
    end;

}