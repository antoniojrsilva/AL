codeunit 50101 CustomerRewardsExtMgt
{
    EventSubscriberInstance = StaticAutomatic;

    // Determines if the extension is activated 
    procedure IsCustomerRewardsActivated(): Boolean;
    var
        ActivationCodeInformation: Record ActivationCodeInformation;
    begin
        if not ActivationCodeInformation.FindFirst() then
            exit(false);

        if (ActivationCodeInformation.DateActivated <= Today) and (Today <= ActivationCodeInformation.ExpirationDate) then
            exit(true);
        exit(false);
    end;

    // Opens the Customer Rewards Assisted Setup Guide 
    procedure OpenCustomerRewardsWizard();
    var
        CustomerRewardsWizard: Page CustomerRewardsWizard;
    begin
        CustomerRewardsWizard.RunModal();
    end;

    // Opens the Reward Level page 
    procedure OpenRewardsLevelPage();
    var
        RewardsLevelList: Page RewardLevelList;
    begin
        RewardsLevelList.Run();
    end;

    // Determines the corresponding reward level and returns it 
    procedure GetRewardLevel(RewardPoints: Integer) RewardLevelTxt: Text;
    var
        RewardLevel: Record Rewardlevel;
        MinRewardLevelPoints: Integer;
    begin
        RewardLevelTxt := NoRewardlevelTxt;

        if RewardLevel.IsEmpty() then
            exit;
        RewardLevel.SetRange(MinimumRewardPoints, 0, RewardPoints);
        RewardLevel.SetCurrentKey(MinimumRewardPoints); // sorted in ascending order 

        if not RewardLevel.FindFirst() then
            exit;
        MinRewardLevelPoints := RewardLevel.MinimumRewardPoints;

        if RewardPoints >= MinRewardLevelPoints then begin
            RewardLevel.Reset();
            RewardLevel.SetRange(MinimumRewardPoints, MinRewardLevelPoints, RewardPoints);
            RewardLevel.SetCurrentKey(MinimumRewardPoints); // sorted in ascending order 
            RewardLevel.FindLast();
            RewardLevelTxt := RewardLevel.Level;
        end;
    end;

    // Activates Customer Rewards if activation code is validated successfully  
    procedure ActivateCustomerRewards(ActivationCode: Text): Boolean;
    var
        ActivationCodeInformation: Record ActivationCodeInformation;
    begin
        // raise event 
        OnGetActivationCodeStatusFromServer(ActivationCode);
        exit(ActivationCodeInformation.Get(ActivationCode));
    end;

    // publishes event 
    [IntegrationEvent(false, false)]
    procedure OnGetActivationCodeStatusFromServer(ActivationCode: Text);
    begin
    end;

    // Subscribes to OnGetActivationCodeStatusFromServer event and handles it when the event is raised 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::CustomerRewardsExtMgt, 'OnGetActivationCodeStatusFromServer', '', false, false)]
    local procedure OnGetActivationCodeStatusFromServerSubscriber(ActivationCode: Text);
    var
        ActivationCodeInfo: Record ActivationCodeInformation;
        ResponseText: Text;
        Result: JsonToken;
        JsonRepsonse: JsonToken;
    begin
        if not CanHandle() then
            exit; // use the mock 

        // Get response from external service and update activation code information if successful 
        if (GetHttpResponse(ActivationCode, ResponseText)) then begin
            JsonRepsonse.ReadFrom(ResponseText);

            if (JsonRepsonse.SelectToken('ActivationResponse', Result)) then
                if (Result.AsValue().AsText() = 'Success') then begin

                    if (ActivationCodeInfo.FindFirst()) then
                        ActivationCodeInfo.Delete();

                    ActivationCodeInfo.Init();
                    ActivationCodeInfo.ActivationCode := ActivationCode;
                    ActivationCodeInfo.DateActivated := Today;
                    ActivationCodeInfo.ExpirationDate := CALCDATE('<1Y>', Today);
                    ActivationCodeInfo.Insert();
                end;
        end;
    end;

    // Helper method to make calls to a service to validate activation code 
    local procedure GetHttpResponse(ActivationCode: Text; var ResponseText: Text): Boolean;
    begin
        // You will typically make external calls / http requests to your service to validate the activation code 
        // here but for the sample extension we simply return a successful dummy response 
        if ActivationCode = '' then
            exit(false);

        ResponseText := DummySuccessResponseTxt;
        exit(true);
    end;

    // Subscribes to the OnAfterReleaseSalesDoc event and increases reward points for the sell to customer in posted sales order 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDocSubscriber(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean; LinesWereModified: Boolean);
    var
        Customer: Record Customer;
    begin
        if SalesHeader.Status <> SalesHeader.Status::Released then
            exit;

        Customer.Get(SalesHeader."Sell-to Customer No.");
        Customer.RewardPoints += 1; // Add a point for each new sales order 
        Customer.Modify();
    end;

    // Checks if the current codeunit is allowed to handle Customer Rewards Activation requests rather than a mock. 
    local procedure CanHandle(): Boolean;
    var
        CustomerRewardsMgtSetup: Record CustomerRewardsMgtSetup;
    begin
        if CustomerRewardsMgtSetup.Get() then
            exit(CustomerRewardsMgtSetup.CustRewExtMgtCodID = CODEUNIT::CustomerRewardsExtMgt);
        exit(false);
    end;

    var
        DummySuccessResponseTxt: Label '{"ActivationResponse": "Success"}', Locked = true;
        NoRewardlevelTxt: Label 'NONE';
}