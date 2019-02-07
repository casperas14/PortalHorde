#################################################################################
$itchFileName = "portalhorde"
#################################################################################
$buildFileName = "build_poc.bat"
$deployFileName = "itch.bat"
#################################################################################
$scriptPath = Split-Path -parent $PSCommandPath
$scriptParentDirectory = (get-item $scriptPath ).parent
$uprojectPath = $scriptParentDirectory.FullName + '\' + $scriptParentDirectory.Name + '.uproject'
$uprojectName = $scriptParentDirectory.Name
##################################################################################
$buildDirectory = $scriptParentDirectory.parent.FullName + "\build\$uprojectName"
##################################################################################
$engine = "C:\Program Files\Epic Games\UE_4.21\Engine\Build\BatchFiles\RunUAT"
##################################################################################
#Windows
$win_cmd = "CALL `"$engine`" BuildCookRun -project=`"$uprojectPath`" -nocompile -nocompileeditor -installed -nop4 -cook -stage -archive -archivedirectory=`"$buildDirectory`" -package -clientconfig=Development -serverconfig=Development -clean -compressed -rocket -SkipCookingEditorContent -pak -prereqs -nodebuginfo -build -utf8output -maps=AllMaps -ue4exe=UE4Editor-Cmd.exe"
#IOS
$ios_cmd = "CALL `"$engine`" BuildCookRun -project=`"$uprojectPath`" -nocompile -nocompileeditor -installed -nop4 -cook -stage -archive -archivedirectory=`"$buildDirectory`" -package -clientconfig=Development -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs -nodebuginfo -targetplatform=IOS -utf8output -maps=AllMaps -rocket"
#Android
$and_cmd = "CALL `"$engine`" BuildCookRun -project=`"$uprojectPath`" -nocompile -nocompileeditor -installed -nop4 -cook -stage -archive -archivedirectory=`"$buildDirectory`" -package -clientconfig=Development -ue4exe=UE4Editor-Cmd.exe -clean -compressed -SkipCookingEditorContent -pak -prereqs -nodebuginfo -targetplatform=Android -cookflavor=ATC -utf8output -maps=AllMaps -rocket"

$win_cmd | Out-File -FilePath ($scriptPath + '\' + $buildFileName) -encoding ASCII
$ios_cmd | Out-File -FilePath ($scriptPath + '\' + $buildFileName) -Append -encoding ASCII
$and_cmd | Out-File -FilePath ($scriptPath + '\' + $buildFileName) -Append -encoding ASCII
#Not working, powershell security issue?
#Invoke-Expression $cmd

##################################################################################
#Itch.io
$win_cmd = "..\..\path\butler push `"$buildDirectory\WindowsNoEditor`" sivx/$buildFileName:windows"
$and_cmd = "..\..\path\butler push `"$buildDirectory\$uprojectName-armv7-es2.apk`" sivx/$buildFileName:android"
#Generate Deploy File
$win_cmd | Out-File -FilePath ($scriptPath + '\' + $deployFileName) -encoding ASCII
#$ios_cmd | Out-File -FilePath ($scriptPath + '\' + $buildFileName) -Append -encoding ASCII
$and_cmd | Out-File -FilePath ($scriptPath + '\' + $deployFileName) -Append -encoding ASCII