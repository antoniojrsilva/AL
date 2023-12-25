codeunit 50103 AddToManualSetup
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterManualSetup', '', true, true)]
    local procedure OnRegisterManualSetup()
    var
        ManualSetup: Codeunit "Guided Experience";
        GuidedExperienceType: Enum "Guided Experience Type";
        ManualSetupGroup: Enum "Manual Setup Category";
    begin
        ManualSetup.InsertManualSetup('This is a test to manual setup a Functionality',
                                        'Antonio',
                                        'New Manual Assited',
                                        10,
                                        ObjectType::Page,
                                        50103,
                                        ManualSetupGroup::General,
                                        'Keywords');
    end;
}