# Creating an M6 Toolchange in Mach4 (Part 3)

## Video Information

- **Video ID:** w1xzYPT27NY
- **URL:** https://www.youtube.com/watch?v=w1xzYPT27NY
- **Channel:** DazTheGas
- **Upload Date:** 2015-10-13
- **Duration:** 26:55
- **View Count:** 8,911
- **Downloaded:** 2025-10-16 05:33:21

## Description

Final part and even left in a machine crash.....

---

## Transcript

Hi, welcome to part three of making our own M6 function. As we said in part two, we need to implement a couple of fallbacks on here.

First one is if we was to get to line 18, it's going to go from line 18 to 19 and start doing our G31.

Now, the one problem there is if you've got a spindle like the Crest one that I'm using at the moment that you have to manually turn on and off, that spindle will still be running when it's going to do its probe.

So, what we need to implement is a little just straightforward wx message box in there before line 19 before the G31 command just to remind the user to turn the spindle off. Likewise, on line 31, I think it is. Yep. Just after line 31, we

need to put in there to remind the user to turn the spindle back on again.

Another thing we need to implement is the to do with the tool length. When we use the MC tool get data and give it the tool number that we want to get, if we haven't filled that tool table in correctly or our M code is selecting

a tool that we haven't set up yet in Mac 4, it's going to come back with a zero.

Now, if it comes back with a zero, whatever bit you've got in your spindle is more than likely going to bottom out. You're going to have a crash with it. So, we we just need to implement something in there that if our tool is zero, that we

could either set it to a a fixed height if you like or we can ask the user to give us our guess length. you know, the one thing we didn't want to use, but this is just a fallback if that tool isn't set in the

tool table.

Incidentally, you'll have to forgive me if I cough, sneeze, backfire, whatever I do. I've got one of the famous British before winter colds.

So, as I said, let's start off before we do the probe. And we'll just put a WX message box in and just inform the user.

Turn off spindle and click okay to continue.

That'll do nicely.

And we can copy and paste that.

Put this before before we send the spindle back to the coordinates it came from. And we can just be lazy.

Change that to on.

Next is the problem with our local tool length. If it comes back with zero, we need to tell it to do something else.

So for now this is just temporary because I have actually wrote a code here which done it which we got we got the length from the user and then continued and in the debug environment it worked absolutely perfect but running

from the M6 command on the MDI it pulled up a wx widget um error if you like. Although you was allowed to continue, it pulled up that error which I didn't like. So, for now, until I find a little work around for

it, I'm just going to add in if tool length is equal to zero, then tool length equals I'm going to say 30.

We're also going to need to obviously copy that down to where we use it again, which is here, and stick that in there. So, that's just a fall back for the moment. So, there probably will be an update video when I

work out a little work around to stop that error from happening because I don't want errors in my code. Even if I mean the error was just clicking okay box. It was informing informing you that this was happening. Although the command

the M6 M6 carried on going, I I just don't want that box coming up. It could cause problems later on. So we'll keep it clean for now.

Oo, spot the mistake.

We haven't closed off our if statements.

That could have caused a bit of a problem. And in fact, we're changing the tool length from here before we've even got the tool length.

So, I'm going to just quickly put that down there.

So, get the tool length, then do it.

That looks a lot better to me.

Well, I've saved my function. I've gone back out, restarted Mac 4. I've checked and yep, this is all working.

But the problem is it's dirty. It's There's stuff in here that's just not needed. We're running the probe start twice with a command that's exactly the same twice.

There's just lots of stuff in there. We don't need this this control G-code execute wait. There's lines in there that does one line and then goes to the next line. It's not needed. We can put that all into one command. But the

reason why it's why I write it like this when I'm writing code is so I can step through each one. If I add my G-code execute weight, and it's actually doing four lines, but in that one, how are you going to tell which part of that G-code

is causing the problem?

So, let's get everything sorted, cleaned up, make it look more respectable, easier to read.

Like I said, let's um clear this up.

Let's start off by going for the probe start. We've got two lines here and we've got two lines here that are both identical.

So for this I'm going to do something that um it basically doesn't say anything in the scripting manual for Mac 4, but it tells you to keep everything within the M6 function. Well, I've been well, I've

got my own screen and I've got a lot of functions and there's a lot of things it tells you not to do. But if you understand how functions work, then well, this is absolutely fine. So, I'm going to put in your own function.

I'm going to call it run probe, close it off, and obviously end the function.

Now because this is a new function and we will be using where are we the probe start here which is a MC control G-code execute weight and the inst we haven't got the inst in here so we're going to have to put that again in for this one.

So it's local inst equals mcmc get instance Oops. What's that?

Do an enter instead. That's it.

So, that's got us that bit. Great. What else do we need in there? Our probe, a probe start we're using. Now, our probe start is made up of our guest length and our tool length.

They're not used anywhere else in here.

So, I'm going to take my guess length.

I'm going to cut it out of there.

I'm going to put that in here.

So, where we probe start on probe start probe start guess length and tool length. So we can take our tool length.

We need them. In fact, we can take the probe start as well. That bit there. So we can cut all that out.

So let's cut that.

And we'll put that into our new function.

And of course, we need to do the probe start, which is these two lines here.

So, I'm going to cut that out.

And I'm going to add that into my new function.

Obviously, we've cut that out. So, we now need to tell our command what it's supposed to be running, which is run probe.

So, we're going to tell that to run.

And we can do the same with this one here.

We can put in a run probe.

So, because we've already got them in our run probe command, we can take these three lines out as well.

And actually, because we're only swapping it over there for that command, we can take that one out. So, it's dropping our code down a little bit now.

And let's just clean up the top.

Now, the problem we've got now is our run probe command is telling this to run.

So it's going to keep doing current tool. Well, in fact, it's not going to do current tool because it's not declared down here. It doesn't exist within this function. So that will quit out. So what we need to do is tell the

function what we want it to run. So if we put a variable, well not so much a variable, if we put tool in here and tell it to run tool.

Now if we pass it current tool or selected tool. Now remember current tool and selected tool are just numbers. So we're going to pass it a number across to there. So to do that the first one we're going to pass across to it

obviously is the current tool.

So that's going to that's going to pass the tool number across to our function which will then it will do our MC tool get data instance M tool height of our tool number. So that's the current tool for the first one.

The second probe it goes along and we need to tell it to do our selected tool.

I spelled that right? Yeah. Whoa. Whoopy me.

So that's our run probe. That's running stuff in there. That's doing pretty fine.

Back down in our function, we're declaring a guest length of -60.

And then we're telling probear it's the guest length plus tool length. So do we really need to declare that as a variable? Well, it's not changing, so we don't. So, we can change our guess length here to a minus 60, which drops

our function down just that little bit more.

Underneath, we got two execute weights. We don't need two there. So, let's let's pop this at the top here. So, after after a variable, going back to your G-code, you're going to need to put your two dots in. Now, we'll open up the next bit

of G-code that we can put in there, and we need to do a new line. The G-code will execute line by line. So, it's going to read that first part, and then we need it to read the next part, which is our probe, which

is this bit here.

So if we was to move this up to here, so it closes it off. It's running both of these all in one. So that drops our command down that little bit more. Our function rather.

By the way, hope you're keeping up with this cuz I'm losing myself at the moment.

So talking about our execute weights, about this line here, it's doing two things.

So, let's let's do a new line and move our coordinates up there.

We don't need that no more.

We're going to do the message box. Run the tool there. Local tool zed is get that. We need that.

Now, after both times we've run the run probe command, we've got this line here sending us to zero.

Run the probe there again. We've got it here.

Well, we can't move them down to the run probe command.

Otherwise, it will bugger up this from getting that. So, they're going to have to stop in. We don't need the message box at the end there no more. We can just put in another one of the set last errors in there.

What if I find out where it went? That's a We can put a in there. Tool change.

Tool change finished.

straightforward and simple.

We've got our message box.

Let's turn the spindle back on.

That'll move our spindle back to where it originally came from.

Got to change the tool within the Mac 4 tool table so it knows which tool it's using. That's okay. And we're on finish.

So that's about it. So, I'm going to save save this now. Quit out of the lure editor.

Restart Mac 4 so it compiles it. Now, I'm going to give it a quick go on the machine.

So, here we are in Mac 4. I've, like I said, I've homeed everything and put the machine in a fictitious spot. This is my tool table that I've set up for demo purposes. got my tool number one. In fact, this according to this, it says

I'm on tool zero, which we don't have a tool zero.

So, we'll go back to our offsets. So, we're in tool number one, which is in the machine, which is my little dumpy 15 mil job. We're going to try and change to tool number one. It's already in there, so hopefully it will tell us that

we don't need a change. Then we'll change to tool number two, which has got the settings in there. Then we're going to change to tool number three.

So to do this, I'm all set up and ready to go. I'm going to go to the MDI tab.

In fact, I'm going to clear all the history out of there.

And I'm going to issue it to change to tool number one. So a T1 M6 command.

We'll execute the MDI.

And like we asked it to, tool change activated, but not required.

So that's fine. We know the first part of our sequence is working. Let's go to tool number two now, which we know the length for. And we'll execute the MDI.

This is the start of our sequence.

It now wants us to turn off the spindle, which is fine. So we'll turn off the spindle so it can continue.

And that's the beginning of the probing.

It started on that small bit.

Probe completed.

Now we can change our tool. We in fact if I get up I can change the tool. I'll change the tool.

That's it. That's our tool change to number two.

We'll start the probing sequence for that one.

We can now turn spindle back on.

And our machine has now taken itself to where it originally was.

So, let's do a tool change now to a tool that we don't know the length of.

Let's go to tool number three. We don't know the length of that one. So, let's give it a go on here.

I'll be glad when I get my new spindle set up, which will automatically turn itself on and off. That does get annoying.

So once again, our first probing spot for the current tool that was in there.

That's all completed.

In fact, I'll get up again.

I'm starting to see the benefit of automatic tool changes now.

So, I don't know the length of this tool, but I normally have a set length of roughly how much of this shoulder I leave sitting out the machine. Oops.

Definitely a bit more of that.

Should I do it up? I'm actually sat here undoing it instead of doing it up. No wonder my videos are so long.

So, that tool's in.

I'm actually running a work piece at the moment, so I don't need to have to tighten it up. So, click okay cuz we've put it in and we've bottomed out.

I don't know why, but I will investigate.

So, back in Mac 4. I've been playing about with it for the last couple of hours now.

The the reason why it crashed is for something at the moment I I can't actually explain.

I've tried a few different things.

If I was to change Um, let's say let's let's change this to a tool not tool number one. We want to change to tool number three. That's where we had our problem. And I'm going to set this tool number one.

Now, if I run the script now and skip through it, that's our first box that's came up to turn tool off.

Tool length. We'll highlight that. And our tool number one. Yep, that's 15.

That's That's right. That's what it says within our tool table, which is 15.

Good. So, I've taken out the actual running of the probe and just put a box in so I can pull that up just to see what happens. So, it would have done our probe there using them heights.

Now we'll change to tool number three. On the second time round on tool number three, it's coming up with this 550493E-216.

Now, I couldn't understand this, but I had a quick look in where are we? This is me profiles.

We're using a Mac 4 mil. This is a Bob Basic Mac 4 mil with just the ESS smooth stepper, smart stepper, whatever it's called loaded. And yes, we know that's changed.

If I look down the tool table for number three, well, it's not actually here at the moment because I've taken it out. That's tool four for starters.

If we look at the Z offset here, it's on zero, which is Yep, that's what it's set as in the tool table. That's fine. But that's on zero because I've put it on zero before I started, just before I done this last bit of the video. Now, back in

Mac 4, we don't need that. So, we can come out of that. Back in Mac 4, we know that's there. Let's cut it out of this. I'm just going to close this down. Yes, you can save them. And I'm going to close Mac 4 down.

And when I close Mac 4 down, it's putting that back in there.

You know, this is strange. So, I'm going to leave that there this time.

Load up Mac 4 with the same profile that I've been using.

Um, what am I doing? I'm looking at the tool table. Now, the tool table still says it's zero, but our command isn't picking it up.

Now, I've tried quite a few different um profiles and it doesn't do it in them.

It's It's something I can't explain. So, I'm not going to use tool number three anymore, just for a bit until I figure out why it's doing it. But I can tell you now that the actual auto change command, it's working perfect. It's

working perfect with the code that we had before we started doing that that test.

So, I'm going to go off now and make another video and see if I can figure out where this strange funny number is coming from. Well, I hope you've enjoyed this um three parts actually roughly half hour each time. It's hour and a

half. That's an hour and a half video to do the auto changer. Like I said, there will be an update to this when I figure out how to get a user input working on the Mac 4 screen from the M6 command.

Well, I'll see you in the next video when I figure out this Z offset.
