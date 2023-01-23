About:
I just bought Vision Basic Dec 31, 2022, and received the digital copy Jan 5, 2023.  The QuickStart guide mentioned about having to swap disks.  Although I have a real physical Commodore 64 (2 bins and 2 Cs) I would prefer to do any kind of coding on my PC in an emulator than on the actual hardware.  Longevity to the hardware, and not having to stare at a single 14" CRT.  So with the suggestion of swapping disks, I wanted a way that I could keep the original D64 in the drive, but, have enough room and space to save my programs both source code and compiled code.  So out came the mission of using D61s instead.

This script was written by the ChatGPT application written by OpenAI.  I used plain English to instruct the bot to do the work.  The goal for this was not only to see what ChatGPT could do, but primarily see if it could write something with enough English context that I could copy and paste 100% of the code it made and run it with no modification.

Going forward, I'll make changes to the script manually, as needed, but suffice it to say, for a few hours of on and off typing, this did really well!

Setup:

There are three required files that need to be put in the same directory.  C1541.exe and the other two files in this directory.

- Create a directory somewhere on your machine that'll hold your projects.  For example, C:\VisionBasic will do. (Call it C:\VB from now on)
- Copy the StartVB.ps1 and vice_VB.ini file to C:\VB
- Copy your original Vision Basic D64 file to the C:\VB directory and rename it to something like vb1.d64
- If not already installed, install the GTK 3.7 version of Vice (Not tested with any others, and the vice_VB.ini file has the required Version entry).
- In the BIN directory to where you installed Vice, copy the C1541.exe file to C:\VB
- Edit the StartVB.ps1 script and modify the variables as required.
- - $path is the directory where the VICE EXE files are.
- - $exe is the name of the EXE to be run
- - $vb1Image is the name of your Vision Basic D64 file
- Open a non-admin Powershell session, and CD into C:\VB
- Launch StartVB.ps1
  (Note: There's sometimes an error about scripts being executed.  Report an issue and I'll find the fix, just can't remember it as I write this)
- You'll be prompted if you want to create a new file or use an existing one.  

Option 1 will create a new D81 image that you can name.
Option 2 will list all of the D81 images and allow you to pick one numerically.
Option 3 is hopefully obvious. ;)

Once you pick 1 or 2, Vice should kick up and start running.

Once you're within VB, execute the following:

DEVICE 9

Execute DIR and you should see either an empty disk, or, your already prepared disk contents.

![x64sc_03qpkbjil8](https://user-images.githubusercontent.com/4532020/210963893-1b508d0c-680b-4003-b4de-688180a49233.png)
