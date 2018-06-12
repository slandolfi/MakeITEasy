#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------


#Sample function that provides the location of the script
function Get-ScriptDirectory
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}#End Get-ScriptDirectory

#Function for Errors and Sleeping (It's not serious...goofy testing)
Function Error-Sleep($seconds)
{
	<#
        .SYNOPSIS
         Throws a bunch of errors for making more than 3 mistakes when entering a User name in MainForm - UserAdmin
        .DESCRIPTION
         Fun Errors that mean nothing other than information being inputted incorrectly. 
		 Don't freak out, it's only for 30 seconds and must be done 3x's or more
        .PARAMETER seconds
         Amount of seconds that the error is going to run. 
        .EXAMPLE
         C:\PS> Error-Sleep -seconds 30
         
         Displays random errors for giving bad information
         
        .NOTES
         NAME......:  Error-Sleep
         AUTHOR....:  Shiloh Landolfi

        #>
	$doneDT = (Get-Date).AddSeconds($seconds)
	while ($doneDT -gt (Get-Date))
	{
		$secondsLeft = $doneDT.Subtract((Get-Date)).TotalSeconds
		$percent = ($seconds - $secondsLeft) / $seconds * 100
		Write-Progress -Activity "Sleeping" -Status "Loading ALL kinds of errors...Also emailing ppl letting them know you're having issues with the MakeITEasy" -SecondsRemaining $secondsLeft -PercentComplete $percent
		[System.Threading.Thread]::Sleep(500)
	}
	Write-Progress -Activity "Sleeping" -Status "Loading ALL kinds of errors...Also emailing ppl letting them know you're having issues with the MakeITEasy" -SecondsRemaining 0 -Completed
	Write-Warning -Message "Error: Too many input values." -Category InvalidArgument
	Write-Warning "Access denied. HAHAHAHAH!!!!"
	Write-Warning "Beep Beep Boop Beep Boop Boop Poop!"
	Write-Warning "Almost done...having fun now? How do you like being given bad info??"
	Write-Warning "Okay, one more..."
	Write-Warning "Access Gran...Denied! Hahah Jk..."
	Write-Warning "Okay, I'm done...get back to work!"
	
} #End Function Error-Sleep
#Function to show users AD photo
Function Show-ADPhoto
{
        <#
        .SYNOPSIS
         Shows the photo stored in in an Active Directory User Account.
        .DESCRIPTION
         Reads the thumbnailPhoto attribute of the specified user's Active 
         Directory account, and displays the returned photo in a form window.
        .PARAMETER UserName
         The User logon name of the Active Directory user to query.
        .EXAMPLE
         C:\PS> Show-ADPhoto user1
         
         Displays the photo stored in the Active Directory user account with 
         the User logon name of "user1".
         
        .NOTES
         NAME......:  Show-ADPhoto
         AUTHOR....:  Joe Glessner
         LAST EDIT.:  28NOV11
         CREATED...:  28NOV11
        .LINK
         http://joeit.wordpress.com/
        #>
	
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $True,
				   ValueFromPipeline=$True,
				   ValueFromPipelineByPropertyName=$True,
				   Position = 0)]
		[Alias('un')]
		[String]$UserName
	
	) #End: Param
	
	##----------------------------------------------------------------------
	##  Search AD for the user, set the path to the user account object.
	##----------------------------------------------------------------------
	$Searcher = New-Object DirectoryServices.DirectorySearcher([ADSI]"")
	$Searcher.Filter = "(&(ObjectClass=User)(SAMAccountName= $UserName))"
	$FoundUser = $Searcher.findOne()
	$P = $FoundUser | Select path
		Write-Verbose "Retrieving LDAP path for user $UserName ..."
	If ($FoundUser -ne $null)
	{
		Write-Verbose $P.Path
	} #END: If ($FoundUser -ne $null)
	Else
	{
		Write-Warning "User $UserName not found in this domain!"
		Write-Warning "Aborting..."
		Break;
	} #END: Else
	$User = [ADSI]$P.path
	$Img = $User.Properties["thumbnailPhoto"].Value
	
} #END: Function Show-ADPhoto











#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

#Global variables used for all forms and funtions

$Global:Domain = "iceenterprise.com"
$Global:RDSCollectionUS = "RDS Sales"
$Global:RDSCollectionEU = "UK RDS"
$Global:RDSCollectionMX = "RDS Sales MX"
$Global:SearchBaseUSUser = "OU=Users,OU=US,OU=ICE,CN=iceenterprise,DN=com"
$Global:SearchBaseEUUser = "OU=Users,OU=EU,OU=ICE,CN=iceenterprise,DN=com"
$Global:SearchBaseMXUser = "OU=Users,OU=MX,OU=ICE,CN=iceenterprise,DN=com"
$Global:RDSUserFolderUS = "Get-Item -Path \\ntnx-rdsfs\RDS_USER\_US\"
$Global:RDSUserFolderInt = "Get-Item -Path \\ntnx-rdsfs\RDS_USER\_International\"

#Global variables for more specifically used for Mainform UserAdmin tab










