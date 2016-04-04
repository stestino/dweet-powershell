# dweet-powershell
PowerShell Module for Dweet.IO 


### Import the Module
```powershell
Import-Module DweetModule
```

### New Dweet
```powershell
$props = @{
    'my-content' = 'Hello Dweet'
}

$someJson = $props | ConvertTo-Json

New-Dweet -Thing 'dweet-name' -Content $someJson
```

#### ...with a key
```powershell
New-Dweet -Thing 'dweet-name' -Content $someJson -Key 'some-secret-dweet-key'
```

### Get Dweet
```powershell
Get-Dweet -Thing 'dweet-name'
```

#### ...with a key
```powershell```
$secretDweet = Get-Dweet -Thing 'dweet-name' -Key 'dweet-key-super-secret'

$secretDweet | Get-DweetContent
```

### Lock, Unlock
```powershell
Lock-Dweet -Thing 'dweet-name' -Lock 'your-dweet-lock' -Key 'super-secret-dont-share-key'
Unlock-Dweet -Thing 'dweet-name' -Key 'super-secret-key'
```

#### ...when you want to Remove a Lock from all Dweet Things
```powershell
Remove-DweetLock -Lock 'some-lock' -Key 'some-key'
```

