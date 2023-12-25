profile TheBoss
{
    Description = 'The Boss';
    RoleCenter = "CEO and President Role Center";
    Customizations = TheBossCustomizations;
    Enabled = true;
    Caption = 'Boss';
}

pagecustomization TheBossCustomizations customizes "Customer List"
{
    actions
    {
        moveafter(Orders; "Blanket Orders")

        modify(NewSalesBlanketOrder)
        {
            Visible = false;
        }
    }

    views
    {
        addfirst
        {
            view(BalanceLCY)
            {
                Caption = 'Ordered Balance LCY';
                OrderBy = descending("Balance (LCY)");
                SharedLayout = false;
                layout
                {
                    movefirst(Control1; "Balance (LCY)")
                    modify(Control1)
                    {
                        FreezeColumn = "Balance (LCY)";
                    }
                }
            }
        }
    }
}