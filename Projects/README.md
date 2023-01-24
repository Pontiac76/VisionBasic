= Powershell Vision Basic Project Disk Manager [WIP DOCS]
== About
I'm a developer.  I have projects.  Multiple projects shouldn't sit on one massive directory full of files. In Vision Basics case, it's one project per disk.  All content relating to a project should remain on a disk.  I also don't work on ONE project at a time, so, multiple disks are required.  Hense, the birth of this script.

== Vision Basic
I am NOT the author of the Vision Basic Compiler.  Go here: https://visionbasic.net/

== What this does
The StartVB.ps1 script is just a way to press a few buttons to get a version of Vice going and running with a particular configuration already set and ready to go.

When configured (Talked about below) you'll be presented with a list of directories where x64sc.exe exists, and sorts them based on version type.  GTK, SDL or "Other".  These are the different versions of VICE that are within the root directory.  Pick the number for the version of VICE you'd like to run.

It will then ask if you want to create a new disk or use an already made disk.  This disk its asking about is your "Project" disk that'll be on your Drive 9.

If you say you'd like to create a new disk, provide a filename with no extension (Limited to A-Z, numbers, underscore, space, and comma.  Period not allowed).  You'll then be asked which disk type you'd like.  "Technically" any format supported by the C1541 app provided by the Vice team, however, only D64, D71 and D81 is provided to be selected and used within VICE at this time. (See https://vice-emu.sourceforge.io/vice_14.html under the "c1541 commands and options" section, specifically "Format").  More disk formats can easily be supported.

If you say you'd like to use an existing disk, a scan of all the disks within the root directory will be listed.  Depending on the extension of the disk, the appropriate drive will be assigned.  (D64=1541, D71=1571, D81=1581) Again, pick the number that represents the disk image you'd like to mount as drive 9.

From there, VICE will load with your setup.

== Setup
There's two different "paths" of consideration.  These "paths" are going to be where your VICE instances are, and where your disk images (And this script) are going to be located.
