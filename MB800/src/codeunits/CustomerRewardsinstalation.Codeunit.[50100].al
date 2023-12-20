codeunit 50100 CustomerRewardsInstalation
{
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    var
        myAppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(myAppInfo);
        if myAppInfo.DataVersion = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall()
        else
            HandleReinstall();
    end;

    local procedure HandleFreshInstall();
    begin
        SetDefaultCustomerRewardsExtMgtCodeunit();
        InsertDefaultrewardsLevels();
        InitializeRewardsForExistingCustomers();
    end;

    local procedure HandleReinstall();
    begin

    end;

    procedure SetDefaultCustomerRewardsExtMgtCodeunit();
    var
        CustomerRewardsMgtSetup: Record CustomerRewardsMgtSetup;
    begin
        CustomerRewardsMgtSetup.DeleteAll();
        CustomerRewardsMgtSetup.Init();
        CustomerRewardsMgtSetup.CustRewExtMgtCodID := Codeunit::CustomerRewardsExtMgt;
        CustomerRewardsMgtSetup.Insert();
    end;

    procedure InsertDefaultrewardsLevels();
    var
        RewardLevels: Record Rewardlevel;
    begin
        Clear(RewardLevels);
        if not RewardLevels.IsEmpty then
            exit;
        InsertRewardLevel('Bronze', 10);
        InsertRewardLevel('Silver', 20);
        InsertRewardLevel('Gold', 30);
        InsertRewardLevel('Platinum', 40);
    end;

    local procedure InsertRewardLevel(Level: Text[20]; Points: Integer);
    var
        RewardLevel: Record Rewardlevel;
    begin
        Clear(RewardLevel);
        RewardLevel.Level := Level;
        RewardLevel.MinimumRewardPoints := Points;
        RewardLevel.Insert()
    end;

    local procedure InitializeRewardsForExistingCustomers()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
    begin
        Clear(SalesHeader);
        SalesHeader.SetCurrentKey("Sell-to Customer No.");
        if SalesHeader.FindSet(false) then
            repeat
                if not Customer.Get(SalesHeader."Sell-to Customer No.") then
                    exit;
                Customer.RewardPoints += 1;
                Customer.Modify();
            until SalesHeader.Next() = 0;
    end;
}