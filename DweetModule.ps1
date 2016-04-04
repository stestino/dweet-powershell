#Requires -Version 3.0

# https://dweet.io/play/
$Global:DweetURL = 'https://dweet.io:443/' 

function New-Dweet{
    [CmdletBinding()]
    param
    (
        # Thing (recommended to use a GUID to avoid clashes)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Thing = [guid]::NewGuid(),

        # Key (to access a locked dweet)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [String]$Key,

        # Content (json)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [String]$Content
    )

    begin
    {
    }
    process
    {
        
        # new dweet
        $action = 'dweet/for/'

        # build request URL
        $requestURL = $Global:DweetURL + $action + $Thing

        # append key if specified
        if($Key){
            $requestURL += "?key=$Key"
        }

        # web request
        Invoke-RestMethod -Uri $requestURL -Method Post -ContentType 'application/json' -Body $Content

    }
    end
    {
    }
}

function Get-Dweet{
    [CmdletBinding()]
    Param
    (
        # Thing (recommended to use a GUID to avoid clashes)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$Thing,

        # Key (to access a locked dweet)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [String]$Key,

        # Latest (only specify if you want the latest)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [switch]$Latest
    )

    begin
    {
    }
    process
    {
        # latest dweet, or latest 5 (default)
        if($Latest){ $action = 'get/latest/dweet/for/' }
              else { $action = 'get/dweets/for/' }

        # build request URL
        $requestURL = $Global:DweetURL + $action + $Thing

        # append key if specified
        if($Key){
            $requestURL += "?key=$Key"
        }

        # web request
        Invoke-RestMethod -Uri $requestURL -Method Get -ContentType 'application/json'
        
    }
    end
    {
    }
}

# Usage: Get-Dweet -Thing 'some-thing-name' | Get-DweetContent
function Get-DweetContent{
    [Cmdletbinding()]
    param(
        # dweet from Get-Dweet
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [Object[]]$with
    )

    begin{
    }
    process{
        
        if($with -eq '404') { $result = '0' }
        else{

            $dweetContent = $with.content
            $dweetContent
        }

    }
    end{
    }
}

function Lock-Dweet{
    [Cmdletbinding()]
    param(
        # Thing (recommended to use a GUID to avoid clashes)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $Thing,

        # Lock (lock to apply to a thing)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Lock,

        # Key (to access a locked dweet)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=2)]
        [String]$Key
    )

    # action
    $action = 'lock/'

    # build request URL
    $requestURL = $Global:DweetURL + $action + $Thing + "?lock=$Lock" + "&key=$Key"
    
    # web request
    Invoke-RestMethod -Uri $requestURL -Method Get -ContentType 'application/json'

}

function Unlock-Dweet{
    [Cmdletbinding()]
    param(
        # Thing (recommended to use a GUID to avoid clashes)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $Thing,

        # Key (to access a locked dweet)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Key
    )
    
    # action
    $action = 'unlock/'

    # build request URL
    $requestURL = $Global:DweetURL + $action + $Thing + "?key=$Key"
    
    # web request
    Invoke-RestMethod -Uri $requestURL -Method Get -ContentType 'application/json'

}

function Remove-DweetLock{
    [Cmdletbinding()]
    param(
        # Lock (lock to apply to a thing)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string]$Lock,

        # Key (to access a locked dweet)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Key
    )

    # action
    $action = 'remove/lock/'

    # build request URL
    $requestURL = $Global:DweetURL + $action + $Lock + "?key=$Key"

    # web request
    Invoke-RestMethod -Uri $requestURL -Method Get -ContentType 'application/json'

}
