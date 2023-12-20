table 50102 CustomerRewardsMgtSetup
{
    Caption = 'Customer Rewards Mgt. Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; CustRewExtMgtCodID; Integer)
        {
            Caption = 'Customer Rewards Ext. Mgt. Codeunit ID';
            DataClassification = CustomerContent;
            //TableRelation = CodeunitMetadata.ID;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}