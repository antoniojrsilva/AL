page 50103 ToDoAssistedSetup
{
    PageType = NavigatePage;
    SourceTable = "To-do";
    SourceTableTemporary = true;
    Caption = 'Add a To-do for the Team';

    layout
    {
        area(content)
        {
            group(Step1)
            {
                Visible = Step1Visible;

                group("Welcome")
                {
                    Caption = 'Welcome to the to-do assisted setup';
                    group(group11)
                    {
                        Caption = '';
                        InstructionalText = 'Use this guide to register a to-do task for you and your team.';
                    }
                }
                group("Let's go")
                {
                    Caption = 'Let''s go';
                    group(group12)
                    {
                        Caption = '';
                        InstructionalText = 'Select Next to get started.';
                    }
                }
            }
            group(Step2)
            {
                Caption = 'Enter information about the to-do task';
                Visible = Step2Visible;

                group("11")
                {
                    Caption = 'Add attendees and fill in details';
                    part(AttendeeSubForm; "Attendee Wizard Subform")
                    {
                    }
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'The number of the to-do.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    Caption = 'What type is the to-do?';
                    ToolTip = 'The type of the to-do.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Caption = 'What''s the start date?';
                    ToolTip = 'The start date of the to-do.';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Describe your to-do';
                    ToolTip = 'The description of the to-do.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    Caption = 'What''s the start time?';
                    ToolTip = 'The start time of the to-do.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    Caption = 'How long does it last?';
                    ToolTip = 'The duration of the to-do.';
                }
                field("Team To-do"; Rec."Team to-do")
                {
                    ApplicationArea = All;
                    Caption = 'Team to-do';
                    ToolTip = 'The team to-do.';
                }
                field("All Day Event"; Rec."All Day Event")
                {
                    ApplicationArea = All;
                    Caption = 'All Day Event';
                    ToolTip = 'The all day event.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'What''s the end date?';
                    ToolTip = 'The end date of the to-do.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                    Caption = 'What''s the end time?';
                    ToolTip = 'The end time of the to-do.';
                }
            }
            group(Step3)
            {
                Caption = 'That''s it!';
                InstructionalText = 'Select Finish to save the to-do.';
                Visible = Step3Visible;

            }
            group(StandardBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Back)
            {
                ApplicationArea = All;
                Caption = '&Back';
                Enabled = BackEnable;
                InFooterBar = true;
                Image = PreviousRecord;

                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(Next)
            {
                ApplicationArea = All;
                Caption = '&Next';
                Enabled = NextEnable;
                InFooterBar = true;
                Image = NextRecord;

                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(Finish)
            {
                ApplicationArea = All;
                Caption = '&Finish';
                Enabled = FinishEnable;
                InFooterBar = true;
                Image = Approve;

                trigger OnAction()
                begin
                    Finished();
                end;
            }
        }
    }


    trigger OnInit()
    var

    begin

        EnableControls();
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    begin
        //ToDoRec.Get();
        //ToDoRec.Init;
        //Rec := ToDoRec;
        //CurrPage.Update();
    end;

    var
        BackEnable: Boolean;
        NextEnable: Boolean;
        FinishEnable: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        Step: Option Start,Fill,Finish;
        ToDoRec: Record "To-do";
        TopBannerVisible: Boolean;
        FinishActionEnabled: Boolean;
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure Finished()
    begin
        StoreRecordVar();
        CurrPage.Close();
    end;

    local procedure EnableControls()
    begin
        ResetControls();
        case Step of
            Step::Start:
                ShowStep1();
            Step::Fill:
                ShowStep2();
            Step::Finish:
                ShowStep3();
        end;
    end;

    local procedure ShowStep1()
    begin
        Step1Visible := true;
        BackEnable := false;
        NextEnable := true;
        FinishEnable := false;
    end;

    local procedure ShowStep2()
    begin
        Step2Visible := true;
        BackEnable := true;
        NextEnable := true;
        FinishEnable := false;
    end;

    local procedure ShowStep3()
    begin
        Step3Visible := true;
        BackEnable := true;
        NextEnable := false;
        FinishEnable := true;
        FinishActionEnabled := true
    end;

    local procedure ResetControls();
    begin
        FinishEnable := false;
        BackEnable := true;
        NextEnable := true;
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;

    end;

    local procedure StoreRecordVar();
    begin
        ToDoRec.TransferFields(Rec, true);
        ToDoRec.Insert();
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
        then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();

    end;
}