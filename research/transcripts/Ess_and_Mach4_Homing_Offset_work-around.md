# Ess and Mach4 Homing Offset work-around

## Video Information

- **Video ID:** lYQHRWbwqS4
- **URL:** https://www.youtube.com/watch?v=lYQHRWbwqS4
- **Channel:** DazTheGas
- **Upload Date:** 2015-05-11
- **Duration:** 15:25
- **View Count:** 9,822
- **Downloaded:** 2025-10-16 05:33:02

## Description

err brackets not allowed in description.....

---

## Transcript

hi welcome to another video on Mac 4 if you're like me you got Mac 4 and you've got it set up on a smooth stepper and you've zeroed everything out all your lights are green ready to go and then all of a sudden plenty of limit

switches trip because we're only using little mechanical switches well the people at Mac Mac for sorry has been very good to us and we could have a homing offset so we can move that off the switch whatever we

like so you know this won't happen unfortunately the home offset doesn't work with the smooth stepper but by the time you finish watching this video it will work so we need to write our own code in the background du using the PLC script

signal script and Screen load script as what we want to do is we want to apply an offset to our machine coordinates when everything's been HED we've already got that here with these green LEDs that we've been homed

so if we go into our screen editor and highlight one of these go into the properties of it it's being activated by an output signal so if we go into the Mac 4 API we've got output signals for the X Y and Zed whether they've been

homed so we need to write a function that picks up when all three of these signals are on then move the access to what we've set in the MC configuration but all also if it's already been run once don't run it again

otherwise you'll get a continuous loop of it moving if you set an offset of five your home all access they're all activated all got signals coming from x y and Zed it will move the five and then the PLC script start again and it will

say oh they're active we'll move it five and it will do that in a loop and just well it it will it will just limit out all your axes so we need to put a file safe into that as well so the first thing we're going to do is we're going

to go to our WX Mac and go into the events tab of where we've got our signal scripts and PLC scripts so in the signal script the code we're going to be using I'm going to be doing a lot of lot of past in here as I don't feel it

necessary for you to watch me type all this out make mistakes and backspace and delete all the time so this is our script for it and going down the line only on the first instance it's if the signal is equal to Output signal homed X

then we'll do something else now is what it's going to do it's just going to check the state and see if it's on if it is on we're going to set a variable called X enable Offset you can call that what you

like but so long as it's consistent throughout the whole of the script if it is if the state is equal to one we're going to put X enable offset true else if it's not set if it's a zero it's going to be X enable offset

obset offset equals false and then quit out of it they do exactly the same with Y and exactly the same with zed when you've wrote your lure code which incidentally is case sensitive so you really do have to watch

your typos you go to your debug and compile it'll let you know here if you've got any errors in your lure code so we can now exit out of that and save it now we need need to go into our PLC script open this one up and we'll go

down to the bottom of here and we'll insert our code down the bottom the code here is if the X enable offset is true the Y enable offset is true and the Zed enable offset is true then we'll do something I've just stuck a message box

in here for now just while we'll test it so let's have a quick compile just check there's no errors so we'll come out of that that's okay go to our out of our edit screen we want to save everything does that every time oh dear

it'll keep doing this now won it now this is what I'm on about a loop this is a fail safe the plc's script starts at the beginning and it runs when it gets to the end it starts again now everything on our axis is

homed and it knows it's picking up its HED so it's going to constantly give us this able to offset message that we put in there like I was saying before if we'd put our code in there for move our AIS 5 mil 10 mil it would have done that

and then it would done it again and again and again and again until your access just kept going and going and going now for me to get out of this now I'm going to have to do a control out Delete and I'm going to have to close

Mac 4 down cuz I'm in an endless loop which just won't let me get out of it that's it let that g open me Mac back up this is why I like using message boxes yes I want you to wake up all right so we'll go back notice

it's not doing it now because it knows that these are not referenced so we'll go back into our edit screen and we'll go back to our PLC script we need to scroll back down to our function and we need to put something

else in there we're going to start off another variable called offset applied is all that's going to do is if we've already applied that offset then don't do it again so we can do that with another if statement of if the

offset offset applied is equal to false then we can do the message box but if it is false and we run it again we want to change it to true so we can just stick another offset applied is basically is equal to true we

can stick that on the end there this will take us out of our endless loop if you like so if we do a quick compile there oh we have an error there and the file close I've missed an end out so if we go up

here there's an if statement there so we'll stick the end on that one there we are that should be okay now compile it there we are out there save changes yep let's set it out of here now exit rather than edit out that's a

different one so we got no Box jumping about up here so we'll click enable and we'll do a reference home so it's still nothing came up because it doesn't know what the variable offset applied is it's nothing at the moment it's um

how can you put it doesn't exist so we'll quickly go to our MDI D reference everything because once we come out the editor there'll be there'll be reference so it's going to go straight into the code if we go to our

operator edit screen and this time we're going to edit the screen load so we'll just open that up and at the top we'll stick an offset applied equals false because it's never been run before we'll save out of

that save changes yes quit out the editor save changes whoop job Trace what's that missed that one right go into the edit screen exit the edit screen that's thrown me now we've got everything set here so if we enable and do a reference

all home that's it it knows that's at the end it won't run again because it's now set to true even if you reference home again it's not going to do it because it's still reference is true so if you do lose or D if you like or loser

references for any reason at all you want to be able to apply that offset again don't you well this is where our script comes in again if we go to edit go to our reference all home button and into the lower instance of

that we can stick our offset applied equals false at the beginning of it before it decides to do the Homing so yeah we'll save that CIT out the edit screen again yep I know all right so if I do reference all

home it's going to apply the offset don't matter how many times I do it it'll apply it um if I go to D reference that's it program run it will still know then it'll only do it if I click that button so everything's working how it

should now is all we need to do is get get rid of that message box and change that to the command to actually do the offset of our axes so if we go into configure our Mac homeing and soft limits just as a

reference I'm going to stick these on five and minus two from me Z AIS click apply and okay I'm going to have to exit out of Mac now and restart it so it reads the machine in where it's just saved those figures for the Homing

offset so we've got them in machine otherwise they will still be zero all right let's go into our edit screen go back into our PLC script find our Command at the bottom here and we're going to replace the message box with this

slot as what this does is a command in Mac which is their four motion controllers is an access get home offset of the instance of M you're running which is this instance and that's motor zero let get the offset for motor one

get the offset for motor 2 now the axis might have all homed but it doesn't mean they're on zero that they're not zeroed out so you could home your access and say the x is still on 50 or minus 20 but there's no

point at sending it a code to go to Five because it's going to have to travel a long way and it's still going to be confused it won't be in the right place so if we run a MC AIS set prision and drop our position for the motor 0 one

and two down to zero it gives us a nice reference point and last but not least not least the actual code for putting the offset is a g code if we do a g z0 code on the X and tell it to use the X offset from here

and then do a y offset from here and a zed offset from here it will pick them numbers up and apply it let's go ahead quick compile going to that everything's okay we'll quit out of the edit screen the axis that's where it would be

so I'm just going to enable it Dr away from a couple of them and I'm going to do a reference all home there you go you see we've just done we've just done our offset it stuck it on the back there just do that

again that's it the offset is now working well hope I didn't make that too complicated for you I was starting to lose myself a bit well until the next video about Mac I will see you next time and I'll post this the scripts and

everything in the comments below just so you can copy and paste it it's a lot easier than typing it out okay see you next time
