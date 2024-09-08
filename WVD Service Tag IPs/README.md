# **Windows 365 RDP Gateways IP Addresses**
## Purpose
#### This script will help you to retrieve all Windows 365 RDP Gateway IPs from the Azure Service Tag Windows Virtual Desktop, additionally, you can compare the output against a file with previous output information and you will find added or/and removed IPs.

____
## Usage
#### Download the script and run it with the following parameters:
- `-csvoutput` -> Path for the csv file that will be generated (example: c:\temp\w365ips.csv)
- `-compare` -> If you would like to compare the output against previous results.
- `-previousFile` --> File to compare against. This parameter will show up if you selected the `compare` parameter.

**_Examples:_**

```powershell
# Just to export the csv file with all IPs addresses
& '.\WVD Service Tags_IPs_Changes_Summary.ps1' -csvoutput c:\temp\w365ips.csv

# This will create the csv file with the IPs and creates another csv file with the comparison between w365ips.csv and w365ips.csv
& '.\WVD Service Tags_IPs_Changes_Summary.ps1' -csvoutput c:\temp\w365ips.csv -compare -previousFile c:\temp\w365ips_previous.csv
```

____
The script will download a json file from the Microsoft Download Center:
https://www.microsoft.com/en-us/download/details.aspx?id=56519

After the script is finished, it will generate one or three files depending on if you make a comparison or not:
- csv file with all IP addresses
- csv file with the comparison results
- txt file with a summary of IP per region