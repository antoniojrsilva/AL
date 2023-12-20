pageextension 50100 CustomercardExt extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field(RewardLevel; RewardLevel)
            {
                ApplicationArea = All;
                Description = 'Reward Level';
                ToolTip = 'Specifies the level of reward that the customer has at this point.';
                Editable = false;
            }
            field(RewardPoints; Rec.RewardPoints)
            {
                ApplicationArea = All;
                Description = 'Reward points accrued by customer';
                ToolTip = 'Specifies the total number of points that the customer has at this point.';
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        /// <summary>
        /// 
        /// </summary>
        CustomerRewardsMgtExt: Codeunit CustomerRewardsExtMgt;
    begin
        RewardLevel := CustomerRewardsMgtExt.GetRewardLevel(Rec.RewardPoints);
    end;

    var
        RewardLevel: Code[20];
}