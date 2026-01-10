#New-Item -ItemType SymbolicLink -Path "$HOME\" -Target "$HOME\dotfiles"
function Create-SymLink {
	param (
		[Parameter(Mandatory=$true)][string]$path,
		[Parameter(Mandatory=$true)][string]$target
	)
	New-Item -ItemType SymbolicLink -Path $path -Target $target
}

function WinStow {
	param (
		[Parameter(Mandatory=$true)][string]$stowTarget,
		[Parameter(Mandatory=$false)][string]$stowIgnoreFile
	)
	#TODO if stow target begings with $HOME or C:\
	#TODO follow both stow config files for this
	$stowIgnoreExists = Test-Path $HOME\.stow-global-ignore -PathType Leaf
	#if $PSBoundParameters.ContainsKey('stowIgnoreFile')
	$currentWorkingDir = Get-Location
	$stowTarget = join-path $currentWorkingDir $stowTarget
	$filesToStow = Get-ChildItem $stowTarget
	# TODO if in stowignore
	foreach ($f in $filesToStow){
		$pathName = join-path $HOME $f.Name
		Create-SymLink $pathName $f.FullName
	}
}

#$Path = join-path "$HOME" $Path
#$Target = join-path "$HOME\dotfiles\" $Target

#Create-SymLink "$HOME\.scripts" "$HOME\dotfiles\scripts\.scripts"
#Create-SymLink "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\shm-keybinds.ahk.lnk" "$HOME\dotfiles\auto-hotkey\shm-keybinds.ahk"
#Create-SymLink "$HOME\reference" "$HOME\dotfiles\reference\reference"
#Create-SymLink "$HOME\shm-keybinds.ahk" "$HOME\dotfiles\auto-hotkey\shm-keybinds.ahk"
#
#New-Item -ItemType SymbolicLink -Path "$HOME\.stow-global-ignore" -Target "$HOME\dotfiles\stow\.stow-global-ignore"
#
#WinStow vim
#WinStow scripts
WinStow git
#C:\Users\Username\AppData\Roaming\.emacs.d
