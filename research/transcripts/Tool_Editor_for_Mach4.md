# Tool Editor for Mach4

## Video Information

- **Video ID:** qxKroGC5a1M
- **URL:** https://www.youtube.com/watch?v=qxKroGC5a1M
- **Channel:** DazTheGas
- **Upload Date:** 2015-10-05
- **Duration:** 16:46
- **View Count:** 2,507
- **Downloaded:** 2025-10-16 05:33:05

---

## Transcript

Hi, welcome to another video. Something completely different in this one. It is a tutorial in a way, but it's a tutorial on how to use little tool editor that I've wrote, little project that I'm working on for my own machine. I needed

a tool editor. If anybody here has ever used Inventor HSM or HSM for Solid Works, you you you'll be familiar with this tool setup screen. You got your feeding speeds, general information about your cutter, lengths, diameters, everything.

It's all in there. It uses this to write your G-code and sends that out, which you're obviously using Mac for. But for the project I'm I'm doing at the moment, I needed some of these measurements and some of the feeds and the speeds. So I

needed to create me own tool library within Mac 4. Now Mac 4 does have a tool table.

It will give you your length and your diameter, but it concentrates more on offsets, the wear of of your tool, little bits and pieces like that, they do I suppose they will come in handy for something, but at the moment it it's not

for me. I needed me own. So, in this video, I'm going to show you how to set it up, and you can just use it at your own own will. Unfortunately, I work in metric. So, even on obviously the tool offsets here with the four zeros on the

end, that's pretty good for imperial. But mine's set up and it only uses two knots on the end. So, when you download it, there will be two versions.

There'll be a metric version and an imperial version. And it's only them four knots on the end that will make any difference cuz all all the information contained in it you input yourself. So you can set it to what you want. So

let's have a look and see what this new tool table looks like. So as I said I'm going to show you around it first. We open up the tool library. it will start up blank because we've not told it what tools we've got. Now, if

you're already using the tool table from Mac 4 and you've got some descriptions set up here for your tool change and everything like that, well, I've added that little bit in so you can add a tool. So, we got

three test tools in here. If you click on the add tool until you've got all them in, you've now added everything you've got within your Mac 4 tool to tool table. You can go in now and you can edit any one of these tools. It's not a

screen edit on it. You can't edit on this screen. Another screen will open up in a minute. But once you've set up your tool library, if you wanted to add another tool, you would click your add button. and then that will give you a

blank tool to work on. So, we're going to have a quick look at how to edit a tool. Now, if you highlight a box within the line of the tool number, any one of them will do, and just click edit tool.

This will bring up our tool editor. And like I said, like in HSM, the way it's laid out, I've kept the same feel within this.

Now the first tab on here is the Mac 4 tool table. Everything on this page will come from the Mac 4 tool table here. You can edit the Mac 4 tool table from here.

So, if I was to change this to a 5 mil carbide flat mill and press save, it will update the MAC table automatic. There is no closing it down and restarting Mac 4.

to do it the opposite way round. If you edited something in the Mac 4 table is all you got to do is close this editor down, the new one, and open it back up and then it will reread what is in the Mac 4 table. But I I tend to do

everything from here. Now everything you need is there. It is profile friendly this. So even in different versions of Mac for different profiles, you'll get your own new tool table. So that's your Mac tool table

part of the screen here, which you can set to what you want. Obviously, you've got your these are all stuff that was in the config file for Mac 4 tool table. If we go across to the cutter, we can now set this up. We said it's going to be a

what was it? It was a flat mill, wasn't it? So we can go in tell it it's a flat mill. It's carbide. That's that's on by default, but you can go on unspecified. Your lengths are all the same as what you've got in Inventor

HSM. Bits and pieces like this. If I quickly nip across to Let's get rid of that. We don't need that at the moment.

If I nip across to inventor, I've left this table so it floats on top of everything. So if you wanted to go through here, your flat mill and tell it your diameter is uh 6.35. Your shaft diameter is uh 6.35.

You can copy everything. Whoops, that's bit big that one, was it? 6.35. You can copy everything from here. It it so easy to do. And just go back four. Is there some work? There we are. That's your cutter. You can set

everything up from there. Your feeding speeds, everything again is what you've got within these screens here. It's It's duplicated across. So, you can you can just quickly put these in if you need them. See, I'm

going to be using spindle speeds, cutting feed rates, spindle, which way round it's turning. I'm going to needing those in the project that I'm doing. So, that's why I've got them there. If you're wondering why I want to duplicate them

on the end, just stuck some quick notes there.

Um, like you can put anything in there where you bought it from.

uh how much it cost you for for that flat mill to buy where you anything basically. It's just there for convenience. I know I'm going to use it eventually. Once you've got everything in there that you need, just click

save. You can either quit out of it by pressing the box at the top or just cancel. If you do go into um edit at all and you type loads of stuff on there, just click cancel and it will stop it from saving. There is no delete tool as

yet in here. It's there for a pure reason. If I deleted tool number two out the middle, that means our tool table would go tool number one then tool number three. You can't add within this at the moment. I

am working on a little bit at the moment where you can add your tool at the bottom and then you can swap tool with number five. So it will stick that one down the bottom and it'll stick your clean one within number two for you to

add it. Once you get all your tools in there, don't worry. Your screen's not going to go over size. the screen does it all for you. I've done it this way because Mac 4 table, if I read all that, there's

254 tools within the Mac 4 table. So, that would have just been a nice little scrolly screen for you. Anyway, that's the tool table.

Obviously, anything you save in there, whatever you do by adding tools and stuff, it it's it's going to save it.

That's the tool table itself. As I say, everything's saved what we done. You can change these to what you want. Incidentally, the angles and radius down here are for your different cutters, say sham for mill.

Obviously, the angle of your shamfer there is going to be on it. And well, that's that's the tool table. That that is it. If you do go stupid and click a load of boxes down there and you don't want them, well,

I'll show you during the setup of how you can get rid of them. So, let's um let's install it and get it set up.

Well, I've got it installed, but let me show you how to install it and get it set up. So, with the installation, this is a file you would have downloaded.

I'm just going to extract that. When it extracted, it'll extract to a tool table file. If you open up your Mac 4 hobby directory and go into the modules directory and just move that across into it. Well, that that's the files all set

up.

Now within Mac 4, if you go within your operator and then to the edit screen, place a button obviously where you're going to want it. And then within the script for that, it's just those five lines, which I will paste in the

comments. So you can just copy and paste it. That will load the library up for you.

Like I said earlier, just click. Yeah, like I said earlier, to get rid of all these, if you've been stupid and added a load or you do want to delete something off the end, if you go to your Mac 4 directory, go into your profiles

directory, go to the profile that you was using and the tool tables.

your first tool table there or your bottom one is the Mac 4 tool table. If you delete everything out of there, in fact, if I open that, I can show you. If you delete anything from here and or try and add anything manually from here, Mac

4 will erase it. You will always have that 255 in this one, not 254. You will always have that file showing 255 tools.

So, what you need to be editing is this one here, the top one, the DG DTG tools.

You go in with a notepad. You'll notice there we are.

That's the last one we done. So, tool number tool tool number two. Hang on.

Let's get this right. Tool one. Yeah.

Yeah. We've only we've only filled one in. I can actually take It's Yeah, I can take that one away.

Actually, I think actually I think I should have left it up to number three.

Save that. Anyway, it's give it'll give you the idea. If I go into the tool editor now, it's got rid of that, but we did have them in. So, I'll put them back in. And well, that's it. I hope you enjoy it. I'll be releasing

this. Actually, it's not quite it. I suppose really I ought to show you what to do with the information. Well, from I've created another button in in the editor screen and to get some of the information that was there. Obviously,

we're going to start off and we're going to use the MC get instance to get the instance, which will always be a zero. And then we're going to assign a variable called tool description. And we're going to use

the MC profile get string to get that information from the key we made earlier. So why this works? First of all, we put the instance in. Then we need the key where we're going to, which is in this case is going to be tool

number one, but it can be any tool that you've put there. We're going to get the description from it, which is the next section of that. The last section where it says error is what that's looking for. If it can't find any of these, it

will return. If I stick that in, for instance, it will return if it can't find it, it will tell me it's an error.

Now, to test this, we can straightforward message box from your lure editor.

If you press F5 to start off your debugger, go to F11, which will go to your next line.

F11 again, of course, it's jump forward.

Then we'll get our message box. If we pull the message box up, it says error.

This is what we've put in here because that does not exist in the key table.

So, if we change this now to back to what it was again, F5 to start your debugger off. Press 11. F11 to skip through it. The message box should now bring us this description back what we put in the tool library in

the first place. So, we quit out and back out of there.

Then that's it. Just check them. We'll run the tool editor. So, Whoops. What's that? 5 mil car. Yeah. Where's our screen editor gone? tool editor rather. Let's scroll back into Oh, thank you very much, Mr. Mac 4. You've managed

to label two buttons with the same name. 135. Let's go in and change you to just something else. Different it.

Let's save out of there again. Let's open the tool editor like I wanted to. So, we should be able to get the description from the top there now, which there you go. It's 5 mil carbide flat mill. So, we can now get the

information. We can get spindle speeds.

We we can get any information we like that we've put into that code. It don't have to be a button. You know, a button's an example. Someone done this to me a while back. They sent me a message and want to know a function that

I put out. What uses it in a button?

Well, a button is an example for me to show you. And that's about it.

So, I hope you've enjoyed the video. It is actually the end now. I can't think of anything else that I need to put in there. So, hopefully you all enjoy it and I'll see you in the next video.
