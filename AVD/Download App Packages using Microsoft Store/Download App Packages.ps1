# Function to Get and Process App Package Links
function Get-AppPackageLinks {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProductIDOrURL,
        [string]$outputPath
    )
    $ProductIDOrURL = "https://apps.microsoft.com/detail/9n8g5rfz9xk3?hl=en-us&gl=US"
    # API Endpoint
    $apiUrl = "https://store.rg-adguard.net/api/GetFiles"

    # Request Payload
    $payload = @{
        type = "url"  # Use "productid" for Product ID-based queries
        url  = $ProductIDOrURL
        ring = "Retail"  # Options: Retail, SLOW, FAST
        lang = "en-US"
    }

    # Array to Store Results
    $results = @()

    # Headers to Mimic a Browser Request
    $headers = @{
        "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0 Safari/537.36"
        "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8"
        "Accept-Language" = "en-US,en;q=0.5"
    }

    # Send POST Request
    try {
        $response = Invoke-WebRequest -Uri $apiUrl -Method POST -Body $payload -Headers $headers
        # Check for valid response
        if ($response.StatusCode -eq 200) {

            Write-host "Extracting Download Links and Metadata..." -ForegroundColor Green

            # Iterate through links and process 'outerHTML'
            foreach ($link in $response.Links) {
                $outerHTML = $link.outerHTML

                # Extract href (URL)
                $downloadLink = $link.href

                # Extract package name and extension using regex
                if ($outerHTML -match ">([^<]+)</a>") {
                    $fullPackageName = $matches[1]
                    $packageName = $fullPackageName -replace "\.[^.]+$", ""  # Remove the extension
                    if ($fullPackageName -match "\.([^.]+)$") {
                        $extension = $matches[1]
                    } else {
                        $extension = "Unknown"
                    }

                    # Add to results array
                    $results += [PSCustomObject]@{
                        PackageName = $packageName
                        Extension   = $extension
                        DownloadURL = $downloadLink
                    }
                }
            }

            # Export results to CSV
            $csvFile = $outputPath + "\AppPackageLinks.csv"
            $results
            $results | Export-Csv -Path $csvFile -NoTypeInformation -Encoding UTF8
            Write-host "Data exported to $csvFile successfully." -ForegroundColor Green
            <# Download the package is giving me a 403, need to work on that.
                # Display options for user selection
                Write-Output "Packages Available for Download:"
                $i = 1
                foreach ($result in $results) {
                    Write-Output "$i. $($result.PackageName) ($($result.Extension))"
                    $i++
                }

                # Prompt user to select a package
                $selection = Read-Host "Enter the number of the package you want to download"
                $selectedPackage = $results[$selection - 1]

                if ($selectedPackage) {
                    # Download the selected package to the Desktop folder
                    #$desktopPath = [Environment]::GetFolderPath("Desktop")
                    $outputFile = Join-Path -Path $outputPath -ChildPath "$($selectedPackage.PackageName).$($selectedPackage.Extension)"
                    Write-Output "Downloading $($selectedPackage.PackageName)..."
                    Invoke-WebRequest -Uri $selectedPackage.DownloadURL -OutFile $outputFile
                    Write-Output "Downloaded to $outputFile"
                } else {
                    Write-Output "Invalid selection. No package downloaded."
                }
            #>
        } else {
            Write-Output "Failed to fetch data. Status Code: $($response.StatusCode)"
        }
    } catch {
        Write-Error "Error occurred: $_"
    }
}

# Example Usage
# Replace this with the app's URL or Product ID from the Microsoft Store
$ProductID = "https://apps.microsoft.com/store/detail/app-name/9WZDNCRFHVJL"
$outputPath = [Environment]::GetFolderPath("Desktop") + "\AppPackage"
If(!(Test-Path $outputPath)){
    New-Item -ItemType Directory -Path $outputPath
}
clear
Get-AppPackageLinks -ProductIDOrURL $ProductID -outputPath $outputPath



