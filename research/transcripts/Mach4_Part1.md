# Mach4 Part1

## Video Information

- **Video ID:** u5NbpqAuTxQ
- **URL:** https://www.youtube.com/watch?v=u5NbpqAuTxQ
- **Channel:** DazTheGas
- **Upload Date:** 2016-09-04
- **Duration:** 27:51
- **View Count:** 31,974
- **Downloaded:** 2025-10-16 05:33:41

## Description

A quick overview of the Mach4 GUI

---

## Transcript

[Music] Hi, welcome to part one of this complete new set of videos for Mac 4.

Well, in this first part, we're going to go through downloading Mac 4 and installing it and which version of Mac 4 you should be downloading.

We'll also take a quick view of the Mac 4 guey and where some of the controls are that you're going to need for setting up your machine, the configurations of what you're using.

Also going to add in a part of this video of how to install your Mac 4 license once you get it. And also we'll have a look at getting help for Mac 4 software. Just the software side of Mac 4, not the motion

controllers. That will come in a different video. We'll have a look the best practices for getting help as fast as we can.

from the macsupport.com web page. If you go to mac 4 in the software and download section and go to the download page, the one being advertised at making this video is Mac for hobby 2.2914.

Now, this is the recommended version by Artsoft.

Now, you can also go to the FTP downloads page. If you navigate to Mac 4, then go to development versions, you'll find you can pick up a really much newer version of Mac 4, but you must remember these are development

versions.

Now, the other thing you need to check out is the company that makes your motion controller.

Now, they might recommend a different version of Mac 4. So, the one that's recommended by Artsoft at the moment is obviously 2.2914, 2 914.

But if you're using the Everet Smoothstepper from Warp 9, now their recommended version is 2.3118.

Now 2.3118 is still a development version, but there's a bug that was in there that the ESS didn't like.

This is something you're going to have to decide of what version you are going to use.

If it's a development version and you're really um say like if you're using the 3155 then you need to remember there will be bugs in there. There will be things that are just not quite right. So I would not

use that in a production environment at all.

go with the recommended one from Artsoft or your motion controller manufacturer.

For the purpose of this video, I'm going to use the recommended version of 2914 purely so later on in this video, we can go through a few procedures that you want to take into consideration before we update to a newer version that

is released.

So, first off, let's start off the installer for Mac 4.

I'm going to run this with all the defaults.

We're going to go into the Mac for hobby directory.

And that's it. That's Mac 4 installed.

So, we'll get rid of this now. And you should have two new icons on your desktop.

Now, you'll notice the on the Mac 4 icons, you got a nice little shield there. This is just informing you that Mac 4 is going to run with administrative admin, what a word, administrative privileges. If they're not there for any

reason, you'll need to rightclick on the icon. Go to properties, go to your compatibility, and then make sure this box here is highlighted.

And then just click okay.

So, what do we do now? Well, pretty simply, double click on your Mac 4 loader, which will bring you up with this screen here.

Now, the first thing you want to do after installing Mac 4 is to create your own profile.

If you was to open up Mac 4 mill now and set up your motion controller um do any form of screen editing absolutely anything within that Mac 4 mil profile. Now at a later date when a new Mac 4 version comes out and you just

install it and overwrite within Mac 4.

Now, Mac 4 mil is going to be another profile which is going to overwrite the one that you've just done all your work in. So, the first thing I would do is go and create your own profile. I'm going to put this as my mill and then choose a

screen set to use. Now, the standard screen set is the WX4 one. It's a four axis machine and that's always been fine for me. Well, I haven't got six axis so I can't use anything else. So now we have that profile created. We'll click

okay. So this starts up Mac 4, but there's still one more step to do. No, we we haven't selected the motion device yet, but that's not a problem. That will come later.

So from this screen here, if you go into your operator and then edit screen, go into the screen and then save screen as I'm going to call this again my mill for a simple reason. We was using WX4.

Now again when you install a new version of Max 4, it will come with another screen called WX4 which will overwrite the one you've been editing. So if we go to save and then we'll quit out of the screen editor.

And now we can see which profile we're using and which screen set we're using which is down in the bottom right hand side here.

And you will find this tool path doing this now and again if you click on a white area out there for some reason it comes back. Don't know why it does it.

Never have known yet.

Now to get a general feel of Mac 4 there is a simulator plugin included.

Sometimes this is not already especially when making a new profile this is not enabled.

So, if we go into our configure menu and then go to Mac configuration, you'll find a tab here called plugins.

We're going to enable the plug-in for that. Click okay, apply, and okay.

Again, you can't. Obviously, the simulator is not there yet because like it's told us, you need to shut down Mac 4 and then reopen it. So, the next time we open our profile, it's now asking us same as before, but

the simulation device is there. So, we can now tell Mac 4 that we're going to use the simulator.

any other plugins like the ESS, PMDX, etc. will also come up in there if you haven't chose a motion controller.

Another thing you'll need to do within the configuration to get the simulator working, if we go back into our Mac config, we've already got some motors. They come with the simulator, but they're not mapped to anything at the moment. So, if

we go and set these like so, it just gives us something to play with. We click okay on that. If you go to your jogging tab now and enable your machine, you'll see now that your X, your Y, and your Z are all now working. You can now

start using your reference all home. The simulator will do all that for you.

You can now open a G-code file. Road Runner is a pretty good one to mess about with.

And we can do a cycle start and get it off going eventually.

Now that in demo mode you can play about with Mac 4 for as long as you like. The time limit comes on the cycle time. This is in a cycle now. So, your time limit would be running on this, which is an average between five to six minutes.

I really wish it' get to that spindle start. That's it. We're gone.

So, we can we can play about Well, you can play about with that.

So, we'll stop that now and close the G-code file.

The most common places to go in Mac 4 is when configuring anything in the machine or if you're doing any scripting.

Now they can be found within the configure menu. Mac will bring you up all the configuration about your plugins, inputs and outputs, mapping, motors, general stuff really.

Once once you've got plugins in there like your motion controller, they will come up underneath the plugins menu.

There's no point of showing you on here because this is just a demo obviously, so there won't be much in there. Now, when you come to scripting, you'll find on the forums that people have been talking about the

screen editor and the startup script and your PLC. Well, they can be found in your operator menu. If you go on to edit screen, this will bring you into screen editing mode. We're not going into this now.

This is in a future video, but the place to find your startup script etc.

is highlight your uppermost in the tree. This will bring you to this properties tab here and you will need to click on the events tab beside it. This is where you'll find your startup script, screen unload

script, PLC, and the signal script.

Now, your signal script you really won't be using all that much, but your screen load and PLC you will.

Clicking on any of the boxes for any of the scripts within the editor will bring you up into the MC Lure script editor. Very good editor this is.

And you've obviously got all your debugging so you can actually step through the code and see what it's doing.

Of course, you just quit out of anything. Anything that needs to be saved in it'll ask you to do it.

and tool path once again.

So what happens when things go wrong?

Well, from time to time it can be for absolutely any reason at all. You've gone into the screen editor and you've been playing with the script from a button for instance.

Now when you close Mac 4 down and it finds there's an error in one of your scripts that you've done like the screen unload script for instance. Now it's going to cause an error within Mac 4.

And of course because there's an error you'll you'll get locked. If I went to my task manager now, Mac 4, the Mac 4 core can sometimes lock if you've made mistake in your script. And because that's locked,

you might not get your screen set saved correctly, you may not get your machine in saved correctly. Now, if you don't get your machine in e save correctly, then the next time you start up Mac 4, it's not going to work properly. In

fact, there was an error there from something I've just done within Mac 4. In fact, I'm going to try and do that again. I think I know what it was.

Yep, I've reloaded Mac 4 now just so I can show you what I was on about. Now there is an error when I was shutting this down and earlier on I actually edited the machine in file and stuck two two sections of plugins in there to

cause an error. Forgot all about it. Of course there is a warning to say that there is more one group of plugins. So it's it's going to find a double of each one of them plugins.

That's just to show an error. But it's what I want to actually show you. Now, if if you do get an error, if we come out of Mac 4 and then go back into run it, if you've got an error in your script in your machine and it won't load or

it's causing you problems, if you click on your profile and then restore a backup, now Mac 4 is making backups of your machine. mini, you're going to need to go back just enough time to get rid of that error.

So, if I went back to say 1330, which is probably enough time to get rid of whenever it was that I messed about with that, and we'll see if it's gone. Now I've gone, yeah, I've gone back far enough to where I didn't have a motion

device actually connected, but everything else that was done in there would have been in there. Now, talking on the lines of playing it safe, if you go into your help menu and go to support, you can package your current profile.

Now, mine's called my my mill. I'm going to stick this on the desktop and I'm going to save it on your desktop or wherever you saved it.

That's totally backed up your profile.

It is in fact it's just a renamed zip file. So, you can open it and have a look inside. It saves your screen set and it saves your profile. If you ever need to delete Mac 4 off your machine, then this is ideal. You've got a

complete backup of your profile. So, you can just import this back into another version of Mac 4 or in fact on another machine. If you're running a development machine and a production machine, then you can transfer this backwards and

forwards.

So, probably now is a good time to show you um updating Mac 4. Just some of the things I go through when I'm updating is we've just done it. I back up my current profile. I will always do that when changing anything in Mac 4.

I do go that little bit further forward when upgrading absolutely anything on my machine. Um, if I go into this one, it's probably there. Nope, I haven't done it in a while. But I actually back up the whole of the directory. Now, the reason

I do that is because we've got modules, obviously, modules in here, which are lure programs and stuff. I do make the odd edit in some of these files if it's not working to the way I I like it. Same with the wizards.

Um the well none of them actually but some of the wizards that I use in other profiles they've got the same name as what comes with Mac 4. So when you do update it it's going to overwrite them and I lose the parts that I've edited

within them files. So anyway to upgrade upgrade or update Mac 4, obviously you can't have it running.

So, we're going to I'm going to put this to the latest development version this is which is 3155.

Now, you will notice when you come to the installers that they change. I'm going to go in my original directory there's some new profiles added in this updated one. All the core is exactly the same.

um is all you're getting is three extra screens. In fact, you're actually getting two extra screens. One's for the lathe, one's for the router. We're using Mac 4 mil. Now, you can update that if you want. You You don't actually have

to, but this is like what I told you before. If you would have edited Mac 4 mil, this is now going to get over overridden.

So, we'll install Mac 4 as normal.

And we're all updated again. So you can run Mac 4.

And there's our my my mill. It's still there within our profiles. And we can just open it up as normal. Yes, I know I bucketed that up earlier.

Get our screen loaded and back to exactly how it was before.

Now, if you was to go into your Mac 4 directory for any reason, I'm not going to I'm not going to do this so you have to watch me um install Mac 4 again. I'm going to delete the profile and the screen set.

That's that one there.

Now, if you've just installed the Mac 4 on another machine, you're obviously not not going to have your profile called MyMill.

So, you can now import your profile, which is on our desktop, my millill.

We can open that. We're going to keep it with the same name.

We've now imported that into another version of Mac 4 on a different machine development production whichever one it is.

Um for profiles my macros is not valid.

We know or we don't know actually. I don't know why that is like that but it's just a um tutorial as such. So I'm not going to go into that at the moment. I don't think the macros directory got backed up

when we backed up our mill prof my mill profile.

So that's more or less about it for the part one apart from where do you go to get help? Well, there's a few places to get help on Mac 4. If you go to your Mac 4 hobby directory, now there are docs in here. There's your

general um docs for your controller config, programming, operating Mac for scripting manual, stuff like that. But one place you can go to get help is the Mac support forum. Now, from the main page, if you go to the Mac 4 general one,

you'll come up with this page here. Now, when you got problems with Mac 4, you're just starting out or even if you've been using it for a year and you've come across something that's, let's say, in a development version, post it on the

forum. You know, absolutely great. It lets everybody know there is a problem.

or it might be something absolutely simple that can be fixed straight away. It it helps developers. It helps other people creating machines and you know it just gets you out of some of the most simplest of situations that you can't

figure out why it's wrong. But it can be something so well just so stupid.

Now if it is a really bad problem, you know, really bad software problem. Now there is there is actually a if you go into um where are we? Support here and go to Mac help desk.

If you register there, you can actually send send in a ticket for a problem that you're having. If it's if you're not the sort of person that wants to be on the forums and just wants to keep everything

personal, then there is a ticket system there for you to go and send something through to Mac 4. But like I say on the forums, you will you will get most of your stuff answered on here and a lot of it's

probably already been answered before as well.

And remember the backup that you made the um profile backup my mill. Well, that is pretty important when you're on the forums having a problem. If it's a setup problem, you might be asked to post your machine in e or anything like

that. It makes it a lot easier for people just to import that profile to their own machine so they can go through all your settings and see if there's anything you haven't set up correctly.

But anyway, so the last thing I show you now is the installing of the Mac 4 license.

From Mac 4, if you go up into the help menu and go to the about, you've got a PC ID.

Now, when registering your software, you'll need that PC ID.

So if you copy that and then go to the Mac 4, this is the account you created when you bought Mac 4. And you'll need to enter PC ID in here.

Now after entering that, you'll be sent an email with your license information in it. So from Mac 4 is all you'll need to do is load license, go to wherever you downloaded your license, which mine's there, and then

click open. It'll install a license for you. To check to make sure it works, you'll have to come out of Mac 4, restart it, and if everything went okay, once Mac 4 starts up, you should it's now registered. It's now Mac 4 hobby

because well, it was a hobby license.

And well, that's about it.

And well, yeah, I can't really show you anything more than that on an intro just to get you up and running.

Part two will be along shortly and it's all going to be about motion controllers.

So, I'll see you in part two.

[Music]
