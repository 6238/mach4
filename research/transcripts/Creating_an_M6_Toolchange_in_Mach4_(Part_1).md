# Creating an M6 Toolchange in Mach4 (Part 1)

## Video Information

- **Video ID:** m1eMEec0N-E
- **URL:** https://www.youtube.com/watch?v=m1eMEec0N-E
- **Channel:** DazTheGas
- **Upload Date:** 2015-10-06
- **Duration:** 24:42
- **View Count:** 27,883
- **Downloaded:** 2025-10-16 05:33:14

## Description

Part 1 of creating a M6 command in Mach4

---

## Transcript

hi welcome to another video on Mac 4 in this video I'm going to be concentrating on setting up a basic M6 manual tool change the m6 macro as I like to call them in Mac 4 or basically any machine it is is not consistent it needs

to be programmed and set up to your specific machine so all the people that post on the forums that the m6 command doesn't work well you obviously haven't gone into it and had a look at it to find out what is there and what you can change to

make it specific for your machine so I'm going to do a bob basic one in this video as I said and we're going to be using if you go into your operator and go into edit and debug scripts you can find your M6 command

which your basic one is set there set or sat I don't know so this is our M6 as comes with Mac 4 and just to give you what it does this is our function itself this is our M6 code going by the guidelines is making a function of m6

and that's where it finishes when you put an M6 in an MDI or a gcode asks for an M6 this is what it will run in between here this part on the end is for when you're in this editor when you're edit editing the script the function M6 will

not run it will just assign a function that's it this just tells it if you're in the editor run that function which is very handy when you're in the debugging process like what we are now so what's this code doing as is out

the box the top three lines are assigning local variables first one is our Mac instance the second one selected tool is what the m6 command is asked you to change your tool to the current tool is the tool that Mac

assumes is in your spindle at that time the bottom three Mac get instance to get selected to get current all get assigned to those three local variables the MC control set last error is going to put the press cycle start to

finish the tool change down in the Box here just so you can see it it's then going to execute a gcode command which is going to send your Zed axis to zero so it's going to move away from your work piece to enable you a bit

of room to change the tool the MC control tool change manual will just let you know that manual tool change is in progress and you can press the cycle start to continue after that it it's going to tell you the next tool you need to set

selected tool the current tool in there is the current tool this again will go down here just to let the user know and lastly it's going to set the current tool to the selected tool so they're both equal so when you come up

with another tool change it will know exactly what tool is in the spindle so to start with let's get this set up to write our own M6 so that's the m6 that's being used going to get rid of that the top I'm going to change this

instead of declaring the variable then assign in s to the variable we can do that all at once get rid of them that's from different language I used to use them in PHP to denote the end of a line bit wrong that delete that

so that's all we need at the top there now to start debugging to find out what you what you got what the what it's actually going to do just click disable on that before forget if you press F5 within your

debugger it will start running the script and you press f11 to jump forward so we're going to declare three variables local instance local selected tool and the local current tool but when you're debugging how do

you know that's picked up what you wanted it to pick up if you take your cursor and put it over the top of that variable it will tell you what what now is assigned to that variable so current tool at this moment is equal to number

one your selected tool is equal to number one so strictly speaking why would you want to do a tool change when they're both identical so we're going to add our first piece of code in here to make it unique if you press shift and F5 that

will quit out your debugger and your F2 will get rid of the window at the bottom so what can we put in here let's stick an if statement if a selected tool is equal to current tool and is what we can do is simply

return basically don't run it you know just don't run the tool change else we can do something else in between there not forgetting to that so is what will happen here now it will go um it'll pick up your variables so it

knows them it knows that's a one it knows that's a one if the selected tool if them two are both equal then it's going to quit out of it it's not going to need to run the tool change at all it can it can just

go so how can we test this Theory out if we take that return and we don't need to zero if we take that return we're going to put the WX message box in there we're going to put on a no need for Tool change I don't normally put anything

like this it might just be a load of letters just to make it quick and if the numbers ain't equal again we'll do another message box and we'll change that to need tool change so if you go into your debugger now again press F5 and then use

your f11 to jog through it before it runs that if you highlight over it's going to ask if one is equal to one then do this which is no need no need for Tool change you press your shift and F5 to quit out

of that and on your Mac 4 screen just change your to number there to a number two we go back in in here and we'll run it again press F5 and then your f11 let's go back to where we were which is there so now it knows the selected

tool that we want wanted because with an M6 if you don't tell it what tool number you want it will automatically assume you want tool number one so the tool we're asking for is number one and our current tool is

number two so if you press f11 now it knows they're not equal so you'll need to do a tool change that's how and if and F if if if if if I need some new teeth that's an if an else statement that's how they work on there

that's a quick and easy way using message boxes just to see if it's going to work so what's the first thing we need to do with our M6 code or just same as it comes with the m6 with Mac 4 we need to get our Z Zed

axis into a safe Zone away from our work piece and so it's easier for us to change the tool we can do this by using an MC control gcode of execute weight we use the execute weight so nothing else will happen until that Z

AIS is in its safe spot where you tell it to go so what we're going to pass to that is our instance which we declared earlier on and then we're going to CH charge we're going to assign the G-Code to it or tell it to

run this gcode we're going to use a g90 for absolute distance then we're going to use our machine coordinates which is a g 53 and then we're going to wrap it it WP W wrap I really need some new teeth we're going

to send our Zed axis to zero and of course we'll close it off there so what we're going to need to do is let's give this a quick try for real you're going to need to close the editor down if it needs so saving then you're

going to need saving but for the m6 to become active in Mac 4 you need to shut down Mac 4 and open it back up so it's in there I've already done it in the background too well just to save time really so what I'm going to do is I'm

going to take my machine and I'm going to jog it you have to forgive me if I look like I don't know my way around map for cuz I don't on this screen I have my own if I take the Z AIS down as slow as I can

obviously right I'm going to go to the MDI panel and I'm going to do an M6 command that cycle start to start it it tells me there's no need for a tool change because our tool is already set number one there's no T in front of that to say

I want tool number 1 2 3 or 4 so it's not going to do anything let's change our tool to number two see what happens then when we run the m6 command as you can see the Z AIS is now getting into a safe position as we asked

and there's our message box telling us we need to do a tool change which we're going to do so if we go back in to our M6 script we just have a quick tidy up in here so we ain't got so much to do later we don't want that to keep giving us a

message box every time we try and run this so what we're going to do we're going to change this to an MC command of MC controller set last error so we we can set this then put your instance in Oops why you got two of them cuz I

put two in this way so we'll give it a message that it's going to put down the bottom just for our reference if you like so we can put tool changed tool changed um activated not required it'll do me anything you like you'll think of

something else so that's what we got there we're going to leave the message box down the bottom there so when we know we're at the end of this if statement so instead of putting need to do a tool change let's just put

um tool change finished so that's cleaned it up a little bit that's good make a bit more space right so now we're going to need to put our our spindle in a spot that we can change the tool as easy as possible if

you've got an 8ft before foot table and it just so happens it calls the m6 command while it's in the center of that table you've got some stretching to do to try and change that tool so we're going to want to move our axis to the

front or into a comfortable spot where you feel it's right to do a tool change so this is going to be in the form of another gcode execute weight so we can take this one here we can copy it and paste it in there obviously it's

not going to be the Z axis it's going to be the the X and the Y AIS I'll put not Point not in there for now but you what what's going on here there we go that's better to get these coordinates we're going to use a we're going to need to

get the machine coordinates so we your machine all enabled so what I'm going to do is jog to a spot I think will be comfortable for me go the right way to do a tool change so if I look at my machine coordinates

now I can take them coordinates for the X and Y and drop them in here they don't have to be exact so I can put that at 260 I can put the Y at 50 that'll do me so that's got our AIS where we're going to want that to

be so within our M6 function we've now got our Z access to a safe height and we've moved the X and Y into a prision for us to change the tool so let's tell the the machine operator now what tool they need to put

in we can do this by setting another local variable and I'm going to call this change two and we're going to use another Mac command called MC tool get description from the instance and the tool we're going

to select in here is the tool that we've asked for the tool change too so we can tell them what that tool is called so you can either type it in or just copy and paste it cuz I'm getting lazy so now excuse me mac 4 now

knows what the change to variable is but now let's tell the operator what it is with another famous message box all we need to pass into there is little message to the user of what to do so we're going to put this as

um not this I'm typing what I'm saying let's put please please change to Tool um let's say tool put space fact I'm going to do number tool number yeah let's do tool number we'll put two dots which you put them in between any string and

variable they they join on so I'm going to put in a selected tool and I'm going to add on the description of it fact I'm getting a bit muddled up here but I'll get there in a minute to number two I need a space or what right

there stick a space in it then we'll stick on the change to join up the end of this and we'll put in and press okay to continue close that off close the command off itself so it looks right to me if you

press an F7 I'll do a quick compile there's any errors in it then Mac 4 will soon let you know that it's not going to work so let's go and give this a little go to make sure it works so if you close down there you're

going to need to save it you're going to need to quit out of Mac 4 again now and reload it which will then Mac 4 will compile the m6 function for you into Mac 4 right I've got Mac 4 loaded up again I've HED all my Axis and I've stuck

stuck the machine in a fictitious place so we can run the code from it so everything's enabled go to the MDI and I'm going to do an M6 command press cycle start as you can see it's done I think I've set my tool to

Tool number one so we could test that bit we needed there which tool change activated but not required so we know that's working so let's change our tool here onto number two again and let's run the command

now well that's our de AIS going to its safe place and the X y move into the coordinates that we set the message box that we set up please change to Tool number one test tool one and press okay to continue we press okay that takes us to

the end of our tool change if you're wondering where the descriptions are coming from from the tools you got a tool table here well tool offsets in Mac four and I've just set four up there just just to use for

these this demonstration purposes well I'm going to have to call that it for part one cuz I think we're coming up to the 25 minute Mark by now by the time this is compiled it's going to take some time to

upload so in part two is we're going to progress this and we're going to record the X and Y coordinates before we do a tool change so we can return the spindle back to its original position but because we're going to

change the bit in the spindle our Zed reference is now going to be out so we're going to add a little function into there to ReRe refence our tool so its Zed position is exactly the same as the tool we took back out we're

going to re-reference it all so the machine basically for its M6 is going to raise the Z axis move to a tool change position we'll put a new tool in and then it will re-reference The Zed for us and go back to its original spot from

where it can continue then with the gcode that it was running so I'll see you in part two
