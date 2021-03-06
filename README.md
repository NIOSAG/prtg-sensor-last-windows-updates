# Latest Windows Updates for PRTG
 Created by [NIOS AG](https://nios.ch)
 
 ## Description
This scripts shows the amount of days since the last Windows Updates run and displays the last installed patch. It then outputs this informations in a PRTG XML structure with predefined error and warning limits.

## Installation
### Sensor creation
 1. Copy the script file into the PRTG Custom EXEXML sensor directory:
    "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML"

	- prtg-sensor-last-windows-updates.ps1 (PowerShell Sensor Script)

 2. Select the parent device on which you want to check the Status/Statistics and choose Add sensor. Select the sensor type EXE/Script Advanced in the group Custom sensors. Adjust the following settings:

	- **Name:** Enter a name that allows for easy identification of the sensor.
	- **Tags:** Add custom Tag like "windowsppdates"
	- **EXE/Script:** Select the corresponding script "prtg-sensor-last-windows-updates.ps1"
	- **Parameters:** Set the parameters as required. See below for further Information and an example.
	- **Security Context:** Assert that the script is run under a useraccount which can access the server
	- **Result Handling:** For easier troubleshooting, it is advisable to store the result of the sensor in the logs directory, at a minimum if errors occure.

### Parameters
    -host %host -username %windowsuser -password "%windowspassword"

### Screenshot of sensor creation
![Windows Update Sensor Configuration](https://github.com/NIOSAG/prtg-sensor-last-windows-updates/blob/main/prtg-sensor-last-windows-updates.PNG?raw=true "Sensor Configuration")

### Screenshot of sensor overview
![Windows Update Sensor Overview](https://github.com/NIOSAG/prtg-sensor-last-windows-updates/blob/main/prtg-sensor-last-windows-updates-overview.PNG?raw=true "Sensor Details")

## Troubleshooting
If the sensors report errors please follow this steps to identity the cause:

- Make sure that the sensor stores the EXE result in the file system, so that you can access the error message in the folder C:\ProgramData\Paessler\PRTG Network Monitor\Logs (Sensors).
- Let the PRTG Sensor recheck the latest Windows Updates.
- Check the LOG files.
