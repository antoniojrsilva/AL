table 50100 Rewardlevel
{
    Caption = 'Reward Level';
    TableType = Normal;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Level; Text[20])
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }
        field(2; MinimumRewardPoints; Integer)
        {
            Caption = 'Minimum Reward Points';
            DataClassification = CustomerContent;
            MinValue = 0;
            NotBlank = true;

            trigger OnValidate()
            var
                RewardLevel: Record Rewardlevel;
                tempPoints: Integer;
                errorMinimumPoints: Label 'Minimun Reward Points must be unique';
            begin
                tempPoints := MinimumRewardPoints;
                RewardLevel.SetRange(MinimumRewardPoints, tempPoints);
                if not RewardLevel.IsEmpty() then
                    Error(errorMinimumPoints);
            end;
        }
    }

    keys
    {
        key(PK; Level)
        {
            Clustered = true;
        }
        key(KeyMinimunRewardPoints; MinimumRewardPoints)
        {
        }
    }

    trigger OnInsert()
    begin
        Validate(MinimumRewardPoints);
    end;

    trigger OnModify()
    begin
        Validate(MinimumRewardPoints);
    end;
}