# Mach4 Quicky #3 Using wxTimer

## Video Information

- **Video ID:** nkCx2xdoPEw
- **URL:** https://www.youtube.com/watch?v=nkCx2xdoPEw
- **Channel:** DazTheGas
- **Upload Date:** 2016-05-19
- **Duration:** 6:05
- **View Count:** 1,447
- **Downloaded:** 2025-10-16 05:33:32

## Description

Using the wxTimer in Mach4

---

## Transcript

[Music] Hi, welcome to another Mac 4 quickie.

In this video, I'm going to show you a quick bit about WX timer. There's a thread in the forum at the moment where someone wants to turn an input on or off after 30 seconds. Well, playing about, not crabbing anybody off, but playing about

with a PLC, putting timers and stuff in it, if you get an error in that timer, you halt your PLC. So, you do end up with a few problems.

Now there is a thing in WX Lure called WX timer. Now it it's a Windows event and it needs to be tied to a window. But unfortunately you haven't got any Windows in Mac but there is a small workar around to do this. Now, if we go

into our screen editor, go into our screen load script, and at the bottom, we're going to create a bogus panel, something that doesn't do absolutely anything. And we'll call this timer panel. Now, it's a WX panel. It's um not

assigned to any parent or anything like that because we're not going to use it.

To get this running, we're going to assign a variable to the WX timer. And for simplicity, I'm just going to call it timer. Now, you've got to tie this WX time event to a panel or window. So, we put our timer panel in there. That's

what we're going to tie it to. Now, the actual event itself, the Windows event, looks like this.

So, we're going to connect our Windows timers event. Well, it's a wx event timer. Whatever you put in the middle of this function, when the timer gets to the actual time that you've specified, whether it's 10 seconds, 5 seconds, or

30 seconds, it will do what is in that function there. So, for now, just as a function or something to show, I'm going to stick in a message box, if I can remember how to type it, and just a simple hello in it.

So in a minute we'll create or use a button find somewhere to start this panel off panel this timer off. Now when it gets to let's say 10 seconds for instance when it gets to 10 seconds it will display a message

box. But once it's displayed that message box it's going to start the timer again. So then it will display another message box, then another message box. The timer will be on a continuous loop. To get out of this is what we're

going to do is stick in a timer stop just there. So after it's displayed the message box, it will stop.

Well, in fact, with a message box, it won't because the message box um halts the code at that line. It won't get to the timer stop. But if you're doing an input high or output high, anything like that, you'll be fine with

it. You won't be using a message box in a timer. This is just for testing purposes. So, if we save our script that we got there, when I finish babbling, I'm going to use this button here. Start off the

timer. Now to start off the timer is timer start. Now Mac max um MC lure editor will come up with wanting you to put the instance in there. Well, it's not. It's wrong. Don't put it in there. This is where you put how long it's going to be.

So if I said 10 seconds, it's in milliseconds. So stick another three knots on the end. That's it. That will start your timer off. So if we quit and save everything. Now the good thing about timer events, like I say, you're not in

a continuous loop. It's not it's not physically running in your PLC script or your SI sigib or anything like that. Nothing on this screen is held up or it won't interfere with anything. It's tied to the window

itself. So, if I click the button, it will countd down. It's 10 seconds, which even 10 seconds seems an age when you're waiting for it. And eventually, here we come. We get our box that comes up. And of course,

that's now stopped. Unless you click it again. Why I want to do that, I don't know, but just to prove it works, I [Music] suppose. That's it. So, that's all you need to use a WX timer. So, you could start that um timer start off in an M

code or absolutely anywhere you like within your script. Well, that's it for this quickie. I'll see you in the next one.
