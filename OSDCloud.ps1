#=======================================================================
#   PreOS: Update-Module
#=======================================================================
Install-Module OSD -Force
Import-Module OSD -Force
#=======================================================================
#   OS: Params and Start-OSDCloud
#=======================================================================
$Params = @{
    OSBuild = "21H1"
    OSEdition = "Pro"
    OSLanguage = "en-gb"
    OSLicense = "Retail"
    SkipAutopilot = $true
    SkipODT = $true
}
Start-OSDCloud @Params
#=======================================================================
#   PostOS: AutopilotOOBE Configuration
#=======================================================================
$AutopilotOOBEJson = @'
{
    "Assign":  {
                   "IsPresent":  true
               },
    "GroupTag":  "Enterprise",
    "GroupTagOptions":  [
                            "Development",
                            "Enterprise"
                        ],
    "Hidden":  [
                   "AddToGroup",
                   "AssignedComputerName",
                   "AssignedUser"
               ],
    "PostAction":  "Quit",
    "Run":  "PowerShell",
    "Title":  "OSDCloud Autopilot Registration"
}
'@
$AutopilotOOBEJson | Out-File -FilePath "C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json" -Encoding ascii -Force
#=======================================================================
#   PostOS: OOBEDeploy Configuration
#=======================================================================
$OOBEDeployJson = @'
{
    "Autopilot":  {
                      "IsPresent":  true
                  },
    "RemoveAppx":  [
                       "CommunicationsApps",
                       "OfficeHub",
                       "People",
                       "Skype",
                       "Solitaire",
                       "Xbox",
                       "ZuneMusic",
                       "ZuneVideo"
                   ],
    "UpdateDrivers":  {
                          "IsPresent":  true
                      },
    "UpdateWindows":  {
                          "IsPresent":  true
                      }
}
'@
$OOBEDeployJson | Out-File -FilePath "C:\ProgramData\OSDeploy\OSDeploy.OOBEDeploy.json" -Encoding ascii -Force

#=======================================================================
#   PostOS: Restart-Computer
#=======================================================================
Restart-Computer
