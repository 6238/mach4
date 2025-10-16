# Warp9 ESS V2 Plugin Preview

## Video Information

- **Video ID:** Q1-cmC8apPc
- **URL:** https://www.youtube.com/watch?v=Q1-cmC8apPc
- **Channel:** DazTheGas
- **Upload Date:** 2016-03-27
- **Duration:** 14:40
- **View Count:** 3,238
- **Downloaded:** 2025-10-16 05:33:28

## Description

As a beta tester for the new plugin I am able to show you a sneek preview of the new plugin with permission from Warp9.

Its Cool

---

## Transcript

[Music] cool what you think to the new intro well in this video going to do something different I've never done a review or preview or anything like that so I'm going to show you what you're waiting for with the Everet smooth

stepper which I can say is well worth the wait it may seem to you that it's taking a long time to write the plugin but I can tell you from experience I've got a few plugins of my own some custom ones on my machine and you can spend a whole

week right in a routine that you're using that works absolutely perfect and then a few weeks down the road or a month down the road Mac 4 will suddenly think wow we can do it that way now when they change something in the

background it can break what you've written so you've got to rewrite it all again or it can be something like because there's WX widgets running in the background here you could be using a command that's within WX widgets which

the people at WX widgets decide with we're not going to use that command no more so they take it out of their SDK so now you've got to write another routine but anyway apart from that it's very well worth waiting

for this is the beta version I'm using and I can't guarantee what I'm going to show you in here will be totally exactly like the release version there could be things changed there could be things added

in so let's stop babbling and let's get on and have a look so the first thing that hits us when we start up the configuration is the first tab is just some general guidelines on how to set up the new plug-in straightforward steps like it

says is number one configure your pen number two assign it to a signal whether it's in input or an output straightforward well you'll see that in a moment moving across to the generals tab we've got our smooth stepper IP address

we've got a buffer size and we've got the plug-in frequency we can now change moving across to the motors the actual axis settings on here you've got a choice whether you're going to set your Motors as step and direction

quadrature or clockwise and counterclockwise and then we got a spindle settings down here as well the one thing I do like about these is I'm using pwm and obviously there's nothing written down there at the moment but it

would be nice the same as the relay it's probably not been added yet but will be there is this little line at the bottom which is telling you which signals to use in the signals tabs the inputs and outputs those little hints during the

configuration they're pretty much handy for me well I'm sure they will be for you too moving on to the pins config it looks pretty much similar to the old plug-in but uh there are quite a few differences in it as usual the port two

direction and Port three direction of the pins are there the same as normal if you do have an input within a box and you swap it to outputs you will get a warning just letting you know it will delete what you've set up for that

pin your active Lads are all set in here as before anything to do will you port some pins all active low settings should be done within the plug-in config First Column straightforward lets you know whether

you're got an output or an input pin assigned there your Alias now this is optional this is purely for you if you want to assign Port one pin two as X step which I have then absolutely fine it just gives you something to remember

later on what this pin is you're going to assign it to if you don't put it in anywhere else in the config you can refer Port one pin 2 as Port one pin 2 and of course on the inputs it's now been added noise filtering a d bounce

just to help out with some of these mechanical limit switches just to set something up whilst I'm on my way through if I go down to Port three I've got me spindle set there but I also want pin two to be

the direction of my spindle so if I go and swap these over to outputs I can now it's not an active low thank you I can now assign this to spindle spindle Direction Just so you know that's just a reference for later

on when I go to drop down boxes I will find spindle direction if I don't put anything in there the drop- down boxes will still give me Port three pin two so like I said you don't have to put anything in there but it it's just nice

to know later on what it is input signals now this is where some of the fun starts remember in the old plug-in if you enabled if you set up something in your pins config you would then save everything from the plugin then you

would have to shut down Mac 4 open it back up go into your Mac signals configurations configure something there within your signals whether it's an input or an output shut M down again and then start back up well there's

something different here by default all your pins in your PIN config are already enabled within the input signals you're then going to enable an input or disable an input whilst it's disabled it's disabling a signal not the actual pin of

the ESS within the config everything that is in the Mac input and output signals are Al also in here I've already got my limit switches set up they're designated to the ESS now if I all of a sudden decided oh I want

my limit override to be run from a control panel which is right next to the ESS but it's already showing that my limit override is assigned to Something in the Mac mapping of the keyboard or we can over ride that now we can just

highlight that unmap it from the keyboard and assign it to one of our pins I'm going to go for Port two pin three do it that way so next time it loads up it will be mapped to the ESS not the keyboard plugin as I said before the aless in the

pins config it's we're we're able to use port two pin three if you want to go backwards we can now find Port two pin three uh there somewhere which is that one which we're using if we give it an alias and say

um limit override and go back into our input signals you'll find it's synchronizing throughout all these t times whatever you're doing it's synchronizing itself same with the output signals everything is set up exactly the

same as it would be in the Mac output panel I remember the spindle motor that I set up earlier I can now enable the signal for that and tell it it's the spindle Direction now if you see an ESS only written in the mapping then that is an

ESS specific no other plug-in will have that within it one of the coolest features I love in this let's say we had a spindle that used the spindle on we'll assign that to the ESS and that's our spindle

relay now what if we wanted to make sure that every time we turned the spindle on something else would happen as well so every time the spindle turned on I want the dust fact to turn on and I want a warning light to say that the spindle is

running well you can you can now map three pins to one signal on the output T tab tab I'm running out of refere here course that was just an just an example with the dust back and everything but it gives you an

idea of what you can do extra in some of these output signals and input signals and just so how easy it is to set up I found it so straightforward to go in and set up the Homing tab now this is the part that is

probably holding the plugging back at the moment is that's all physically we're waiting for is for the fig part to be done for the Homing and at the end nice white box but obviously you can tell what this is

going to be again this will be the documentation for the ESS just by clicking a button and off you go so I've changed a few signals bits and pieces within the input signals if I now come out of our ESS

configuration and go into the Mac configuration if I go to the input signals now the limit override that we set earlier was originally set to the keyboard well we unmapped it from the keyboard and set it to the ESS from the

ESS config and it's automatically written it into the Mac input signals whatever you do within the input signals of the ESS plugin will reflect within the input signals or the output signals whichever you're using within the Mac

plugin now it also works the opposite way around if we was in here and we wanted to do an input zero assign it to the ESS and let's use port two pin 4 that's what we've got available for inputs let's use that let's click apply

and okay if we now go back into our ESS configuration now our pins config it was Port 2 pin 4 which is there it won't show anything coing here unless you give it an alias but in the input signals if we find input four was it no

input one you can see that it's automatically written that in for us so we know that pin is mapped so we can actually just write that in there um that'll do me just a load of gble just show you it will carry it

across and of course because we've changed something in here if we then went back to our Mac configuration inputs of course again hits transferred it across to here so that's the new pluging that's what you're all waiting

for very much worth the wait if you are ask me just get the home in sorted out and I think there's just a little bit with the prob in left to do but apart from that I love it you'll be very pleased once it is

released well that's the end of another video I hope you've enjoyed watching just as much as I have enjoyed making it and as normal I'll see you in the next video [Music] [Applause]
