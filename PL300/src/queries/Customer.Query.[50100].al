query 50100 CustomerQuery
{
    Caption = 'Customer Query';
    QueryType = API;
    APIGroup = 'APINewGroup';
    APIPublisher = 'Antonio';
    APIVersion = 'v3.0';
    EntityName = 'CustomerSales';
    EntityCaption = 'Customer Sales';
    EntitySetName = 'CustomerSalesEntity';
    OrderBy = descending(TotalSalesAmount);

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {
                Caption = 'No';
            }
            column(Name; Name)
            {
                Caption = 'Name';
            }
            dataitem(Cust__Ledger_Entry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = Customer."No.";
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = "Document Type" = filter(Invoice | "Credit Memo");

                column(TotalSalesAmount; "Sales (LCY)")
                {
                    Caption = 'Total Sales Amount';
                    Method = Sum;
                }
                filter(datefilter; "Posting Date")
                {
                    Caption = 'Date Filter';
                }
            }
        }
    }

}