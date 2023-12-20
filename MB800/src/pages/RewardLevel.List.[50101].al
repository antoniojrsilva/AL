page 50101 RewardLevelList
{
    Caption = 'Reward Level list';
    //ContextSensitiveHelpPage = 'sales-rewards';
    SourceTable = Rewardlevel;
    SourceTableView = sorting(MinimumRewardPoints) order(ascending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the level of reward that the customer has at this point.';
                }
                field(MinimumRewardPoints; Rec.MinimumRewardPoints)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of points that customers must have to reach this level.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        If not CustomerRewardsExtMgt.IsCustomerRewardsActivated then
            Error(NotActivatedTxt);
    end;

    var
        CustomerRewardsExtMgt: Codeunit CustomerRewardsExtMgt;
        NotActivatedTxt: Label 'Customer Rewards is not activated';
}