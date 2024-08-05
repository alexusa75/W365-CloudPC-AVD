Connect-MgGraph -Scopes "DeviceManagementConfiguration.ReadWrite.All"

## Create Intune Configuration Policy with the Standard setting published on this official documentation: https://learn.microsoft.com/en-us/fslogix/concepts-configuration-examples#registry-settings-standard

$uri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"
$VHDLocation = "\\storage-account-name.file.core.windows.net\share-name"
# Replace single backslashes with double backslashes
$convertedPath = $VHDLocation -replace '\\', '\\'
$CPolicyName = "FSLogixfromGraph"

$body = @"
{
    "name": "$($CPolicyName)",
    "description": "",
    "platforms": "windows10",
    "technologies": "mdm",
    "roleScopeTagIds": [
        "0"
    ],
    "settings": [
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesflipflopprofiledirectoryname",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesflipflopprofiledirectoryname_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesvolumetypevhdorvhdx",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesvolumetypevhdorvhdx_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesvolumetypevhdorvhdx_profilesvolumetypevhdorvhdx",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles~profiles_containeranddirectorynaming_profilesvolumetypevhdorvhdx_profilesvolumetypevhdorvhdx_vhdx",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesdeletelocalprofilewhenvhdshouldapply",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesdeletelocalprofilewhenvhdshouldapply_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesenabled",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesenabled_1",
                    "children": []
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretrycount",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretrycount_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretrycount_profileslockedretrycount",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 3
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretryinterval",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretryinterval_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profileslockedretryinterval_profileslockedretryinterval",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 15
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesprofiletype",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesprofiletype_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesprofiletype_profilesprofiletype",
                            "choiceSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                                "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesprofiletype_profilesprofiletype_0",
                                "children": []
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachcount",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachcount_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachcount_profilesreattachcount",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 3
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachinterval",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachinterval_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesreattachinterval_profilesreattachinterval",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 15
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilessizeinmbs",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilessizeinmbs_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilessizeinmbs_profilessizeinmbs",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationIntegerSettingValue",
                                "value": 30000
                            }
                        }
                    ]
                }
            }
        },
        {
            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSetting",
            "settingInstance": {
                "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingInstance",
                "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesvhdlocations",
                "choiceSettingValue": {
                    "@odata.type": "#microsoft.graph.deviceManagementConfigurationChoiceSettingValue",
                    "value": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesvhdlocations_1",
                    "children": [
                        {
                            "@odata.type": "#microsoft.graph.deviceManagementConfigurationSimpleSettingInstance",
                            "settingDefinitionId": "device_vendor_msft_policy_config_fslogixv1~policy~fslogix~profiles_profilesvhdlocations_profilesvhdlocations",
                            "simpleSettingValue": {
                                "@odata.type": "#microsoft.graph.deviceManagementConfigurationStringSettingValue",
                                "value": "$($convertedPath)"
                            }
                        }
                    ]
                }
            }
        }
    ]
}
"@

try {
    $response = Invoke-MgGraphRequest -Uri $uri -Method Post -Body $body
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}



