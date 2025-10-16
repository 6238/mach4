# unPlugin V1

## Video Information

- **Video ID:** vH0lLcDi9oI
- **URL:** https://www.youtube.com/watch?v=vH0lLcDi9oI
- **Channel:** DazTheGas
- **Upload Date:** 2016-05-22
- **Duration:** 9:25
- **View Count:** 711
- **Downloaded:** 2025-10-16 05:33:35

## Description

Simple plugin to unplug unwanted plugins

---

## Transcript

hi welcome to another video something a little bit different in this video it's about a plugin that it's about plugins how many times have you loaded up your Mac 4 and then down in the corner you've got this little keyboard I can chat

where you can enable and disable keyboard functions to do with the keyboard plug-in well I've got a problem with that within the plugins configuration the keyboard inputs well it's not it's not enabled so how many other plugins have

you got in that plug-in directory for a card or for something you was using or something you might use now and again in a different profile so I needed a plug-in that would sort this out for me so first of all will this plug-in we're

going to need to take the two files and we're going to copy that into our plugins directory then we're gonna stop Mac for again using the Mac for mill out the box as I normally say I'm gonna go to the plug-in

config and turn the plug-in on like it says it will need to restart for that to start working but there's something else we need to do before we need to add something in our screen load script so if we go to our screen load script which

is here and we're gonna add a piece of code right at the bottom now the thing is with Mac 4 when it loads up plugins it starts on the first plug-in in the directory loads it then it goes to the next plug-in and it loads them

individually now to make sure it's loaded everything from the plugins directory before the unplugging plug-in starts why did I call it that because I can't speak that much we don't want the unplugging to run before every other one

of the plugins have stayed so by putting this command in the bottom of the screen load script it won't start the unplug in until everything else is loaded and the screen is loaded everything's loaded up

basically so let's save that and come out of the screen editor and then we'll just shut down Mac 4 and obviously restart again as you can see the keyboard it's still highlighted down in the corner so if we

now go to configure go to our plugins and go to the UM plug-in you'll come up with a screen like this now the keyboard we'll use this one is an example now if you don't want that keyboard to load in fact I'll take out a few more I don't

use Modbus I'm not using the serial I'm not using the shell throw normally I would get rid of the simulator but I need it when I'm showing you stuff as you can see with the core there's no way you're going to unload that because it

will be pretty much stupid so we've got those highlighted if we click apply all the ones that are highlighted in red will not load the next time you start Mac 4 if we shut down Mac 4 and run it again you might have quickly noticed down in

this corner that the Mac for keyboard I can tried to load up there but it was pulled off again by the unplugging we go into the plugins you'll see that it's pulled them all out Mac for day even though they're they're totally gone we

go back into the unplug in down the bottom grid here it's now highlighted the ones that this unplugging is unloading from the core on staff so you know you're not going to get bubbled of them you can update as many times with

Mac for like them install them back in the plugins directory it won't do anything there get unloaded now if you want to use that again you've only got a highlight it so it the reload next time you load up Mac for the shelf Oh will

load with it if you're doing something also and you want to just take something care as a one test and this is actually a good test to see if this will work in this screen load script by getting you know getting unloaded because some

plugins will crash the core and a pocus I tried that one the poke is if you try to unload it once it's loaded you'll just crash Mac 4 so this is a quick test you can highlight one and just click unload and it will tell you if it's you

know ok to unload from the core so the next time around you know you can hide you can't highlight it now because it's already really been used for a function in fact that might be an idea to put on the next one is I'll put that so you can

reset it so you can do that so you know now you could have could have applied that and get that running if you've got a plug-in there that's been obviously in the bottom grid for a long while and it doesn't get update and you

don't use it you can will use the keyboards for an example so we've got the keyboard plug-in here if I hide like the keyboard plug-in and click delete you'll take it out of the plugins directly for you the same even if you do

to what we done Modbus my bus is still there in fact I've done reload you deaf donkey rights I just reloaded everything off-screen so you didn't have to wait you can do everything in bulk and it'll tell you is

what it's deleted so even if my bus Cyril shulk flow have now all been deleted from there and when I start Mac for we look at the plugins now it's nearly I mean I'm using the Mac doing those is not a problem but everything that I need

is loaded into the core anything I don't need gets taken away I think in my own opinion will make Mac for for me a lot more stable and hopefully and make it more stable from you from you for you it's a sandy tee time and I'm tired now

being up on this all day anyway hope you enjoyed the video I've got any questions please do ask and I'll post the plug-in on the forum as usual I'll see you in the next video
