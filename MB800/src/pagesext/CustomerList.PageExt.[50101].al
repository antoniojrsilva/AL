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
        }
        addfirst(Category_Process)
        {
            actionref("Reward Levels_Promoted"; "Reward Levels")
            {
            }
        }
    }


}