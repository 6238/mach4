# Creating a function for Screen Load Script

## Video Information

- **Video ID:** --Y0pKOz2ao
- **URL:** https://www.youtube.com/watch?v=--Y0pKOz2ao
- **Channel:** DazTheGas
- **Upload Date:** 2016-12-13
- **Duration:** 28:54
- **View Count:** 3,338
- **Downloaded:** 2025-10-16 05:33:51

## Description

Ever wondered how you create a function to use.

---

## Transcript

[Music] well here's a video that's been inspired by Stuart and the spin doctor on the forums can soft limits be automatically on at startup well yes they can to that that's not a problem at all but to Stuart a 2om

minute video really I can do this in two minutes if I spent 150 sitting looking at the screen then I just press the button to turn it on so I'm going to use this video as a basic Bas basis of creating a function to put in your

startup script that then can be run from the PLC on first run but also can be used from a button somewhere else on the gooey so from the Mac 4 main screen I'm going to connect a function to this lovely dormant little

button I really wish I knew what it was there for button I'm sure Brett will be Skyping me later to see um we want to put a function there we want to test it before we put it in our startup script if you put an error in

your startup script it can well it can physically lock your gooey up um cause crashes and then you would have to start Mac 4 there is a way of getting out of it starting Mac 4 up in editor mode but it is a pain you you can't it's it's no

fun trying to debug a startup script so always try your function out of the startup script so that being said we'll go to this lovely button and we use the left doop script to create in here like all scripts you won't need this in the

startup script but get in the habit of external scripts and instances and that so we'll declare our local inst equals uh mc. MC or CM MC get instance and then obviously we need a function that we're going to put in the

startup script so it's to do with a soft limit so set soft limits I'm glad I kept that so short what on Earth is that let's even change that into a function called set limits or function it's nearly Italian and close it off yay i' I've

done my function right in that function now we don't want to do just one Axis or do a function that does all six axis in there we want to be able to if you like go for an individual Axis or all the axis and tell it whether it's

on or off well let's do that we just two passing two variables to it the axis and the state I'm in a state that we want that so when we call that function it would be set soft limits and we would pass it what access

we want to use and whether we want we want it on or off great pretty simply so let's have a look at the function in the AP docs access DF no it's not that one then it's the MC soft limit set State now you'll see in here this is

actually for C++ and C there's no MC lure on there but to convert this to lure is normally quite straightforward if you can Master the art of copy and paste we'll copy that and we'll stick this into our

function now the bulk of it is already there for us if it's going from C++ to lure or you know to get to The Lure version of it just put another MC dot in front of it if it's blue that exists if it's not blue it

doesn't exist within the core now we got our insed we got the access we want to change and we've got a turn on here but we're going to change that to the state so how do we pass it an Axis or a state it's a quick

demonstration we can do a message box here look WX do WX message box to [Music] string now let's pass it something in there now if we look at the API dos we've got an MC on and an MC off and it also requires an INT axis

well we've got Zed AIS there so actually if I take this across across if I copy and paste this into there like that we'll use some of this stuff if I got to use the Z axis that they using here and run this

this should be a nil value Yep this is nil because it's the way it's done within C++ now to make that into the lure so the lure can recognize it like I said before put the MC dot in front on this machine there should be a

two come up this time number two because that's our number two axis so in the function there if we're sending it a zed see my copy and past it is terrible if I'm using the mouse so we're going to pass the soft

set limits MC Z axis to turn on the Zed all that could be y a b same with the state let's look at the state now if we use an MC on well we know that's going to give an error but if it was MC on this should give us a one a one which

is on and a zero which is off just to show you zero there so if we send MC on we don't need that no more Tada why have I just put that in there so let's change that to an MC dot MC on get rid of our message box now

you so this now should run this function here sets off limits tell it it's a z AIS and turn it on that's it finished great wasn't it let's just check that in the screen itself enable machine tell it to turn

on and nothing happens why did nothing happen set soft liit sets off limits access State mc mc on MC Z AIS that should work in Access State well of course does I've only set up the soft limits on X and Y so swap

that over to X then come out right now she should work as you can see soft limits has come on so we know that command is working on a single axis so p in our script our function how would we get all of the

axis turned on because we can we can turn we can turn a single axis on and off with just that one command there so we don't want to go set So Soft set soft limits um x axis set soft limits y AIS and the Z AIS and all that lot and turn

them on let's add something into our function let's add another if axis is equal to M MC um actually we'll keep it in capitals MC all now there is not an MC all in Mac 4 you'll have to keep an eye on you can call this bit what you like but

this is what I've called it in my own script on things I use although it doesn't exist you can you can do this MC do MC all equals that's 20 can it's just a number just a number that's all it is so if axis is equal to MC

all then then we're going to do something else else we do that and then we got the if else [Music] end there you go so that's split up so if if the if axis is equal to MC all then do whatever's in here else if we've

got a different number in there then it will do this this one here so what should we do in there we've got six six axis that we want to turn on or off well we can use the repeat until so if we put a repeat

until tell it what it's until um let's call it um ma axis M axis is equal to six now we haven't got an MA AIS yet so we'll create one local M axis equals now our first axis is zero so that's what we'll

have so this is going to keep running and and repeat whatever's in here until our axis is equal to zero so let's do M axis equals m axis plus is that plus no it's an equal plus one what do we want it to do we want it to

do this six times we wanted to do the inst but now we're going to use the ma axis which is going to be a zero a one a two a three or four or a five actually it won't get to six and it will set the state of

them coolly just tidy this up a bit tidy as they say in Welsh pool so we got a function there MC so we can now do mc.

xmc all MC all so if we run that now Clare a function let's run MCL that should Lo through there now that's it just to check and make sure um we'll put a message box under that there a little debug wxwx message M Massage I could do with a

massage message box two string and what are we going to do the ma axis ma AIS set so if we run this each time on the way through now we should get a message box so we've set zero oops click okay then it goes away

hey that's a f I'm a poet so that's let's set our access one two three four five that's it so 0 to five which is six a Now set up on this machine is 0 1 and two so 3 four and five Mac would would have returned an

error so it's best practice not to have the core return an error if possible so we can stick just at tiny little bit more in here to do a little bit of error checking or not running code if it's going to be

wrong well a load of rubbish anyway back in the API docs if we go to the axis you'll find one here MC AIS is enabled now this a check to see if your machine is actually using that axis and with this function that we're

making anyway if you've enabled that axis then we'll set the soft limits on it if you haven't then we won't try and set the soft limits on it so like before let's take this we got the lower one this time so we can copy that and we'll

start at the bottom script let's just paste that in there just get it so we can read it so inst and our axis ID pretty simple the ID we're going to use is um ma AIS enabled equals ma axis so the first one would be zero when it

yep so we'll copy that now in fact we could have just pasted it so if it equals all we'll put it in our repeat because that Ma axis is going to be changed it's going to be revolving if you like um pull that back so I can see a

bit better so enabled in fact we don't even need the return code on that actually not debugging the return code so enabled equals MC axis in MA axis I'm getting lost here right if fif fif if enabled is equal

to one then do what's in between these two lines not forgetting the nth end shift you over a bit so we're getting quite um quite into it there so local axis local ma axis is equal zero right so if axis is equal to doing them

all we're going to repeat what's in between the repeat and until let's move that over again that up so we repeat until there so enabled axis equals ourm axis and if that's enabled equals 1 then we'll do these with the

message box so let's give that a test F5 right that declares the function so we're going to do MC equals all on we're going to repeat there's our message box for number one which is zero not number one

for zero click okay next should get AIS one access two no I ain't got an access three enabled on here so it's gone straight past it and that's our script at the end so now we know the script is all working for a single Axis or whatever

axis we've got enabled we can move this across into our startup script if we copy copy and paste this into an external editor I find is better so we'll copy that and I'll paste this across into notepad plus and our course I've got to

use this's plug in there makes life a lot easier so we don't need this in there now so we can delete it that becomes my lovely little test button that does nothing again um what AM we doing in there Mac 4

right let's go to our startup script or it's not startup script it's screen load startup script that's really old a it it's like startup sequence on the old computers we've already got our instance declared in here so we don't need that

now do we as normal as possible put all your stuff at the bottom there what I tend to um try and tell people or advis them is stick a section at the bottom just put in it um anything like uh my my added

functions so if you go to change from one screen to another or you're updating something you know all the stuff that you've put is now below below a this is all your stuff below this box here and you can just copy and paste that into a

new screen set so our function was this so we'll copy that and stick that in there the same as declaring that m mc. MC all now I know I've got this in my script and I'm using it and I do keep an eye on obviously the

API docs and things like that now you could you could change this to something different you could you know just do it MC all you could just do it for MC all because then that will only work in the lure version or you could

you know call it what you like just be careful what you do in case Mac 4 decides they're going to start using a mc. MC all later on in something else they develop because if it does then you'll get conflicts but for now we know

they're not using it and this is a demonstration obviously you need to declare that in there as well that's it that's our that's our function within the screen load not startup script as like you keep wanting to

say so we can save that let's come out of it and then we'll go into our PLC script now exactly the same in the PLC script I always put my own function my own part in there like this one I've already set it up

here ready so you didn't have to watch me copy and paste that's nice of me is it and it's my added scripts so this is you know the PLC first run then I'd also put other stuff that I've added in there keep

yourself um tidy if you like if you notice what Brett does in it everything is just labeled you know you can always fine stuff in here especially that big warning so what we're going to put in here anyway we're going to put these in a't

we so let's copy that stick that in there so on our first run it's going to turn our soft limits on coolly that's come out of it yeah [Music] oh which idiot left the message box in there okay let's go back into a go back to our

function and of course it's down the bottom here somewhere get rid of that goddamn message box there we are T right if I close down ma 4 when I start it up I think I was using that one yeah eventually our soft limits are on there

according to it if I enable do a reference yep I think if I remember rightly I stuck these on about 100 there we go we can still use these here absolutely great so that's it um Stuart I'm so glad I spent two minutes of my

time um to show you that but apart from that don't forget you can still use that function to go in and turn turn an axis off if you want or turn them on and off do what you like with them buttons but that's how you take a function add it to

the startup script screen load script and then obviously get it to run only once um within the PLC well I hope you enjoyed that video hope it shed some light on a few bits and pieces especially passing numbers or

integers backwards and forwards between functions and I'll see you in the next video
