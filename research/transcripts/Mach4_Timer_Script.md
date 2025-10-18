# Mach4 Timer Script

## Video Information

- **Video ID:** wNPMqjkcJ_8
- **URL:** https://www.youtube.com/watch?v=wNPMqjkcJ_8
- **Channel:** DazTheGas
- **Upload Date:** 2018-09-20
- **Duration:** 8:18
- **View Count:** 1,934
- **Downloaded:** 2025-10-18 00:41:45

---

## Transcript

[Music] hi welcome to another video so in the past anybody that's needed a timer event like I use one with the Xbox controller there's various other reasons why you'd use timer panels because you've got a

bear code that the PLC runs too fast to keep updating it so you need another timer just to run it slowly if you like and normally like me I've been using the like the timer panel example here but did you know that is actually a timer

script already built into Mac for well it wasn't then when the timer panel was being used but it is now so how do you use it let's have a look at the time of script if you go in there it's bang there's nothing there so you know how do

you use it if you read the manual which is not that but and it's that one there we are if you need the manual on the timer script it basically says I don't even know which bit I'm reading it away one time a script is fired when a screen

time expires what is a screen time away do we put that the timer script is wrapped in a lower function named Mac timer script with a parameter of the timer number the time apparently F contains the ID of the timer that's

expired not to nine so obviously there's ten timers so let's have a look on how to do it now the quickest way I have found to do this or easiest way to do this is to put something in the timer script and you never have to touch

in and that looks like this physically if timer equals zero do the function that's called timer zero and we're going to create that time a zero function in the screen load script but if the psalm is named one will load time the one or

if it's time or two all the way through to nine so zero to nine makes you ten timers and of course why the end we'll just put an arrow just in case you've entered the wrong time and number though it looks like a lot of else if say

there's no switch statement in Lua so this is your easiest way of doing a switch statement so that that's our timer script once you've saved that you don't ever need to go into that again you know you just don't like nope don't

need it so let's go to our screen load script let's create a simple function at the bottom for our what do we call it timer 0 was it so function timer 0 and I hate working at the end of this file someone em down there simply it's all

I'm gonna do is put a WX message box say yeah hello timer what we time a zero and that's it but how do we start that timer well again that is so straightforward I'll pick on this button here is normal I

don't know what's written in there oh yes I think I've just been messing about with all right so let's start a timer to start a timer we're going to use a screen function of start timer and what do we need we need to time a number how

long it is going to be between each revolution or if it's a one shot basically does it run just once so the timer number was zero and don't forget this function will only start running when this timer has

finished so if I give it two seconds two seconds ago I've three notes on the end what does that have been quick we've got at the end there do you want one of run it once or completely just keep going if

you put a zero on there it will run the timer once do what is in that function and then it will start the timer off again and then do that function again well we only want a one shot so we'll stick a 1 so yes it's a one shot so

let's have a look let's just see if that works for us oh no errors that's not too bad so when I click this button after two seconds that should give me a message box there we go hello from timer 0 so that's how your timer works so it's

another timer event I've set up in here now this is an ordinary Bob basic flat standard button and as you probably know from the properties of these buttons you can't make these flash like the enable button

they have to be a toggle button to be able to do that well this is an ordinary flat button as I say Bob basic standard burn but I've got a timer running on it to make it flash this is for just demonstration purposes so that's a timer

every half a second it's changing if the screen color is gray turn it the green if it's green turning the gray and that's great so what if you wide it to turn off what about to stick that down in this button and it's as simple as that you

stop the timer let's have a quick look at the code for that so to stop a timer we've got screen stop timer zero which is our time a number and then obviously set the background color at button to nothing

basically which is your your screen color and you know that's it what was the bottom code for this just for those who's playing along at home no it's not that button it's in our screen load script the bottom simple as that

basically get the background color I could say if it's green change it to nothing if it's nothing change it to green so that is the timer script well I hope you learned something from that and I'll see if I can find you something

else in future see you next time
