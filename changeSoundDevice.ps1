$speaker_main = "Digital Audio \(S/PDIF\) \(High Definition Audio Device\)"
$speaker_sub = "UAB-80 \([0-9]- UAB-80\)"

Function getDeviceIdByName($device_name_pattern){
    $device_info = Get-AudioDevice -List | Out-String -Stream | Select-String -Pattern $device_name_pattern -Context 3,2
    [void]($device_info -match "{.+}\.{.+}")
    $id = $Matches[0]
    return $id
}

$speaker_now = Get-AudioDevice -Playback
$id_now = $speaker_now.ID
$id_main = getDeviceIdByName $speaker_main
$id_sub = getDeviceIdByName $speaker_sub

if ( $id_now -ne $id_main) {
  Set-AudioDevice -ID $id_main
}
else {
  Set-AudioDevice -ID $id_sub
  Set-AudioDevice -PlaybackVolume 1
}