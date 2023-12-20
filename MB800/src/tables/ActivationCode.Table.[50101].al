table 50101 ActivationCodeInformation
{
    Caption = 'Activation Code Information';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; ActivationCode; Text[14])
        {
            Caption = 'Activation Code';
            DataClassification = SystemMetadata;
            Description = 'Activation code used to activate Customer Rewards';
        }
        field(2; DateActivated; Date)
        {
            Caption = 'Date Activated';
            DataClassification = SystemMetadata;
            Description = 'Date Customer rewards was activated';
        }
        field(3; ExpirationDate; Date)
        {
            Caption = 'Date Expiration';
            DataClassification = SystemMetadata;
            Description = 'date Customer rewards activation expires';
        }
    }

    keys
    {
        key(PK; ActivationCode)
        {
            Clustered = true;
        }
    }
}