# Momentary Switch in Mach4

## Video Information

- **Video ID:** 1Q5YxjsBfT4
- **URL:** https://www.youtube.com/watch?v=1Q5YxjsBfT4
- **Channel:** DazTheGas
- **Upload Date:** 2017-05-26
- **Duration:** 7:19
- **View Count:** 2,032
- **Downloaded:** 2025-10-16 05:33:58

---

## Transcript

I welcome to another Mac for video this one has inspired by Craig cos on the Mac for forum and he wants to know how to emulate a momentary switch basically he wants to switch to be able to turn on what do you want it to turn itself off

after a certain amount of time now there are a couple of ways of doing it and the most simplest way of doing it is to use a WX sleep but WX sleep has a big drawback in the way that it will block the GUI from working so I'm going to

show you the way I would do it from Mac for if you go into your editor I'm going to add a toggle switch what you didn't want and I'm going to call it Tom spin and a text up I'll put it as turned on and the text down as off simple so let's

go to the script part of the down one so what do we want to do we want to turn the switch on I'm going to do this one for five seconds so first off let's declare our instance and that's going to be MC she'd hit instance now timer let's

make a timer well we've got a timer an example comes in the screen load script so if we head over to our screen load we will find a timer panel we're going to use this timer panel within our bond and we'll place that

within here and make room so when you press this toggle button the first thing you're going to want to do is you're going to want to turn a signal on and for the signal at CRS one seed is going to be our output signal spindle on now I

can't see the point of doing the RC code on MC signal get handled because by putting the MCO six spindle on if it doesn't find a signal you'll get lower error because it'll be the MC signal get handle will be nil so

that will give a lower error so you'll never get the our C code on the return from that so we turned the signal on now we need to start the time off which we can do that with timer start and it's in milliseconds let's do this for five

seconds so abdi three knots so five thousand milliseconds is five seconds now to run it once we haven't got the command that is in WX widget which is timer start once five seconds and stop so we have to put the timer stop within

the event here and obviously after the 5 seconds we're going to turn the signal off so we'll change that for state of zero and that will then turn our signal off now if we had a timer for five seconds you press the button then you suddenly

realize you don't want to do it and you want to turn it straight back off we'll take our timer stop and the signal itself will save our changes in there and we're going to put this in the pop script so we'll declare our instance

again and then we'll turn our signal we'll do our timer will turn our signal off but it's what we need to do is we need to find the handle to that signal again in here so back in our down switch we'll just grab hold of this part here

and also copy that into here and that should be it we've exited the editor and there's no errors right so I've put a spindle on LEDs sat down in the corner here so we can test it and this should be for five

seconds so we'll turn the spindle on and after five seconds there she turns off but if you notice the state of this button the button is still in the down position that we want that to come up well we can do that with a screen

property command so we go back into the editor and we'll add underneath there when it's changed all the signals will we'll do a screen set property our button which is tox pin and the button state we want to change to up we also

need to put that in our hot script save everything come out the editor that sound back the right way around so if we test it now we can turn our signal on five seconds ago we'll turn our signal off and put our

button to the state that we require now remember to fall back if you turn saying con you can turn it straight back off as well so it's running as a fallback is just like I said earlier so hope that's answered

your questions CRS and I'll see you in the next video
