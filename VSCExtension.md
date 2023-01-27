# Vision Basic Code Editor
This is a SUPER SIMPLE extension that turns Visual Studio Code into an external IDE for Vision Basic.  Vision Basic was written by Dennis M. Osborn.  I'm just a recent fan.

# Prefix
I know... It's Vision Basic, and Visual Studio Code.  If I mess up the names, write me an issue!

# About
## My History
My first "Home PC" was the Vic-20, then shortly after, the family got a 64.  Now that I'm nearing my 50s, I've got a pair of breadbin 64s, a pair of 64Cs, and a pair of 128s (Amiga 500 style), and a whole bunch of 1541s, 1571s, but lacking in a 1581.

## Modern times
In 2023, Dennis put out a competition about his newly release product Vision Basic.  I had to try.  I've had this idea of a "commercially used" program running around in my head that I wrote in College for one of my courses.  The program wasn't to BE used in a commercial setting, it was just to prove that lessons were learned in class.  There was NO real external use.  Just fake stuffs.  

I was writing it on a 386 or 486 (I can't remember which now - I started college with the 386, ended with the 486, I just don't remember which semester the programming course was in).  I've had the desire to rewrite this on different platforms.  I figured "Why not?" with Vision Basic?

## Other notes
If you do things right, this can be used for ANY stock emulator that uses BASIC (Vic-20, 64, 128, etc).  It's not SPECIFIC to Vision Basic.  It can work with any line numbering process or script you may have.  This was just made because I had a need to do something in VB, and I couldn't do it with VICE or real hardware without wanting to dent my desk with my forehead.

# What you don't see
[2023-01-27] As I post this code, I do NOT have the source code for the extension up on Github yet, but it will get here.  I keep thinking of new things to add to it, and then decided to .. you know... write a preliminary doc for it.... .. then 4am rolled around... so... I'll get there.

# Why'd I do this?
## About Me
I've been a coder in varying languages for more than 75% of my life now.  I've grown very accustomed to my coding environments as of recent.  I just cannot cope with the limitations that the 64 has, as far as code editing.  I LOVE the machines, a lot of nostalgia, and a LOT of interesting toys and additions are being made, now even in 2023, for these awesome and fantastic machines.  New games, new hardware, new development software.  It's awesome.

Since I'm used to modern editing tools, and editing functionality, and then to boot, got away from line numbered BASIC programs, and my inability to cope with a 40x25 screen display, I needed to up the ante.  I couldn't keep tabs on the line numbers, adding code in between line numbers became a pain, and VB doesn't like renumbering NUMBERED lines.  It'll renumber all the lines in a range, wonderfully, but any GOTO or GOSUB won't get that note.

##So why external?
Because of the way Vision Basic handles things, it's not as simple to just compile the code to a PRG and ship it into the environment.  At this time (Another project for the future?) there is no tool out there that'll take the VB BASIC tokens and convert them into a PRG file to be loaded onto a 1541 or D64 image to be loaded on either real hardware or an emulator.  Not to mention, VICE doesn't support the idea of how VB works with loading programs.  There's no internal way to pass a Vision Basic program to Vice and have it load VB, then your program.  So that's when I thought about breaking things down into smaller blocks.

## The concept of use
Here's the problem.  Editing a multi-thousand line BASIC program hurts when you find out you've run out of line numbers between lines 500 and 510.  So the fix for that is don't use line numbers.  We've been doing that now for years.

But because Commodore Basic of any flavor needs line numbers, and because VB handles loading things way outside the norm, we have to go outside the box and paste in our code.

But pasting in that multi-thousand program is absolutely going to be a pain as well if you have to move line numbers around any number of times.

So what this does is break things down into more managable blocks of code.  You have several Text files open that contain your non-numbered BASIC code.  You run this extension in VSC, and it takes your code and converts it into something that can be pasted into VICE.  In small chunks.  A few-tens of lines.

# Features
NO LINE NUMBERS

Write your code like this:

```@filename=vbtest.txt

#This is a comment, and won't be shown in the new window

<#This is another format of comment.
This also won't be added to the code in the new window#>

#The following two commands are for "immediate mode" commands

.delete 0-999
.y

#Here we begin the code
clr

#Setting the next line to be 1000
]line=1000
This is a test
of the emergency coding system

#Change to line increments of 20
]linemult=20

#And continue on
To see if this works
for multiline interaction

#This next line will end up being a NOOP
#but will warn you in the code about what happened
]line=600
Even bettah!

#And here we truncate to 79 characters (one for the ENTER key)
This is a long line that needs to be cut down to 80 characters in length.This is a long line that needs to be cut down to 80 characters in length.
Even with the too long line, I continue to work!
```

You'll get code like this:

```delete 0-999
y
0 clr
1000 This is a test
1010 of the emergency coding system
1020 To see if this works
1040 for multiline interaction
1059 rem invalid line number from vbce - ]line=600
1080 Even bettah!
1100 This is a long line that needs to be cut down to 80 characters in length.T
1101 rem previous line too long. expect errors. forced trim to 79 characters
1120 Even with the too long line, I continue to work!
```

You take this code, and ALT-INSERT it into VICE, and code is pasted in.  The extension automatically takes the code it generates and puts it into your clipboard.

# What's this example doing?
As of this writing, here's what the extension understands to do:

By default, when you render your code, line numbering starts at 0, and will go in increments of 10.

```]line=###```
Where ### is the line number you want your code to RESUME at.  So if you've already put out 10 lines, entering ]line=5000 will mean that the line right after will start at 5000.

Note that if your attempting to set a line number that is LESS than the current line number, it becomes a NOOP, but will put a warning in your BASIC code stating the issue.

In other words, if you're code gets to line 1000, and you're using this to go to "start" on line 300, the extension just keeps trucking on with 1000.  Once I have the line tagging in place, line numbers become even less of an important thing.

```]linemult=###```
Where ### is the increment per line.  USUALLY BASIC goes up by 10, and it's a somewhere between an aesthetic as well as a safety.  Unless you roll with a utility that'll renumber your code, you usually want to keep some space between each line number.  Don't forget that the 8-bit systems have a hard stop at a maximum line number of 65535.  That's not saying that it'll take 65535 lines, that's the highest line number you can put in. ... you'll run out of line numbers well before 65535...

```<dot> commands```
These commands are for immediate mode.  In the example above you'll note the DELETE statement (A VB command) and then a Y.  This sends the DELETE 0-999 line, hits ENTER, then hits Y to confirm your answer.  But it's not limited to just DELETE.  Any immediate mode command can be used, and it doesn't have to be VB.

```# and <# ... #>```
Comments.  Plain and simple.  But these are not put into the Vision Basic output.  The # is a one-liner comment, while the <# and #> are block comments.  <# must be the first character of the line, and #> must be the last.

```@filename=####```
This MUST be the very first line of the file, and only is used if the output file is built.  If this is included anywhere else, the line is completely ignored.

Where this comes in useful is when you're editing your code in a TXT file, you'll have a copy of the extensions output immediately in the same directory where your TXT file is.  (Note, it's not necessary to have the TXT tab saved, but it certainly helps)  The extensions output will be saved to whatever Windows safe filename and to the same directory where your working TXT file is.  You can enter all the periods you want, but the \ and / are not permitted in the filename, so no storing in subdirectories or anything like that.

# What's missing?
A LOT.

## @include
I want to put in an @include function that'll pull in other TXT files, and compile them in.

## Line Tagging
Since GOTO and GOSUB are native to V2 basic, err.. any BASIC really.. I want to add a label system, like ```[DetectKey]``` and I can have in my TXT file several "GOSUB [DetectKey]" statements, and [DetectKey] gets replaced with the next line number.

## Macros
I want to add a MACRO type system that lives in a different file.  Instead of JSR'n all over the place for something to wait for a keypress or a raster line or whatever else, a text file that contains a list of substitutions go in.  So something along the lines of

```_BlackBorder_``` gets replaced with ```[lda#0:sta$d020```everywhere in the output code.  The Macros file would have ```BlackBorder:[lda#0:sta$d020```.

If you go change that BlackBorder to be the background color instead (d021) in the Macro file and rebuild, your entire code base potentially gets changed.

Granted, overusing macros will make your code base larger, but, less jumps, more CPUs!  Also, Macros can make things a bit easier to read in your TXT file.

# License
I have exactly zero problems if you use it.  Fork this if you'd like.  I'd like to be informed of any changes, but it is not necessary.  This code CANNOT be sold.  This code CAN be used by commercial entities. .. .. but.. i'd be asking why a commercial entity would want to have something like this?
