# Pacman Uninstall Information

sudo pacman -Runs package-name

 -u Removes targets that are not required by any other packages.
This is mostly useful when removing a group without using the -c option,
to avoid breaking any dependencies.

 -n Instructs pacman to ignore file backup designations.
Normally, when a file is removed from the system, the database is checked
to see if the file should be renamed with a .pacsave extension.

-s Remove each target specified including all of their dependencies,
provided that (A) they are not required by other packages; and 
(B) they were not explicitly installed by the user. 
This operation is recursive and analogous to a backwards --sync operation,
and it helps keep a clean system without orphans.
If you want to omit condition (B), pass this option twice.

_man pacman for more information_
