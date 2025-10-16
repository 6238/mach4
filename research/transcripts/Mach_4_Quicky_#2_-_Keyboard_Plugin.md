# Mach 4 Quicky #2 - Keyboard Plugin

## Video Information

- **Video ID:** yzaf5pT0l50
- **URL:** https://www.youtube.com/watch?v=yzaf5pT0l50
- **Channel:** DazTheGas
- **Upload Date:** 2015-12-31
- **Duration:** 5:14
- **View Count:** 6,315
- **Downloaded:** 2025-10-16 05:33:24

## Description

Assigning Inputs to Outputs

---

## Transcript

hi welcome to the second mock for kwikki something that came up on the forums the other day in fact it might even be last night was for Mitch be way to know if he could assign the feed hold button to the f5

unfortunately the keyboard plug-in seems to only work on inputs to Mac 4 so this is just going to be a quick workaround of how you can use an input to actually activate an output so here we are in Mac 4 we're gonna go and

configure the keyboard plug-in we're gonna add a new key so highlight the key box pressure f5 which wanted and we're just gonna give it a name of feed holds we don't want the lock key and we don't want to use a function there so we can

leave all them as none and we can click OK click OK again to come out of it and we're going to do something different than what you would probably be used to but we're gonna go into the configuration for Mac and we're gonna go

for the input signals now the feed hold as you can see is actually an output signal but we can't we can't use it it won't be there it won't bring it up so that's not a problem on the input signals I'm gonna go right to the last input itself

because I don't think anybody's got a machine that's gonna go all the way up to there so we're gonna enable that they look for the keyboard and somewhere in there is not our feet hold because we haven't shut down and restart so just

quit shutdown and restart obviously not too fast and we'll try that again you know input signals use our last one keyboard and here's our feet hold there it's okay on everything like that that's okay tan input that's really no good to us if

we go to we go to our keyboard inputs we've got our feet feet old there press f5 so we know that's working but we need to get the feed hold on I've stuck a light on there just so we can see it so if we now go into our operator

go to our edit screen which our P PLC script as normal height enter for any operations light at the end of the script that's what we need to do is disable that four stars always won't be doing much typing

so I need to do is in the PLC get it to look out for the input signal 63 if it finds that this has gone high then we can do something with it so simple little bit of code in the PLC all this is doing is if the signal state of

input signal 63 is equal to one and we're going to tell it to do the MC control feed hold command and that's it if it doesn't do anything if it doesn't find it put signal 63 is 1 then it will do nothing but it's just a

general setup that I use for most things so let's come out of here save it of course however operator and save that so if we now load a g-code file let's do the good old Roadrunner and we'll set this running if

you watch this box said one leaf se f5 it doesn't think because I've still left it turned off down there this is what happens when you do something at the top of your head and no practice no reruns nothing miss f5 now and we're in a state

of feed hold well that's two days quickie and hopefully up bring you another quickie soon
