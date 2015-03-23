$family = @("bob", "joan", "sue", "kelly", "ross")
$gifted = $family
$Gift_Pairs = @{}
$emails = @{}
#make an array of emails formated like "$familyNAME"="Email@email.email"
$emails = @{}


foreach ($sibling in $family) 
    {
        $pair1 = $sibling
        $pair2 = $gifted | Get-Random 
        while ($pair2 -like $pair1)
        {
        $pair2 = $gifted | Get-Random 
        }

        $gifted = $gifted -ne $pair2

        if ($pair1 -ne $pair2)
        {
            $Gift_Pairs.Add($sibling,$pair2)
            
        }

    }


#email results to hashtable containing email addresses based on Key name
foreach($member in $family)
    {
        $secpasswd = ConvertTo-SecureString "SECUREPASSWORDDONOTSHARE" -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ("GMAILADDRESS", $secpasswd)	
        $From = "GMAILADDRESS"
	    $To = $emails.($member)
	    $Subject = "This is your Random Christmas Pairing" 
	    $Body = "Hello $member,`n`nYou have been randomly paired with $($Gift_Pairs.($member)).  Please get them a gift for Christmas on Dec. 25, 2014.  `n`nThank you, `nSanta's Computer"

	    send-mailmessage -To $To -from $from -Subject $Subject -Body $body -SmtpServer "smtp.gmail.com" -UseSsl -Credential $cred -Port 587 
    }