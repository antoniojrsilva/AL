xmlport 50100 CustomerImportExport
{
    Caption = 'Export Customer';
    Direction = Export;
    TextEncoding = MSDOS;
    Format = VariableText;
    FieldSeparator = ',';
    RecordSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(Customers)
        {
            tableelement(Customer; Customer)
            {
                fieldattribute(No; Customer."No.")
                {

                }
                fieldattribute(Name; Customer.Name)
                {

                }
                fieldelement(Address; Customer.Address)
                {
                    fieldattribute(County; Customer.County)
                    {
                    }
                    fieldattribute(City; Customer.City)
                    {
                    }
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Name; Customer."No.")
                    {

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }
}