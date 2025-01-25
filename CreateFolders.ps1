# Define the path to your CSV file
$csvPath = "C:\Path\To\Your\File.csv"

# Import the CSV file
$csvData = Import-Csv -Path $csvPath

# Define the base paths
$basePathSent = "C:\Path\To\Engineering\Sent\"
$basePathReceived = "C:\Path\To\Engineering\Received\"

# Function to create folders for Sent documents
function Create-SentFolders {
    foreach ($row in $csvData) {
        $documentBaseName = $row.DocumentNumber + " - " + $row.DocumentName
        
        for ($rev = 0; $rev -le 6; $rev++) {
            # Format revision number as two digits
            $revFormatted = "{0:D2}" -f $rev
            
            # Create folder for the revision
            $revFolderName = $documentBaseName + " - Rev " + $revFormatted
            $revFolderPath = $basePathSent + $revFolderName
            New-Item -ItemType Directory -Path $revFolderPath -Force
            
            # Create folder for the RSH
            $rshFolderName = $documentBaseName + " - Rev " + $revFormatted + " - RSH"
            $rshFolderPath = $basePathSent + $rshFolderName
            New-Item -ItemType Directory -Path $rshFolderPath -Force
        }
    }
}

# Function to create folders for Received documents
function Create-ReceivedFolders {
    foreach ($row in $csvData) {
        $documentBaseName = $row.DocumentNumber + " - " + $row.DocumentName
        
        for ($rev = 0; $rev -le 6; $rev++) {
            # Format revision number as two digits
            $revFormatted = "{0:D2}" -f $rev
            
            # Create folder for the CM
            $cmFolderName = $documentBaseName + " - Rev " + $revFormatted + " - CM"
            $cmFolderPath = $basePathReceived + $cmFolderName
            New-Item -ItemType Directory -Path $cmFolderPath -Force
        }
    }
}

# Create folders for Sent documents
Create-SentFolders

# Create folders for Received documents
Create-ReceivedFolders
