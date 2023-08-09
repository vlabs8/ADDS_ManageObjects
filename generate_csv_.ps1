# Generate a random user data CSV file and save on disk C:

# Number of users to generate
$NumUsers = 10

# Create an empty array to store user objects
$Users = @()

# Generate random user data
for ($i = 1; $i -le $NumUsers; $i++) {
    $FirstName = Get-RandomName -Gender 'Male'
    $LastName = Get-RandomName -Gender 'Last'
    $LoginName = "user$i"
    $Email = "$LoginName@example.com"
    $DisplayName = "$FirstName $LastName"
    $Country = Get-RandomCountry
    $City = Get-RandomCity

    $User = [PSCustomObject]@{
        FirstName = $FirstName
        LastName = $LastName
        LoginName = $LoginName
        Email = $Email
        DisplayName = $DisplayName
        Country = $Country
        City = $City
    }

    $Users += $User
}

# Save user data to a CSV file on the C: drive
$CsvPath = "C:\UserDetails.csv"
$Users | Export-Csv -Path $CsvPath -NoTypeInformation

# Function to generate a random name
function Get-RandomName {
    param([string]$Gender)
    $Names = @("John", "Jane", "Alice", "Bob", "Emily", "David")
    $LastNames = @("Smith", "Johnson", "Doe", "Williams", "Brown", "Jones")
    
    if ($Gender -eq "Male") {
        return $Names | Get-Random
    } else {
        return $LastNames | Get-Random
    }
}

# Function to generate a random country
function Get-RandomCountry {
    $Countries = @("US", "Canada", "UK", "Australia", "Germany", "France")
    return $Countries | Get-Random
}

# Function to generate a random city
function Get-RandomCity {
    $Cities = @("New York", "Toronto", "London", "Sydney", "Berlin", "Paris")
    return $Cities | Get-Random
}
