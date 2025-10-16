# Creating an M6 Toolchange in Mach4 (Part 2)

## Video Information

- **Video ID:** TZ5fUIRjzxE
- **URL:** https://www.youtube.com/watch?v=TZ5fUIRjzxE
- **Channel:** DazTheGas
- **Upload Date:** 2015-10-08
- **Duration:** 27:51
- **View Count:** 12,746
- **Downloaded:** 2025-10-16 05:33:18

---

## Transcript

hi and welcome to part 2 hopefully I'll get the I'll call it second half but if it doesn't end up being the second half and it goes on a bit then that's gonna be a part three well this is the code where we left it off from part one I

have made a small change in here it will not affect you it's just the coordinates of where I'm gonna do my tool change I've changed them to suit my machine so you just need to set them what is suitable for you so we need to get a few

coordinates off of our machine now especially for the z-axis so I've moved mine across to my new precision and probably touch plate it's it's all I've done is moved it from the right-hand side to the left-hand side I'm

right-handed so it's easier for me to undo that not with the right hand but the only reason why I've done it so I'm gonna do is I'm gonna take the bit out the machine and I'm gonna change it with the smallest bit that I've got so I can

put it in backwards yeah I've tried with my left hand it's quite simple so what am I looking for here so back in Mach 4 if you look just above the auto to zero a little bit says guess length well every time I do a tall

change I don't want to guess the length whether that works if you go in and if this sets up Pirtle I don't know but like I say I don't want to guess that length so I'm gonna set this up so it'll do that

guessed length for me that tiny little bit stuck out the bottom of the spindle at the moment that is my guest length is what I'm going to do I'm going to go into the Machine and diagnostics I'm going to need to get a coordinate off

the z-axis and it needs to be absolute machine coordinates so I'm going to reference Alizee and then I'm going to drop it back down to near the touch play itself domi about there now with a touch plate

in everything cell we're going to use the MDI box here and we're gonna give it a code of g91 to go to incremental distance and then give it our probing code of g 31 and we're going to take the Z down in - two steps and of course the

feed rate I'm just going to take that down 25 centimeters a minute so do an execute MDI to get our probe and touch in that's it we're touch there now the coordinates I need are the Machine coordinates here we've got fifty

four point seven so I'm gonna call this 55 so what are we gonna do with this - 55 if we pull up the script again that was writing we're gonna set another local variable underneath the mac instance I'm gonna put in a local

variable of I'm just gonna call it guess Len and that is equal whoops that's a plus is equal to fifty five point not not in fact it's not fifty five it's minus fifty five so that's the first one we got there now we need another variable

that we're gonna put in here of our taller length we're gonna need to get our tall length now and on the crest spindle that I'm using with college I tend to put the bit into the collet and then with a permanent marker I'll just

mark the top there so I know each time I pull that in and put it up to that mark it's gonna be roughly in the same spot every time now the length we need here is from the collar itself to the bottom of the bit which in this case I'm gonna

call it 25 so it's a 25 mil tall bit I'm using here back in Mac four we're now going to go and open up the util table that comes with Mac four new input the length there that's my 25 millimeters in the tall just there so we need just quit

out of that with the tool table you don't have to shut down the Mac for and open it back up like I originally for it it's there it saved it already within the instance that you're working in so let's get that information into Mac four

which is gonna be our first left part of our first reference point so we're gonna have to reference the current tool we need the variable of what the current tall is so the variable for this will have to go underneath the current tool

and is what we're gonna do is make another variable called tool length and that's going to equal that to get the data out of that table now is we're going to use MC to get data put in our instance command

well not command but variable we need for mac for their if you go into your API we're going to be getting the mill M tall mill height I'm gonna copy that across the Mac and put it in if you leave that like that that will now give

you an error you need to insert in the front of it and MC dot just tell him Mac to get the number of it we need to tell it now what's all again what you know what mill height we're getting of that tall from what all the teeth time again

which is the current told of this one we can now close that off more variable times we're gonna stick in a local probe start is equal to our guest length plus our two lengths so we're gonna guess let length which is - well my

machine was - 55 but we need to put the tool in there as well which was 25 mil so it's taken the 25 mil - 55 and added 25 to it yes it will go backwards and the number go down because we're going in the plus direction twist press f5 now

to start off the debugger and jump food our script so we're getting the local instance zero our guest length of - 55 our selected tall which is actually one of my workers got nothing telling us though the current told is number one at

all length is going to our tall table and getting our a tall length and then we're doing the probe star which is equal to the guest length plus tall length so if your highlight your folks start we've now got a minus 30 so this

is going to send our machine - - furry before it does the probe start the quest shift f5 our way at the moment so now we can put the spindle into a spot ready to do the probing that needs to go before the local change - because we want to do

this probing before we change the tool so we're going to copy and paste or type it out whichever you prefer I just get lazy we're gonna move our z-axis I'm going to take the zero out and we're gonna change that zedd we're

gonna add our variable of probe start that will then move our dead access to the minus 30 position according to my calculations put a couple of enters in there just so we slip the skip skip skip scripts up so we can say about this

click yes and you now need to exit l of Mac for we reference your machine home all your access and then we'll start the command again so if I've saved me m6 commands I've shut Mac fall down and restarted it

FF install he has his home and I've set it up in a fictitious spot that's what I'm gonna do is now go to an MDI and tell it we want to change to told number two if I do a t2 m6 will start line two will move our said access is a safe spot

took more than that's one set and then it will move down flop over star precision judging by the height there I never really thought about it much when I put the bit in the beginning there's a bit conservative I can actually go down

a lot lower than that but I can change my 55 and keep changing it until I get to a comfortable spot so that's how far we've got in the script so far so now is what we need to do is add the probing section to it and get a reference point

our first reference point for our tool back in Mach 4 in our m6 script we can now start off the probe in sequence to get our first reference point so to move the machine has before we're going to do an MC control G code

execute wait a little bit but there I just and pass it our instance the code we're going to execute is going to be the same as we done the probe at the beginning just to get our guest length which was g91 then across to G 31 now

I've measured the distance between that to see what I had at that time and there's actually 12 mil there so I'm gonna tell my machine it's actually minus 15 that I can probe to again with the feed rate of 25 these 8 - 15 your

feed rate things like that you can change to your own specifications later on once you find tuning if you want to call it that this now we have probed to our setting tool you know I totally went blank here I can't think what they call

it if it's right I don't know must be getting tired right on the next line we're going to get the reference now of at the end of our tool when we do this by setting another variable I'm going to call this local tour Z and that's gonna

be equal to an MC command c-axis get position it's gonna be our instance number that's normal and we need the axis number of this egg mines number two you need to check yours first to make sure which one it is but

my axis number is 2 for my head that is now going to record our Zed exactly where the bottom of our tall it so it can now copy and paste on the top here and be lazy again as normal and drop it in there because we've got our

reference point we can now take our spindle into the spot where we can change the tool so I can bring this back up there now because we need to run that so everything should be fine down to that point there

something I've just spotted that could be bit disastrous you know it says a little pink I like a box up here that's because I've not closed off our speech Mac so Mac went have run that line at all I put a speech marking it closes it

off that's fine again now so we've changed how at all now to the next one that the message box asked us now our current tall is wrong our tall length is wrong and obviously our probe style is now wrong so let's just correct them and

we can do that by saying that our current tool is equal to our selected tool and our tour length is equal the same as we got here just stick that back down there and again a probe star is equal so once again let's do a little bit of copy

and paste in let's take the command we had here we can take the next line as well copy that and paste it back down the bottom so should pass in our program precision and go to our next reference so that's our second probing done to get

the references correct is what we need to do now is we're going to use an MC dot MC will use the axis set precision precision our instance axis2 and is what we're going to pass the cost of that is what

we got from our first reference point which was tall said and then close it off again we can now take our tall back to the zero position it's now ready to go back to the original coordinates it came from but where did it come from

originally the top of the script let's do a X dot local X dot equals the same as we did with the tall Zed which is this one here let's get a precision of that that's the X so that's going to be my axis at 0 and then we'll do the same

for the Y mine's number one for there so we've now got the star precision excuse me before the machine starts moving we don't need the Z at all at all the lava because you don't want to send your Z back to where

it was your machine code ug code will sort that bit out for you you just want to get the tool changed now on the bottom at the end of your code we can do a straightforward MC MC control yet control that's right and G code execute

wait our instance lost me keys here yep half past six yeah we need to do a G 90 G 0 and we're gonna send that to our X we need to close it off now because we're gonna insert our X is going to be our X start again we won't do that

welcome to dots will go open it back up and we'll do ye which will be our Y Stout and then we can close it off remembering to change that I'll put it twice and that's nearly about to hear one other thing you're

gonna need to do in here it's at the end is we're going to need to set our current tool because we've changed it so we'll use an MC dot MC tour command and we'll use the set current and we're going to set our current tool of the

instance to our current tool no it's not it's our selected tool so our selected tall so quick save press f7 no errors apparently so once again we'll close everything down shut Mac for down and start it back up so it recompiles the m6

code for you and I'll do a quick run of it on my machine to see what happens there's a test I've started up Mac for and I've again put my axis in a fictitious spot they've got into the tall table and amusing told number two

now which is that little dumpy thing it's only 15 mil so I'm going to change the 15 mil like say on top that it's zero is sitting on top of that plate well I'm on tool number 2 so I'm gonna do a command of t1 and 6 so it tells it

to change to tall number 1 do a cycle start again it's gonna go to 0 move to our tall change position it will set itself up for the front start and then do the probing that's the probe finish will now need to

put our tool number one and walk like oh what's up with that box we'll click ok that's probably safe to do with camped out here than in the background again we're setting up up folks start searching for our next reference back to

zero that's how tall change finished now I'm going to send this is a longer tool now if this is wrong and don't forget this is going to push that tall straight through the device or try to just make a mess so I'm going to

send my z-axis to one which is going to be just above it so I got that it's what gonna do is I'm gonna do a probe now put that bit back in the head there would be probe on to this one this cycle start we've stopped there we've got to not

point not three of a millimeter not point three of a millimeter its point naught 3 of a millimeter that's pretty close to me using the Mac for dr.oz but we're not finished yet well unfortunately I've just tech check the

timeline in Camtasia Studio and we're just underneath 30 minutes again and still got a fair bit to do setting some fail-safes within the function I'm still going to compile all this obviously not load it which is going to take quite a

few hours so we're gonna have to run into part three so until part three get right in the code that's already there
