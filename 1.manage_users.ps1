# Prepare a password in secure string format
$Password = Read-Host "Enter the password that you want to set" -AsSecureString

# Create a new user account for Vitalii Shumylo
New-ADUser -Name "Vitalii Shumylo" -Surname "Shumylo" -GivenName "Vitalii" `
           -EmailAddress "vitalii.shumylo@vlabs8.com" -SamAccountName "vshumylo" `
           -AccountPassword $Password -DisplayName "Vitalii Shumylo" -Department "Sales" `
           -Country "US" -City "New York" -Path "OU=IT,DC=vlabs8,DC=com" -Enabled $true -PassThru

# View all attributes and values of the user object
Get-ADUser "vshumylo" -Properties *


# Loop to create multiple user accounts
1..100 | ForEach-Object {
    $UserName = "MarketingUser$_"
    New-ADUser -Name $UserName -AccountPassword $Password -Path "OU=Marketing,DC=vlabs8,DC=com"
}

# Create csv file in the following format
# FirstName,LastName,LoginName,Email,DisplayName,Country,City
# John,Doe,johndoe,john.doe@vlabs8.com,John Doe,US,New York
# Jane,Smith,janesmith,jane.smith@vlabs8.com,Jane Smith,CA,Toronto
# Alice,Johnson,alicejohnson,alice.johnson@vlabs8.com,Alice Johnson,UK,London

# Import from a csv file
$UserDetails = Import-Csv -Path "C:\UserDetails.csv"

# Display the imported user details
$UserDetails | Format-Table -AutoSize

# Retrieve user object for Vitalii Shumylo in IT
$User = Get-ADUser -Filter {Name -eq "Vitalii Shumylo"} -SearchBase "OU=IT,DC=vlabs8,DC=com"

# Display all attributes of the user
$User | Select-Object -Property *

# Update the description of user Vitalii Shumylo in IT department

# Specify the username
$UserName = "Vitalii Shumylo"

# Specify the new description
$NewDescription = "Please contact IT department for any technical assistance."

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=IT,DC=vlabs8,DC=com" -Properties *

# Display the current description
Write-Host "Current description is : $($UserObj.Description)"

# Update the description using Set-ADUser
Set-ADUser -Identity $UserObj -Description $NewDescription

# Get the updated user object
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=IT,DC=vlabs8,DC=com" -Properties *

# Display the new description
Write-Host "New description is : $($UserObj.Description)"

# Update telephone numbers for Vitalii Shumylo in IT department

# Specify the username
$UserName = "Vitalii Shumylo"

# Specify the new telephone numbers
$OfficeNumber = "+1 123-456-7890"
$HomeNumber = "+1 987-654-3210"
$MobileNumber = "+1 555-555-5555"

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=IT,DC=vlabs8,DC=com" -Properties *

# Update the telephone numbers using Set-ADUser
Set-ADUser -Identity $UserObj -OfficePhone $OfficeNumber -HomePhone $HomeNumber -MobilePhone $MobileNumber

# Retrieve the updated user object
$UpdatedUserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=IT,DC=vlabs8,DC=com" -Properties *

# Display the updated telephone numbers
Write-Host "Updated Office Phone: $($UpdatedUserObj.OfficePhone)"
Write-Host "Updated Home Phone: $($UpdatedUserObj.HomePhone)"
Write-Host "Updated Mobile Phone: $($UpdatedUserObj.MobilePhone)"


# Disable user account for Mark Jones in Marketing department

# Specify the username
$UserName = "Mark Jones"

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"

# Disable the user account using Disable-ADAccount
Disable-ADAccount -Identity $UserObj -PassThru

# Verify the disabled status
$DisabledUser = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"
Write-Host "Is user $($DisabledUser.Name) disabled? $($DisabledUser.Enabled)"

# Enable user account for Mark Jones in Marketing department

# Specify the username
$UserName = "Mark Jones"

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"


# Enable the user account using Enable-ADAccount
Enable-ADAccount -Identity $UserObj -PassThru

# Verify the enabled status
$EnabledUser = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"
Write-Host "Is user $($EnabledUser.Name) enabled? $($EnabledUser.Enabled)"

# Move user account MarketingUser1 from Marketing to NewOU

# Specify the username
$UserName = "MarketingUser1"

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"

# Specify the target OU's distinguished name
$TargetOU = "OU=Sales,DC=vlabs8,DC=com"

# Move the user account using Move-ADObject
Move-ADObject -Identity $UserObj.DistinguishedName -TargetPath $TargetOU

# Verify the new location
$MovedUser = Get-ADUser -Filter {Name -eq $UserName} -SearchBase $TargetOU
Write-Host "User $($MovedUser.Name) moved to $($MovedUser.DistinguishedName)"

# Delete user account MarketingUser2 from Marketing

# Specify the username
$UserName = "MarketingUser2"

# Get the user object and store it in a variable
$UserObj = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"

# Delete the user account using Remove-ADUser
Remove-ADUser -Identity $UserObj -Confirm:$false

# Verify if the user account is deleted
$DeletedUser = Get-ADUser -Filter {Name -eq $UserName} -SearchBase "OU=Marketing,DC=vlabs8,DC=com"
if ($DeletedUser -eq $null) {
    Write-Host "User account $UserName is deleted."
} else {
    Write-Host "User account $UserName still exists."
}





