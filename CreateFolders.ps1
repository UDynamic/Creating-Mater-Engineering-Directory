# Define the path to your CSV file
$csvPath = "C:\Path\To\Your\File.csv"

# Import the CSV file
$csvData = Import-Csv -Path $csvPath

# Define the base paths
$basePathSent = "C:\Path\To\Engineering\Sent\"
$basePathReceived = "C:\Path\To\Engineering\Received\"

# Function to create folders for each document
function Create-Folders {
    param (
        $basePath,
        $suffix
    )
    
    foreach ($row in $csvData) {
        $documentBaseName = $row.DocumentNumber + " - " + $row.DocumentName
        
        for ($rev = 0; $rev -le 6; $rev++) {
            # Format revision number as two digits
            $revFormatted = "{0:D2}" -f $rev
            
            # Create folder for the revision
            $revFolderName = $documentBaseName + " - Rev " + $revFormatted
            $revFolderPath = $basePath + $revFolderName
            New-Item -ItemType Directory -Path $revFolderPath -Force
            
            # Create folder for the RSH/CM
            $suffixFolderName = $documentBaseName + " - Rev " + $revFormatted + " - " + $suffix
            $suffixFolderPath = $basePath + $suffixFolderName
            New-Item -ItemType Directory -Path $suffixFolderPath -Force
        }
    }
}

# Create folders for Sent documents
Create-Folders -basePath $basePathSent -suffix "RSH"

# Create folders for Received documents
Create-Folders -basePath $basePathReceived -suffix "CM"

