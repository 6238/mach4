# Mach 4 Lua Capabilities

Total posts: 88

---

## Post #1 - Michael Woodrum

**Time:** 2022-11-16T11:38:30.212Z

I’m going to start working through porting my mach 3 macros over to mach 4. I use the 2010 screenset and the m6 macro is the only thing I want from it in mach 4, everything else I’ve made should be easy to do.
In the setup portion of the m6 macro you first measure the z height of the stock and then the bit moves over to a fixed position and records the difference between the two and does that.
When m6 is called during a job, the spindle stops and moves to the tool change position. Swap tools and then moves to the permanent plate to touch. Recall the saved difference between the plates and use that variable to set the new tools height.
I’ve never used lua but it looks much better than vb. At least it looks more like what I expect to be a programming language.
I’m sure it’s possible to do this setup but are variables able to be stored long term and then recalled for a macro later on? I found some videos from 7 years ago about an m6 macro that almost does this except that it doesn’t seem to to the setup portion that allows you to use 2 plates. One moveable and one fixed to get the difference variable stored. It seems to only use 1 fixed plate and I need to use the surface of the material as the first touch position.

---

## Post #2 - Eric

**Time:** 2022-11-16T12:34:29.916Z

You can store values in a “register” in Mach 4. Basically scripts can drop values in there and other scripts (or the same one) can recall that value later and even do things like do math on it.
I’m not really an expert but that should get you something to do some research on.

---

## Post #3 - Michael Woodrum

**Time:** 2022-11-16T13:11:47.065Z

That’s what I needed to know. Thanks. I’ll play around until it makes sense

---

## Post #4 - Eric

**Time:** 2022-11-16T13:45:25.578Z

Let me know how it goes. I’ve been doing some lua hacking/learning myself for fun. I’ve actually been working on an M6 script too that works in a similar way.

---

## Post #5 - Michael Woodrum

**Time:** 2022-11-16T13:58:08.525Z

For sure. If I get somewhere with it, I’ll post it all. The window editor is better in mach4 for sure. It still has some terrible aspects to it though. Touchy and no undo action either.
Having that manual m6 macro is one of the best things for my setup. Being able to load a file with all operations and knowing I’ll get through it without being off on cuts is reassuring.
I also created a rotary touch setup when using my rotary in mach3 that I’ll have to make again. It allows you to mount a rod. Probe both sides by stepping over the rod and setting the center as y0. Then mount the material to touch off and know you’re on the spot. M6 setup then does the same routine to get tool changes working. With rotary I never end up with my original material touch position and changing tools without that m6 setup is much harder.

---

## Post #6 - Eric

**Time:** 2022-11-16T14:00:19.406Z

MichaelDot:
I also created a rotary touch setup when using my rotary
I’m pretty certain we automated all of this for rotary in Mach 4. Before you embark on building something yourself for rotary check out what we have done.

---

## Post #7 - Michael Woodrum

**Time:** 2022-11-16T14:01:17.729Z

Ok. That’s good to hear. I will look at that and hopefully it works with my custom one.

---

## Post #8 - SUBNOIZE LLC

**Time:** 2022-11-16T17:39:49.364Z

The thing to remember is Lua will NOT stop executing when you hit the e-stop.
It will continue to run to the end of the script unless you poll that signal and self terminate.
Huge difference between Mach3 and Mach4 scripting.

---

## Post #9 - Michael Woodrum

**Time:** 2022-11-16T17:53:22.299Z

Wow, ok. Interesting. So poll every step just in case of errors? That would also mean that if you give it a coordinate to move to and it’s in the middle of that movement it doesn’t stop on estop?
I’ll have to get some basic things working and think through safety before trying too many things. I would hate to crash while testing and break something

---

## Post #10 - SUBNOIZE LLC

**Time:** 2022-11-16T18:33:34.229Z

MichaelDot:
That would also mean that if you give it a coordinate to move to and it’s in the middle of that movement it doesn’t stop on estop?
No, the Mach4 core will stop but things like scripts for tool changes will suddenly execute all the way through with lightening speed.
Since you have an ATC and if you don’t do the checks then all of the moves will return with no errors. Thus to the script the tool change was successful.
Now you have the wrong tool in the spindle.
Also, if you are actuating the draw bar then when you hit the e-stop or stop button during a tool change the stupid thing will just drop your tool.

---

## Post #11 - Michael Woodrum

**Time:** 2022-11-16T18:41:09.725Z

Sounds fun. I don’t have an atc myself. That would be awesome but the cost needs to go into building my shop instead.
I’m just trying to create an m6 that allows you to manually change and touch off a permanent location to determine the difference and then start the next section.

---

## Post #12 - Michael Woodrum

**Time:** 2022-11-16T18:43:31.939Z

So could you build in checks at each step and then exit the script if it reads that the app has occurred?

---

## Post #13 - davidcnc

**Time:** 2022-11-16T18:56:30.789Z

subnoize:
Also, if you are actuating the draw bar then when you hit the e-stop or stop button during a tool change the stupid thing will just drop your tool.
It just wants to play fetch

---

## Post #14 - SUBNOIZE LLC

**Time:** 2022-11-16T19:11:41.936Z

MichaelDot:
So could you build in checks at each step and then exit the script if it reads that the app has occurred?
Yeah, and sadly Lua is an engine that just makes the C/C++ objects available, no exception handling or anything like what you get with a professional developer language like VB, Java or Rust.
So you have to ask for the error codes back and check if they are positive and then if not check what they mean from a table.
Then you have to check the signal if you didn’t get an error code back. Then you perform whatever you need for that signal. So if you do it right it’s;
Ask for signal handle
Check the error code to make sure you got the handle for the signal
Ask for the signal state using the handle
Check if you got an error code
If not act on the signal state you got back
So some signals are not available on e-stop or Cycle Stop and will give you an error when you ask for it YAY!
Some will not error out but will tell you when things are not moving for some reason and you should stop (aka, cycle pause).
Blah, blah, blah… I really hate the scripting interface to be honest. But from what I have learned is the guy who knew it and coded it left and they can’t find anybody to fix the bugs in the system.
I open bugs and they (newfangled) just closes them. They won’t even comment on them. Very frustrating.
When I asked for the full plugin API they said they only offer that to companies writing motion controllers. I said COOL! I am a company writing motion controllers… They never answer me back.
ModBus is also broken and they will just close your ticket if you file one. No response, no comment. So in ModBus you DO NOT have floats or 32 bit INTs.
Can you tell I am less than pleased with Newfangled?
Oh! You have to do the get signal, check loop for each signal so like cycle stop, cycle pause, e-stop are all separate. You have to do all three to find out if the machine is truly stopped.
Lastly, cycle pause?
You can’t pause a Lua script… Just throw the e-stop and die. I guess you could also just disable the pause button during scripts…

---

## Post #15 - Michael Woodrum

**Time:** 2022-11-16T19:36:05.251Z

Wow. I was reading through the lua programming guide from them and started thinking about being able to make some robust things. Then you just say that it actually doesn’t, cleanly at least.
Crazy that they can’t find a dev capable but maybe the code base is huge and not documented. Nobody wants to take on that mess these days.
Modbus was always something I wanted to work with because of interfacing different devices capable of handling many complex external procedures and returning to do work internally again. I can think of many things that would be great for. Many pneumatic systems for holding in different areas at different times. Interfacing with robot arms for material handling. Anything really.
Did they already give up on this software after they made this replacement? They abandoned mach 3 because it’s easy to steal. Now they do the same with this. I wonder if management there isn’t anyone wants to work with.

---

## Post #16 - SUBNOIZE LLC

**Time:** 2022-11-16T19:57:18.286Z

MichaelDot:
Wow. I was reading through the lua programming guide from them and started thinking about being able to make some robust things. Then you just say that it actually doesn’t, cleanly at least.
I would imagine that more is exposed via Lua than was VB. The very little VB I have ever done with Mach3 was very basic.
In that Lua guide you will find the very page the developer was fired on
And I am not kidding about that. See if you can find it
MichaelDot:
Did they already give up on this software after they made this replacement? They abandoned mach 3 because it’s easy to steal. Now they do the same with this. I wonder if management there isn’t anyone wants to work with.
RUMOR (as in might not be a shred of truth) has it the dude writing v4 got crapped on my management. He told them to toss off and left.
He had a cross platform core finished and was in the final stages of building the UI. So there would have been a Linux and a Mac version (if you read far enough in the docs you will find these references so that part IS NOT rumor). After he left , the owners (who apparently are not coders themselves) couldn’t find competent help for what they were paying the guy who left. They had hired people to fix Mach3 after that original guy left for exactly the same reason. This guy on Mach4 was their best guy for fixing Mach3. But they sat on him too and so he left. The next people in (and its a rovling door now) are clueless.

---

## Post #17 - Michael Woodrum

**Time:** 2022-11-16T20:19:37.543Z

Well, with so many open source variations of controller software out there now, they will not catch up.
With a $4 microcontroller and a $60 open source breakout board I get great motion on other devices I’ve built. On top of that I can interface with the hardware in any way I can think of. Web interfaces for ui that are infinitely configurable too. Just controlling a laser I built and a sand table with 2 axis in my living room. The sand table has an interface I built so that visitors can draw with their fingers on a tablet and it outputs gcode to draw their drawings.
Not giving api access to everyone is insane. What the community would build for them for free or sell themselves to extend the capabilities without any output on their end could make licenses sell themselves.
Sometimes it’s hard to understand the thinking of management types. Maybe a lack of imagination or an understanding of what communities that build themselves on a software as a platform can do for the company without work on their end.
I wonder if the access to code for controller manufacturers means they literally get the entire codebase to work with. Instead of a proper API with core access.

---

## Post #18 - SUBNOIZE LLC

**Time:** 2022-11-16T20:44:21.461Z

MichaelDot:
With a $4 microcontroller and a $60 open source breakout board I get great motion on other devices I’ve built.
I cut a PCB on my Bantam for 3 RP2040 and a Whiznet 5500. The PIO pin control is much higher frequency capable than anything that FPG Warp9Ltd uses for the ESS. And its less than $2 per chip in singles. That FPG is every bit of $99 per chip in reals.
Total cost of replacing the ESS is $15 and I would be making money on that
All of my other 6 machines are LinuxCNC and so will my AvidCNC PRO60120 be sooner than later.
BUT! Gotta finish the dern carousel first
MichaelDot:
Sometimes it’s hard to understand the thinking of management types. Maybe a lack of imagination or an understanding of what communities that build themselves on a software as a platform can do for the company without work on their end.
They don’t code! Problem
#1
. And their entire product is code.
They depend on others so they flap around in the wind like a old pair of underwear on a flag pole.
If you are a business owner and a coder then you have a passion for it and you treat your product differently (aka you actually OWN it).  These people are holding onto something that have no control over at the end of the day. They can’t let it escape their clasp or they wake up tomorrow and have nothing.
MichaelDot:
I wonder if the access to code for controller manufacturers means they literally get the entire codebase to work with. Instead of a proper API with core access.
Nope, just the header file. Which I could reverse engineer to be honest but why support these turds?

---

## Post #19 - Michael Woodrum

**Time:** 2022-11-16T20:50:49.433Z

Are you building these boards on your own design or something available already? I’ve not used Linux CNC myself but I’m sure I can learn.
Are you currently running your avid setup on this board?
Getting boards made with surface mount components and tested is pretty cheap now. I wouldn’t mind owning the whole chain capability for fun and maybe profit. A pick n place costs so little to make now.

---

## Post #20 - SUBNOIZE LLC

**Time:** 2022-11-16T21:04:13.371Z

Oh, I cut my own PCB in-house!
But like my other stuff, when it goes into production I find an ITAR house in the USA and contract them to do it.
But, yes I have the first iteration of the board. It comes in as Ethernet (Whiznet 5500) and the the first RP2040 breaks it up to the other two chips. Each of the 3 RP2040s then control one parallel port each. Your ESS is 3 parallel port emulator.
The PIO API that Raspberry Pi offers is really, really cool because it put zero time on the MCU, so you get parallel port pin IO for free.
That part is done! Took 2 hours in Eagle CAD / Fusion. Took about 2 hours to cut, mask and reflow the components.
Probably will take me the next 2 years writing the LinuxCNC driver
Carousel FIRST! Too many pokers in the fire.
Besides! Do you would want vibration / ringing reduction first or is Mach4 bothering you that bad?

---

## Post #21 - Michael Woodrum

**Time:** 2022-11-16T21:11:28.994Z

When asking about building on another board, I meant design only. Not using other boards.
The 2040 chips, I forgot they were easily purchased for use. I knew that and forgot it. Fun to think that this is so easily built nowadays.
I have used a whiznet Ethernet for a lora gateway I built at some point. Needed to interface into my automation system with things in my yard. I cannot remember what version that was. It’s been years and going without issue ever since.
Good luck finishing the first project. Halfway into one thing I see potential in another thing I discover during the first project from what’s learned along the way. Then I start another thing. Continue that until I die, I think.

---

## Post #22 - SUBNOIZE LLC

**Time:** 2022-11-16T21:23:11.199Z

MichaelDot:
When asking about building on another board, I meant design only. Not using other boards.
It is a straight replacement for the ESS. Take out the ESS, add this thing in, connect the ethernet to a RPI running LinuxCNC, done. Nothing on the AvidCNC side changes. Just your motion planner
Active vibration and ringing reduction is definitely top of my list. I will have the electronics package for measuring it by next week some time. Talk about a pretty penny

---

## Post #23 - Michael Woodrum

**Time:** 2022-11-16T21:32:46.739Z

Is that just an imu on each axis?

---

## Post #24 - Michael Woodrum

**Time:** 2022-11-16T21:33:41.426Z

Also, I’ll buy it when you’re done. Definitely

---

## Post #25 - SUBNOIZE LLC

**Time:** 2022-11-16T21:48:31.574Z

MichaelDot:
Is that just an imu on each axis?
Sort of, just an accelerometer like this little monster;
sparkfun.com
SparkFun Triple Axis Accelerometer Breakout - KX134 (Qwiic) - SEN-17589 -...
This SparkFun Triple-Axis Accelerometer Breakout is a simple Qwiic breakout for the KX134 digital accelerometer from Kionix.

---

## Post #26 - Michael Woodrum

**Time:** 2022-11-16T21:49:59.135Z

Makes sense. That way you can do what klipper does to allow fast printing without reducing quality.

---

## Post #27 - Michael Woodrum

**Time:** 2022-11-18T13:46:49.164Z

So, I am starting to add things to my screens and testing them out. However, I would like to add the functionality to windows that exist already and the isn’t editable source for the modules from avid.
Is there a reason we cannot access the source for those? They are all compiled but having the source for the modules would be nice. That way I can remove things that would not be needed, reuse registers and design things to work along with them instead of completely separate.

---

## Post #28 - Eric

**Time:** 2022-11-18T14:32:02.826Z

Michael, as far as I know you can edit the screenset. When you’re talking about editing windows, do you mean things like the touch plate utility (stuff that pops up in a new window?)

---

## Post #29 - Michael Woodrum

**Time:** 2022-11-18T14:44:21.908Z

Yes. That’s what I mean.
I decompiled the code and I’m looking through it now. I didn’t realize it was fairly simple bytecode compiling.
Found a utility and have the lua now. It’s 13418 lines!
That’s not fun to sift through. I’m going to find ways to make it easier to work with the code. I’ve never used lua and mach seems to pick things nobody wants to use when programming.
In case anyone wants to decompile, just use this from git.
GitHub
GitHub - HansWessels/unluac: fork from http://hg.code.sf.net/p/unluac/hgcode
fork from http://hg.code.sf.net/p/unluac/hgcode. Contribute to HansWessels/unluac development by creating an account on GitHub.

---

## Post #30 - Eric

**Time:** 2022-11-18T14:59:26.841Z

Can you walk me through what you’re decompiling, and why?
I am no expert at all in programming, but anything I could imagine you want to do should be editable right inside Mach using the Zerobrane editor, including I believe PLC scripts.

---

## Post #31 - Michael Woodrum

**Time:** 2022-11-18T15:03:50.963Z

I didn’t know about that zero brain editor. I’ll see what it gives me.
I want to modify the touch plate setup. Add another touch plate and have settings to give machine position of that plate.
I need 2 types of touching. One for of I’m only doing one tool the whole time that would only use the normal touch plate setup. A second one that touches the plate on the material, moves to the second plate and touches. Records that difference in height to store for m6. Then, the mtc script would be the same but adding the step to move back to the fixed plate and touch. Then subtract or add the difference obtained during the first setup.

---

## Post #32 - Michael Woodrum

**Time:** 2022-11-18T15:05:24.766Z

Nevermind, I’ve been using the zero brain editor but, you cannot access the luac programs in modules. They are compiled. Decompiling works but, it’s huge and no ability to run it because it’s referencing things that aren’t available while writing it.

---

## Post #33 - Eric

**Time:** 2022-11-18T15:17:57.159Z

Again, huge proviso here that I am NOT a great programmer, and I am very new to hacking around in Mach. Here’s what I do know: Screensets are compiled on the fly and you CAN edit them, and do that exact M6 script you want. I’ve done a similar thing myself.
It took me a while to get my head around the fact that there are modules that you can edit, but you can’t edit them because they are compiled, but in certain situations they are decompiled so you can edit them, only to have them recompiled again.
I’d give you my script, but it’s crap and it doesn’t come with the knowledge that I gained by going on the journey to make it, and learning what I tried explaining in a very confusing way above.
Definitely check out the Lua scripting guide on Mach’s side, the API reference that ONLY in the Mach directory, the Lua examples that are in there as well, and also this:

---

## Post #34 - Michael Woodrum

**Time:** 2022-11-18T15:26:56.079Z

I just saw that video as recommended on YouTube. I’ll have to watch this and mess around more. I really like being able to use program languages on more than 1 thing ever. I’m going to devote time to something that may not be fruitfull. I’m a little less excited about this now that I’ve seen how convoluted it is.
Thanks for the link and some explanation. I’ll see if I can access those screens somehow through the mach interface instead of external tools. Hopefully they do decompile to work with them in a way that allows testing.
Also, I wouldn’t mind looking at your code even if you’re not happy with it. I am doing this all in simulation and not on the actual machine. I know how harmful that can be already. I’ve got an extrusion cross member to remind me.

---

## Post #35 - Eric

**Time:** 2022-11-18T15:36:57.916Z

You basically are forced to use the internal tools. When you go into screen editing the screen is decompiled so that you can edit it. Once you exit the editor it’s recompiled so that you can run it.
There are some external scripts, like M6 that you CAN edit externally, but get compiled into the screen set so you’re better off editing with Zerobrane.
There’s a video specifically showing how to edit the M6 script that Mach put out, that’s what I followed and my script is a very light variation of that one.
My script won’t work for you because if references registers that you don’t have. I manually made my registers, but it would be better for the script to make them. I haven’t solved for that yet.

---

## Post #36 - Michael Woodrum

**Time:** 2022-11-18T15:40:19.950Z

There isn’t a way to access the auto z touch plate screen within mach dele editing screens. It runs a script on mouse button up that then loads the poop up window. I wanted to modify that but, I may just need to create a fully separate one. Knowing how they designed it, I guess I’ll figure out after messing with the code enough and reading up.
I guess you made the registers in the registers.json file?

---

## Post #37 - Eric

**Time:** 2022-11-18T15:50:33.118Z

MichaelDot:
I guess you made the registers in the registers.json file?
You can manually make registers, which is fine for testing but really should be done in a script for toolsetting because those numbers change dynamically…
My guess is that the touch plate utility was built in WxWidgets. There’s something in one of the Mach lua manuals about how you’d build something like that. I haven’t spent anytime figuring out how the touch plate utility works. There are a few screensets that have similar things so maybe some digging there would yield something.

---

## Post #38 - SUBNOIZE LLC

**Time:** 2022-11-18T16:10:52.776Z

Eric:
My guess is that the touch plate utility was built in WxWidgets.
Yep! Its an external lib, actually;
https://www.wxwidgets.org/
Also, this helps;
https://wxlua.sourceforge.net/
I just got into this with the manual tool load/unload feature I am adding. It makes a prettier popup for instructing the operator.

---

## Post #39 - Michael Woodrum

**Time:** 2022-11-18T16:19:37.106Z

Thanks. I’ll check it out now. Looking at testing registers to store and recall now.

---

## Post #40 - Michael Woodrum

**Time:** 2023-02-11T13:14:55.366Z

I have spent a lot of time trying to understand how to get something added to mach4 to do what my mach3 screenset does and I am stumped. The amount of work i have done on this and the little progress I have made with it is not great. I have tried using several scripts for m6 itself that rely on knowing the current tools length in the holder. That could work for some people but, you might as well just have separate gcode files and manually touch off the surface of the material between the different tools used. What is needed in the avid touch plate setup is an extra option.
I am absolutely positive that anyone using the avid machines with the touch plate setup would benefit from having this available to them. I can only hope that Avid or a community member with the skills required can develop this for the community.
I am going to describe what I think would be the best addition to the touch plate.
Within the touch plate program, there should be an option for a second probe location in the xy. Manually type in that machine location.
I have a plate mounted to a post that can be moved out of the way when loading materials. It is connected to the plate so that when the wire is connected to the spindle, it triggers the probe when touched. This can be at variable height because it can be moved. So, what needs to happen on job setup should be like this:
Load material, if job uses multiple tools then there should be a button in the touch plate window that enables a first setup step. This would be setting material zero and then move to the xy location that is stored for the second plate.
You would place the touch plate on the material surface, or bed if you use the bed. Then jog above it and press a button to probe that as z0 in this sequence.
Then z retracts to machine 0 and moves to the xy location of the second plate.
This second place is probed and the offset is stored somehow.
Now that we know the current tools z 0 location and the difference between it and the second plate, we can use that difference to adjust the next tool when the m6 is called.
Since the current avid screenset has a MTC location capture button, this is used during m6.
M6 is called, tool moves to tool change location. Next tool is inserted.
Attach wire to spindle, press next in window and tool moves to machine z 0 to move over to the xy of second plate.
Tool probes second plate. tool 2 touch location updates the difference stored and becomes the new difference stored and tool length is changed according to the calculated difference between the first difference and the second difference.
Go back to position before the start of m6 routine. cycle start to move through the next section of gcode.
I know this is possible. I just suck at programming for mach4 in lua. I also cannot find the time to get deep enough into it. This would benefit the entire customer base though. most of what I do does not leave a location to touch off of because it is gone by the time m6 is called.
Being able to run 1 file for an entire job and knowing that the next tool will be in the right place is pretty comforting.
This would work for the 4th axis as well. On the 4th, I always lose the location. Sheet goods are not as much of an issue.
Please avid, build this into the screenset. It is a huge benefit to all of us. Even if they do not know. They will love it after it exists. My only other option is using mach3 again because I have it there.

---

## Post #41 - Michael Woodrum

**Time:** 2023-02-11T14:19:34.048Z

I just attempted to run through a sequence of steps to determine the tool length change measurement.
I did this several times to see what should happen.
If I gather the material z0 and then measure the 2nd plate z0, then get the difference recorded on paper.
Then make the tool stick out further and probe the 2nd plate again, record that position and subtract the last difference, I get the correct offset on paper.
However, if I then change the tool length in the settings, it doesn’t do anything when trying to return to z zero. Seems to be ignored. Is the tool table doing anything in this? I then just decided to change lengths and text where z 0 would be placed and nothing happens. Just returns to the original place.
If I update the g54 offset z position with the difference, then it works. So, I’m guessing that creating an m6 would actually need to update the current work offset z instead of the tool table to make the real change. What does the roll table do with length if not updating the z 0?

---

## Post #42 - SUBNOIZE LLC

**Time:** 2023-02-11T19:10:18.044Z

Are you using
G43 H{insert tool number here}
before each touch off?
Calculating tool offsets requires calculating from absolute machine cords so watch out about that.
Also, if you are using the AvidCNC touch off function it will always do a
G43 H1
no matter what tool you use. I have complained about that but no response from the factory.
I think
@Eric
said he would look into it but I haven’t heard back on the topic.

---

## Post #43 - Michael Woodrum

**Time:** 2023-02-11T22:13:45.924Z

Not when I did my test above. I just did a G31 probe and recorded that position. I do everything in machine coordinates too.
I assumed, which i should not ever do, that entering a different length in the tool screen would change the actual tool length that mach3 would read. i have not used g43 in my script.
I made a replacement m6 macro and I am definitely doing something wrong. I can touch a new tool off and record that but, have no idea how to store the first probing using the avid plate on the surface of the material and then doing the second one on the other plate and storing that difference for reference later.
For sure my m6 macro is basic now. I cannot figure out how to probe 2 times within it. First to search for the plate and then back off and go slow for the actual measurement. I can get it to back off but, it skips the second probing and records the tool length right away after backing off.
I have not tried using the g43 in the macro either, I bet that may help though. Still I do not have the first tool recorded from that second probe position and cannot calculate a difference because I only have surface of material z0.

---

## Post #44 - SUBNOIZE LLC

**Time:** 2023-02-11T22:44:42.875Z

MichaelDot:
I can touch a new tool off and record that but, have no idea how to store the first probing using the avid plate on the surface of the material and then doing the second one on the other plate and storing that difference for reference later.
I think you are talking about the difference in length between tools. I assume you are using a ATC because if you are doing this by hand, you are headed for troubled waters.
You have to precalculate the tool offsets from tool
#1
. Meaning that tool
#1
is always zero (resist the urge to prove me wrong by adding a different value in your tool table, let us simplify and not make things more difficult).
You will need to go through a process of measuring each tool and determining the
difference
in size in each tool when compared to tool
#1
AND THAT VALUE IS PLACED IN THE LENGTH FIELD IN THE TOOL TABLE. Not the actual length of the tool itself.
Clear as mud… I didn’t invent it so…
Now, when that is all correct, you will change tools as follows (assume current tool is
#1
and you are going to tool
#59
);
T59 M6
G43 H59
Line one says change the tool to
#59
Line two says to set the OFFSET (the length field in the tool table) using tool
#59
Now the tip of tool
#59
will be recalculated to be where the Zero was set with tool
#1
before the change.
This way you don’t have to re-zero tool
#59
If I misunderstood I am terribly sorry. If you are using a ATC, G43 is required. You will find G43 in Mach3 as well but its been so long since I used it I don’t remember the tool table and the rules it follows.
The good news in I believe that Mach3 like Mach4 are FUNAC clones so that would mean the tool table in Mach3 would follow the same rules as Mach4.

---

## Post #45 - Michael Woodrum

**Time:** 2023-02-12T12:15:52.505Z

I am not using an ATC. That would be awesome but, cost prohibitive.
What I had in mach 3 was from a screenset called mach 2010 screenset. Basically, you have 2 probing points. One fixed and the other moveable for the material. You put in the first tool and run a script that touches the moveable surface plate. Then the tool moves over to the fixed plate and touches there. This establishes surface z0 and calculates the difference between the two plates.
When m6 runs, you switch tools and then the tool moves to the fixed plate and touches. Then it uses the stored difference value to determine this tools length. Return to job and run.
It works amazingly well. No need to have tool offsets. So much faster and allows using one gcode file for the entire job without having to fumble around with multiple files in order and making sure you have an original surface to zero with.
It sounds so simple up front but, it is not for me.

---

## Post #46 - Michael Woodrum

**Time:** 2023-02-12T14:06:38.830Z

I have no idea how far I will get with this but, I finally took the time to figure out storing and retrieving registers. I have some time today. No idea when I will get more time to work on it. At least I know how to do this part.
next will be writing several functions to call from buttons to do setup. Then figure out the whole probing thing. Then do the math to do the rest. I will slowly get through this and, maybe in a year I will have this functioning again.

---

## Post #47 - Jim Neeb

**Time:** 2023-02-12T14:58:57.718Z

MichaelDot:
What I had in mach 3 was from a screenset called mach 2010 screenset. Basically, you have 2 probing points. One fixed and the other moveable for the material. You put in the first tool and run a script that touches the moveable surface plate. Then the tool moves over to the fixed plate and touches there. This establishes surface z0 and calculates the difference between the two plates.
Thats pretty cool.  If I ran multitool jobs I would definitely want that.  It woudl be  a nice addition to the touchplate routine.  I would also like to have a set of selectable offsets in the routine for use with lasers and other things.  I have asked, but I don’t think AVID has the resources to add stuff to that, especially since it probably won’t sell more machines (I agree though, it would be nice if we could get the source so we could edit our own versions instead of making workarounds in seperate functions).
The worst thing about editing screens in Mach4 is that there is literally no documentation for the screen APIs (and a couple others), only the core.  So I end up spending a lot of time scanning through the examples in the modules directory looking for examples to figure it out.

---

## Post #48 - Michael Woodrum

**Time:** 2023-02-12T16:05:34.998Z

Yeah. I have been at it since about 4:30 this morning.
I have been trying to familiarize myself with the layout of all the files that are only available while editing and trying to see the links between everything.
It seems that most of the functions available to other things from avid are stored in the PLC script. I have to understand this a bit more to make sure I do not break anything. I know it is called PLC but, do not know how it actually behaves.
Right now I can store and retrieve values from the register.
Next I am going to get all the pop ups and buttons for next steps in sequence working.
Then I will attempt to get functions I can call throughout to work. I was testing to see if I could just call an M code directly from a button and that then crashed mach and I could not open again because it could not compile. So, that does not work. i assume I need to write this as a function and then call that in the sequence instead.
If I were to call it using an M code, i guess I would just copy the same code into that file and run it from the MDI. I do not see that being needed.
I have values for the fixed plate locations being stored and returned.
next is to write a probing function for the material z0 location
After that is stored, it will run the next function that moves up and over to the fixed plate and probes that. Stores the value and then does the math to get the difference. Store the difference.
I suppose I would then use the first value to set my z0 location.
My M6 routine would then have to move to the mtc location, that I can recall from avids script in the PLC.
After the tool change, call the next function to move to the fixed plate and probe this tool and store that value again. Then do the math to get the difference and store that. Then set the z0 to that new number.
At least, i think that should work. z0 in g54 should be the changed number. When stepping through the routine manually and calculating, that is what I would change to get the new tool back to the correct location on resume.

---

## Post #49 - SUBNOIZE LLC

**Time:** 2023-02-12T16:31:11.870Z

I am just too lazy
I would use a permanent mount and write a script to calculate the difference between the perm mount and the spoilboard.
Solves two problems; cutting through your spoilboard and if you still need the surface cords, run the script again from the surface of the stock.
If you need the STL for the AvidCNC touch-off plate mount I can repost it.

---

## Post #50 - Michael Woodrum

**Time:** 2023-02-12T17:39:17.941Z

I have never used the spoil board for my output. Mostly because I’m lazy and would have to think differently.
However, thinking about that does actually make more sense in most situations and it would prevent me from cutting through the board. It would also solve some issues with ply being inconsistent and dealing with rabitts fitting. Just putting in the nominal thickness for stock.
That still doesn’t solve the tool change issue for me though. Other than being able to touch off the spoil board if it’s available. Just having the flow of it all without much thought after the fact is nice.
I also want to use this with my 4th and I tend to get stock dimensioned in the 4th to the correct size as part of my first pass.
I’ve worked through setting up an interface for my m6 setup. I’ve also created basic steps in code that calculate everyone and store/recall values for this.
I think I’m almost there with most of that. Just need to do probing instead of the inputs I have for testing. Then I’ll see where it needs work. Now I have to go do things that aren’t this. Hopefully I can revisit soon. Kept a bunch of notes to make sure I can get back on track quickly.

---

## Post #51 - SUBNOIZE LLC

**Time:** 2023-02-12T17:43:22.637Z

MichaelDot:
I also want to use this with my 4th
I would think using the 4th axis accurately without an ATC would require a permanent reference.
My 4th axis has a permanent touch-off plate attachment. Did they change that on the newer machines?

---

## Post #52 - Michael Woodrum

**Time:** 2023-02-12T21:30:54.135Z

I built my 4th myself. I have a place on the setup for referencing my second touch off that I can get the difference from and use that for later tools.
I am working through this script some more now and I have looked through everything I can within the files from avid and the programming guide is not much help now.
How do I programmatically set work coordinate z to 0? I cannot find any reference other than tool offset. I want to change the current work offset z height from a script.

---

## Post #53 - SUBNOIZE LLC

**Time:** 2023-02-12T21:50:18.973Z

MichaelDot:
How do I programmatically set work coordinate z to 0?
$190/hr + 3 hr minimum since you are a friend
-- SNZ Probe X Axis --

local FastFeed = 200
local SlowFeed = 80
local BackOff = 3
local OffsetNum = 99

local ProbeSigTable = {
	[31] = mc.ISIG_PROBE,
	[31.0] = mc.ISIG_PROBE,
	[31.1] = mc.ISIG_PROBE1,
	[31.2] = mc.ISIG_PROBE2,
	[31.3] = mc.ISIG_PROBE3
}

function checkProbe(state, code)
	
	local inst = mc.mcGetInstance()
	
	local check = true
	
	local ProbeSignal = ProbeSigTable[code]
	
	if (ProbeSignal == nil) then
		mc.mcCntlSetLastError(inst, "ERROR: Invalid probing G code")
		mc.mcCntlEStop(inst)
		do return end
	end
	
	------------- Check Probe -------------
	local hsig = mc.mcSignalGetHandle(inst, ProbeSignal)
	local ProbeState = mc.mcSignalGetState(hsig)
	local errmsg = "ERROR: No contact with probe"
	
	if (state == 1) then
		errmsg = "ERROR: Probe obstructed"
	end
	
	if (ProbeState == state) then
		mc.mcCntlSetLastError(inst, errmsg)
		mc.mcCntlEStop(inst)
		check = false
	end
	
	return check
end


function setFixOffset(xval)
	
	local inst = mc.mcGetInstance()
    local FixOffset = mc.mcCntlGetPoundVar(inst, mc.SV_MOD_GROUP_14)
    local Pval = mc.mcCntlGetPoundVar(inst, mc.SV_BUFP)
    local FixNum, whole, frac

    if (FixOffset ~= 54.1) then --G54 through G59
        whole, frac = math.modf (FixOffset)
        FixNum = (whole - 53) 
        PoundVarX = ((mc.SV_FIXTURES_START - mc.SV_FIXTURES_INC) + (FixNum * mc.SV_FIXTURES_INC))
    else --G54.1 P1 through G54.1 P100
        FixNum = (Pval + 6)
        if (Pval > 0) and (Pval < 51) then -- G54.1 P1 through G54.1 P50
            PoundVarX = ((mc.SV_FIXTURE_EXPAND - mc.SV_FIXTURES_INC) + (Pval * mc.SV_FIXTURES_INC))
        elseif (Pval > 50) and (Pval < 101) then -- G54.1 P51 through G54.1 P100
            PoundVarX = ((mc.SV_FIXTURE_EXPAND2 - mc.SV_FIXTURES_INC) + (Pval * mc.SV_FIXTURES_INC))	
        end
    end
	
	mc.mcCntlSetPoundVar(inst, PoundVarX, xval)
	
end


function m10101()
	
	local inst = mc.mcGetInstance()
	
	local rc = checkProbe(1, 31); if not rc then; do return end; end
	
	------------- Get current machine state -------------
	local CurFeed = mc.mcCntlGetPoundVar(inst, mc.SV_FEEDRATE)
	local CurZOffset = mc.mcCntlGetPoundVar(inst, mc.SV_ORIGIN_OFFSET_Z)
	local CurFeedMode = mc.mcCntlGetPoundVar(inst, mc.SV_MOD_GROUP_1)
	local CurAbsMode = mc.mcCntlGetPoundVar(inst, mc.SV_MOD_GROUP_3)
	local CurPosition = mc.mcAxisGetPos(inst, mc.Z_AXIS)
	
	------------- Set Probe Offset, Relative Positioning -------------
	mc.mcCntlGcodeExecuteWait(inst, string.format("G43 H%.0f", OffsetNum))
	mc.mcCntlGcodeExecuteWait(inst, "G91")
	
	------------- Fast Probe -------------
	mc.mcCntlGcodeExecuteWait(inst, "G31 X50 F200")
	
	rc = checkProbe(0, 31); if not rc then; do return end; end
	
	------------- Back Off Probe -------------
	mc.mcCntlGcodeExecuteWait(inst, "G01 X-3 F350")
	
	------------- Slow Probe -------------
	mc.mcCntlGcodeExecuteWait(inst, "G31 X10 F50")
	
	rc = checkProbe(0, 31); if not rc then; do return end; end
	
	------------- Get Position + Data -------------
	local XProbed = mc.mcCntlGetPoundVar(inst, mc.SV_PROBE_POS_X)
	local XMachProbed = mc.mcCntlGetPoundVar(inst, mc.SV_PROBE_MACH_POS_X)
	
	
	print("Mach Probe X "..XMachProbed)
	
	
	
	local probeRadius = (25.4 * 0.125) / 2
	
	print("Mach Probe X Radius "..probeRadius)
	
	------------- Calculate Offset -------------
	local NewWOVal = XMachProbed + probeRadius
	
	------------- Set Offset-------------
	setFixOffset(NewWOVal)
	
	------------- Safe Z-------------
	--mc.mcCntlGcodeExecuteWait(inst, "G01 X-10 F350")
	
	------------- Reset Machine State ------------------------------------
	mc.mcCntlSetPoundVar(inst, mc.SV_FEEDRATE, CurFeed)
	mc.mcCntlSetPoundVar(inst, mc.SV_MOD_GROUP_1, CurFeedMode)
	mc.mcCntlSetPoundVar(inst, mc.SV_MOD_GROUP_3, CurAbsMode)
end



if (mc.mcInEditor() == 1) then
	m10101()
end
I would eliminate the
G43 H99
. My probe is set to
#99
and I don’t use a touch plate. I have been meaning to make that script a library but i never get around to it. It was written as a test file before I added the buttons to my screen.
EDIT;
local probeRadius = (25.4 * 0.125) / 2
can be replaced as well. That would be the diameter of your probe. Make it a constant of read from a register.
Very ugly script

---

## Post #54 - Michael Woodrum

**Time:** 2023-02-12T22:39:47.093Z

Well, you’ve given me some things to work through. I appreciate sharing.
I know the person at artsoft left. I’m just kind of surprised that there are so many intelisense pop ups when using the editor and I can’t find a reference for everything available. Going back and forth between all the places where code exists across the system looking for something in thousands of lines that could work, maybe.

---

## Post #55 - SUBNOIZE LLC

**Time:** 2023-02-12T23:10:56.140Z

MichaelDot:
intelisense pop ups
That is a open source UI. I use the C/C++ documentation and references from the Lua site. It’s a mess.
You won’t find any of that with Newfangled docs.

---

## Post #56 - Michael Woodrum

**Time:** 2023-02-12T23:29:56.037Z

Whatever it’s called in brain editor. I use vscode for most things. Not this though. How did you figure out what mc.mcCntlSetPoundVar did? I just need a real reference for everything exposed for use.
Did you seriously test everything and infet ?
I figured that accessing something like the current g54 z value would be straight forward. Something like get and set. I know get for current z location exists.

---

## Post #57 - SUBNOIZE LLC

**Time:** 2023-02-12T23:35:37.926Z

Oh, that is in the C/C++ docs for Mach4. None of the real details is in the regular docs. It’s in the compiled HTM file, help thingy.

---

## Post #58 - Michael Woodrum

**Time:** 2023-02-12T23:39:06.992Z

Ahhhhhh. Well, I’ll have to look there. I didn’t know it existed. Not sure why I missed that

---

## Post #59 - SUBNOIZE LLC

**Time:** 2023-02-12T23:57:25.781Z

Word of warning, that is the doc that after reading it for a few days you will want to scratch your eyeballs out and shriek at the heavens, “Whhhhhhhhhhhy?!?!?!”

---

## Post #60 - SUBNOIZE LLC

**Time:** 2023-02-13T00:25:35.117Z

Mach4CoreAPI.chw
That’s the name of the thing! I was away from my computer and couldn’t remember the name of it.
You can tell they had a direction, a purpose but then, nothing… It all evaporated.
Here is the link to the docs for the UI shi…
…uff;
https://docs.wxwidgets.org/3.0.1/

---

## Post #61 - Michael Woodrum

**Time:** 2023-02-13T01:18:35.214Z

subnoize:
Mach4CoreAPI.chw
it is mach4corAPI.chm  Why that is not in the help dropdown, who knows. thank you. I could not even find the reference. I was looking for any sort of help file referencing c/c++ or anything. This entire system is much too cryptic. I will scratch my eyes out once I get this working. I will deal until then.

---

## Post #62 - Michael Woodrum

**Time:** 2023-02-13T01:37:09.534Z

i think i found it. this is exactly the doc i needed. mcaxissetposition. i know theres more to work out. now it might actually get finished. i have given up a few times and keep coming back. i will get it eventually.

---

## Post #63 - Michael Woodrum

**Time:** 2023-02-13T01:46:23.270Z

Mach4CoreAPI.pdf
(4.1 MB)
I converted it to PDF. In case someone wants it, I attached here.

---

## Post #64 - SUBNOIZE LLC

**Time:** 2023-02-13T01:51:56.337Z

This might be a better Lua UI system. that wxWidget stuff is for the
s
https://luapower.com/ui

---

## Post #65 - Michael Woodrum

**Time:** 2023-02-13T14:53:57.811Z

For sure, dealing with that interface is a pain. I can deal with it for now. I may get into making a great looking interface for things as long as I can get other stuff working well.
That being said, mcAxisSetPosition is the thing needed to inject the calculated offset for what I am working on. I tested it in simulation mode. Whatever offset you are working within will get the input. You just have to assign the axis to put the number into. It has to be by number. In the sim it is axis 2. Probably axis 2 on my machine as well.
Now I need to work out some logic for shorter vs longer tools and then probing setup as well as finishing m6 to put in the value. I have recalling and storing registers and basic calculations not. Just for getting numbers moved around to test with.
I am actually getting close, i think. We will see soon enough.

---

## Post #66 - Michael Woodrum

**Time:** 2023-02-13T19:44:24.981Z

How could you call this script during m6? When attempting to integrate what I’ve built into m6, I had to create all the functions to pull in and write registers. I can’t access the global things within the macro.
I’m not using yours, just wondering how that is done normally by people. I can add all the functions needed but, I’m sure there’s a better method.

---

## Post #67 - Michael Woodrum

**Time:** 2023-02-13T20:29:27.362Z

Ok, I watched the missing mach 4 programming video again and now things make some more sense.
I assume I’ll have to write an mcodes that has a bunch of functions needed to match what is available to the screens. Then use registers to make sure that the values are able to be pulled in either without mismatching.
I was attempting to use the function from avid for the stored mtc location in my m6. Since it’s a button script that is recalling values from another script that stores that location, I’ll have to copy the function from their code and put it within my macro to read the values outside of screen.
I assume that this also means I can take advantage of their probing code in a similar way. My first testing days ago with attempting to probe fast and then slow failed. It just skipped over the second section of probing and used the first value it received. It seems I have to do something other than straight probe. I do recall seeing something else that seemed to loop until a signal activated.

---

## Post #68 - SUBNOIZE LLC

**Time:** 2023-02-14T07:08:37.522Z

I would not use Avid’s scripts. They won’t tell you when they change things and that can be an expensive mistake.
The registers are where you store values. That is not just how you persist variables but also how Modbus passes numeric values.
You can make modules and call them which will keep your code much cleaner and make reuse easier.
All of my code starts life as an m code because it’s easy but migrates to modules. The m-codes will all call the modules because it keeps them and the UI scripts lean and uncomplicated.
MichaelDot:
. I do recall seeing something else that seemed to loop until a signal activated.
Oh gosh, no! Remember that the Lua engine is disconnected from the Mach4 core. You will never get a signal and be able to act on it in enough time to not damage your machine.
You will depend on the ESS to stop the machine and then you read the state to see if it errored out or it tripped.
I will check back in tomorrow because I got to your post here at 2am.
I apologize if I misread what you wrote.

---

## Post #69 - Michael Woodrum

**Time:** 2023-02-14T11:15:59.386Z

Ok. I will not use avids code and keep mine separate. Getting deeper into this and it just seems to get more complicated. I’ll have to read up on lua in hopes that it helps me understand what is happening half the time.
I keep seeing different scripts people have made referencing things I just can’t find definitions for. Obviously there is structure and use definitions in the scripting help file but, no idea what they can access half the time.
The pound variable grabs some number that defines something. No idea how you can know what it grabs though.
When talking about the loop I was referring to what seemed to wait for the signal from the ess to write somewhere and then check that. Is it not looping and waiting for that signal? Is it instead telling the machine to move and then it moves until ess stops the move and then checks for that as an error?

---

## Post #70 - Michael Woodrum

**Time:** 2023-02-14T11:42:04.234Z

So I found a list online of the enums available, at least it is some of them. Most of them seem to spell out what they are. There is an amazing amount of disparate information spread across the internet. Once I compile all of the information together in one place and make a functioning tool change script, I am going to put this in my github so that someone might not just give up when they cannot find anything.

---

## Post #71 - Michael Woodrum

**Time:** 2023-02-14T13:54:04.415Z

Well, this video just explained so much to me about evening in looking for. Now I finally understand where the probing routines get the values and how to deal with them. I was confused by the code always waiting for an error from ess. It finally makes sense.
DasTheGas seems to have about 5 or so hours of stuff to watch before you stumble on answers.
It isn’t easier to find answers using all the old forums though.

---

## Post #72 - Michael Woodrum

**Time:** 2023-02-14T17:41:27.909Z

So, I’ve been at it today creating two separate scripts. One for setup using the when and another for m6.
I do not want to test this in my machine before more debugging. So, my second computer is in simulation. What I can’t figure out is how to access the ess registers in simulation mode. Is there a way to do this without testing on my real setup?

---

## Post #73 - SUBNOIZE LLC

**Time:** 2023-02-15T04:41:53.083Z

MichaelDot:
I keep seeing different scripts people have made referencing things I just can’t find definitions for.
Yep, you beg Newfangled until they drop crumbs. They have a small cadre they leak knowledge to like dazthagaz and a few others. If you think about it or take it personally it will mess with your ability to enjoy the tool you have. Just make lots of friends and learn from others the best you can.
MichaelDot:
The pound variable grabs some number that defines something. No idea how you can know what it grabs though.
Now that IS in the Mach4 Core API doc. Its under signals somewhere. I find it and then I forget where and have to repeat the journey every 3 or 4 months.
MichaelDot:
When talking about the loop I was referring to what seemed to wait for the signal from the ess to write somewhere and then check that. Is it not looping and waiting for that signal?
Nope, you do a wait on a signal like this;
rc = mc.mcSignalWait(inst, mc.ISIG_INPUT50, mc.WAIT_MODE_LOW, seconds)
if(rc ~= 0) then
	print("Error while waiting for tool sensor carriage response")
	return false
end
The code above waits so many seconds for that signal to go low or rc is an error code.
MichaelDot:
Is it instead telling the machine to move and then it moves until ess stops the move and then checks for that as an error?
On the probing, yes. You give it a command to move so far and then the next line you check if it hit anything or if it gave you an error. That is because the gcode execution is blocking. When your code resumes (the very next line) either the ESS has blown up or the probe has a result.
NOW! Be aware that Warp9ltd and Newfangled have differing opinions on how things should report during probing. I think we have already talked about this but I will mention this here again just in case. The ESS is set up to FAIL (throws the e-stop for you) when a probe command completes WITH NO STRIKE. Another way of saying this is if it completes the move and did not contact something ESS considers this to be an error.
On the other hand, Newfangled DOES NOT throw an error and in fact uses this as a method to “safely move around the space” without breaking the probe.
My take on this is both are wrong. Using G38.x is far superior because you have move to “touch” and move to “untouch.” You can also set the work offset using gcode (for example
G10 L20 P1 Z1.52
).
The LinuxCNC folks and all of the derivatives like Grbl, Marlin etc all have those features. So your cheapo 40 watt laser diode machine has it but not your sad little Mach4 box
MichaelDot:
Once I compile all of the information together in one place and make a functioning tool change script, I am going to put this in my github so that someone might not just give up when they cannot find anything.
Yep, and nobody will read it. Not that it isn’t cool but that everyone has the “better idea.”
There are a billion such github projects. All of them abandoned… mine included
April is my date for getting things released.

---

## Post #74 - Michael Woodrum

**Time:** 2023-02-15T11:35:08.046Z

Thank you for so much feedback. It really is helping.
It is funny how many inexpensive controllers I have that have insane amounts of documentation and capabilities. With Marlin I can basically create anything I want. Including custom hardware to do tasks triggered by whatever random thing I feel like using and add long as there are ways to send and receive different signals. I could use mqtt if I wanted.
One more thing, do you know of a way to simulate the setup on another computer and get signals simulated from the ess? If not, I just have to test on my real setup and hope I get it right before throwing around the tool head

---

## Post #75 - Michael Woodrum

**Time:** 2023-02-15T21:04:40.027Z

It’s not possible. Just have to run the machine with motors off and manually trigger to test

---

## Post #76 - Michael Woodrum

**Time:** 2023-02-15T23:07:49.494Z

And now I’m actually testing on the machine and finally understand what you meant by it being unresponsive during these moves. I still want to get this working this way, since I’m very close.
Building a module would be the next attempt after refining everything I have now. I started going into that with basic things to test. It’s as confusing as I expected.

---

## Post #77 - SUBNOIZE LLC

**Time:** 2023-02-16T03:24:20.345Z

I don’t know of anything that would allow you to simulate a real machine with Mach4.
Newfangled wouldn’t license me their API for plugins despite their claims it’s for writing motion controllers. To which my carousel apparently isn’t worthy (which is why it now supports ModBus, fudge them and the donkey they rode into town on).
I do a fair amount of work with my carousel controller and Mach4 on my laptop. I just wait for the ESS to time out and then the ModBus comes up and I can see signals and polling just fine.
I also use RDP to my actual CNC PC and use a camera to view what is happening and then I can sit back in the comfort of my office and code.
Like you said, I have 6 CNC machines and many controller for more of them. All of them have better documentation and the developers for all of them will respond and help you with just about anything.
I truly believe that the owners of Newfangled not only do not code but they are ignorant of their own product.

---

## Post #78 - Michael Woodrum

**Time:** 2023-02-16T10:34:02.425Z

I attempted messing with modbus on mach3. I figured that could extend to anything with signals. That does make sense you would use it. I’m not there yet.
I assume you just use wifi to remote in. I have my win10 machine at 1607ltsc and everything possible turned off. That was mainly because windows update is insanely chatty. I used to run a kvm between my desk and the shop.
It did freak me out the first time I ran the code with motors on. However, it all worked, mostly. No crashing.
I’ll just have to deal with no feedback until the step is done and make sure it cannot crash unless something real dumb happens.

---

## Post #79 - SUBNOIZE LLC

**Time:** 2023-02-17T03:35:15.977Z

MichaelDot:
That was mainly because windows update is insanely chatty
I use Windows 11 Pro and inhibit updates. So I can be on both wired and wifi. With Winderz Pro you can set it to delay updated by 1 month and then you update it on your own time. Generally I either update before shutting down for the day on I do a Sunday systems check and get it then.
MichaelDot:
It did freak me out the first time I ran the code with motors on. However, it all worked, mostly. No crashing.
Give it time. Beginners luck
I fly 3D RC helicopters and the difference between a wreck and a re-kit is milliseconds on the throttle hold. Its a switch that cuts the power to the main rotor. The quicker you cut that power the less damage the helicopter suffers during mishaps.
That training for the past 30 years has paid off more than once with my AvidCNC.
MichaelDot:
I’ll just have to deal with no feedback until the step is done and make sure it cannot crash unless something real dumb happens.
Here is a trick, while writing make it pause and wait for you to click the cycle start between each step. And do a
print("describe what I am doing...")
in the Lua code so you can can figure out where you mistakes are and it wont just run through when things go bad.
The print command will be visible in the History dialog so you can see what its doing from the screen as well as from the debugger.

---

## Post #80 - Michael Woodrum

**Time:** 2023-02-17T17:35:40.705Z

While running the m6 itself, I get all the GUI feedback. Just the GUI button blocks.
I’ve inserted messages at every step along the way. Still not fun feeling when testing though. I do not like how it just locks up the system during it. When testing strictly on my main computer yesterday, I called something in the script. I was working on it remotely and it locked up the whole machine and disconnected me. Got home and it was still locked up. Had to hard restart to get back. I figured it was something that would work itself out before I got home. Nope.
It’s my design machine and mach doesn’t take much of it to run. 256gb ram. 3070 and amd 5950. Beast. I can’t believe you would run mach on windows 11 first off. I don’t even run windows 11 on any machine I want to use yet. Windows 10 is hard enough to calm down in the background. With everything Microsoft is doing with distributed updates across your local network, constant need and ad garbage and whatever random things want to run. I can’t believe your mach setup doesn’t randomly crash because of whatever is happening somewhere in the system. With mach3 you could crash because a USB device was plugged in. Moved your mouse too fast? Lose a bit.
That being said, I have both of my scripts working with motion and touching and recording positions.
Next is getting the math for tool change worked out. Because I’m changing z work offset accordingly, the value could be negative or positive. I’ll have to check for this and then do the correct math based off of that check. Hopefully I’ll have this done by the morning.

---

## Post #81 - SUBNOIZE LLC

**Time:** 2023-02-17T20:36:23.735Z

MichaelDot:
I don’t even run windows 11 on any machine I want to use yet. Windows 10 is hard enough to calm down in the background. With everything Microsoft is doing with distributed updates across your local network, constant need and ad garbage and whatever random things want to run. I can’t believe your mach setup doesn’t randomly crash because of whatever is happening somewhere in the system.
Pro versions of Windows allow you to disable automated updates.
The only two versions of Windows I would run Mach4 on is Windows 7 and 11. I would advise Windows 11 Pro specifically because you can then base your automated updates off an organizational level.
In fact, when you install using the AvidCNC installer you will find they give an organizational level update policy and disable automated updates with the exception of system monthly (also known as “mandatory”) updates.
Most Windows 10 have patches installed for Meltdown and Spectre exploits which makes them uniquely unfit for RT operations like CNC operation. These exploits are hardware exploits so the software can take as much as 35% of your CPU checking operations and clearing L2 cache. And no, you cannot undo those patches.
Windows 7 never got the update of course so there is that little nugget.
With W11 you can disable many more services that you ever could before. This trend is from the stick and card pack sized PCs.
My CNC PC is a MeLE 8GB 128GB 4 core Intel Celeron J4125. So absolutely tiny computer. It is smaller than the 8 port ethernet hub it sits on. No fan to suck in dust either. It runs Mach4 just fine. Don’t need to turn off wifi or anything like that. You can buy one off Amazon for $175 with Prime shipping.
MichaelDot:
That being said, I have both of my scripts working with motion and touching and recording positions.
Next is getting the math for tool change worked out.
Glad to hear that! Looking forwards to hearing more about it.

---

## Post #82 - Michael Woodrum

**Time:** 2023-02-18T13:40:49.732Z

I work in Enterprise IT as my profession. I understand how to control systems well. I run pro on everything I have. I tend to wait until things settle before upgrading. Especially because my design computer is too time consuming to fix after a full os update. Installing from scratch takes even longer. Dev environments are hard to keep between setups. Fusion is no issue at all but, zbrush and all of the plugins take way too long to get back into. Blender, even with plugins that attempt to back up.
My current CNC machine is running 1607 ltsc and that is way before the patches for the exploits. I just kept it that way because mach3 was an issue on a couple other machines with lock up.
I’m going to look into that stick you mentioned. I do have a nuc from a few years back. I’ll have to make sure it has a TPM chip first. I have it for Kali Linux but, just started running that on a portable pi setup instead.
On to my M6 scripting adventure. Yesterday I spent several hours attempting to get everything working. I tend to keep at things until I can’t recognize that I shouldn’t keep going.
I definitely over thought the process though. I think it’s because I was learning how to use lua and attempting to create everything at the same time. I had too many variables and too many findings doing math on these things. I stopped at some point, in frustration. I kept trying to find a way to set the machine offsets because there is a set command for it. Fairly certain it isn’t implemented though.
Then, while having some drinks with friends and not thinking at all about this, it just popped into my head. As soon as the answer came to me, it made perfect sense.
This morning I removed a bunch of variables and functions. I realized last night that I didn’t need to know any measurement between the two touch plates at all. I only needed to set up a tool by finding the z0 of the work and then touching the fixed plate and storing that position. Z0 just got setting up before the job and the plate being the current position with that tool in it.
Then on my the tool moves to a tool change location, changes tools and goes to the fixed plate. When that touches, store that location and set it to over write the original location at that same position. That’s it! Duh.
I think part of it was that I was attempting to do a similar thing that my mach3 screenset did. Not necessary though.
I then modified the screenset to allow you to move to a position you want to change tools at, store that position and did the same for the fixed plate. Added buttons for that as well as adding buttons to move to those positions if wanted.
The scripts I made make sure to move to machine z0 before the moves and give some prompts to remember to do certain things before it happens.
I need to clean things up a bit and document a little better. I also haven’t tried listening for probe trigger the way you showed up above. I was trying to get things working with what seemed to work already.
I will say that it seems that using g31 at certain speeds takes some amount of time to trigger that could throw off the measurement. Does the method you gave trigger faster? I’m not moving fast now and especially not on the second move. It probes for the plate at 25ipm and then backs off a tiny amount and probes again at 2ipm. I have inputs on screen to change these speeds and distances.
When I moved at 40ipm, it was able to knock the plate out by a few thou before stopping.
Once I clean up the setup some more, I’ll post a link to my GitHub where everything will be. The other thing I’m not liking about mach4 is the method of moving things into a setup. Seems that the easiest is to use the full profile folder and screen file. If someone has a custom setup already, they would have to modify the ini holding all the variables, add buttons and then add the scripts individually to those buttons. I would have to save each of those scripts separately to copy into those screen buttons. I haven’t gone into modules yet. Maybe that would help. Pop up windows over the screen instead of using the screen itself.

---

## Post #83 - Michael Woodrum

**Time:** 2023-02-18T15:30:10.390Z

Here is the Github with everything in it.
@jjneeb
check it out if you want to try it for yourself. I am sure the code could be better. I am just happy it works well. I could make it prettier as well.
GitHub
GitHub - ubergeekseven/Mach4-ESS-Gathered: A place to store setup and custom...
A place to store setup and custom scripts as well as documentation spread across the internet - GitHub - ubergeekseven/Mach4-ESS-Gathered: A place to store setup and custom scripts as well as docum...

---

## Post #84 - Jim Neeb

**Time:** 2023-02-18T19:37:20.976Z

MichaelDot:
@jjneeb
check it out if you want to try it for yourself.
Thanks, I appreciate your effort to document things too.  Too many people just get it working and don’t write it down.    I like where you put your tab for this, lots of screen real estate there.  I may have to move my laser offsets tab up there because I’m running out of room in the lower left one.
jim

---

## Post #85 - Michael Woodrum

**Time:** 2023-02-18T20:55:50.771Z

Awesome. I’m glad you like the layout.
I first started in a smaller tab and decided it wasn’t enough. Also, I copied buttons from one page that do not function. I need to replace them with scripts that work. The home all axis and move to xy 0

---

## Post #86 - SUBNOIZE LLC

**Time:** 2023-02-19T01:04:19.945Z

MichaelDot:
I kept trying to find a way to set the machine offsets because there is a set command for it.
Didn’t I send you that code already? I have the same function but with all three values, x y and z if you need it.

---

## Post #87 - Michael Woodrum

**Time:** 2023-02-19T13:10:24.657Z

Yes, you used pound variables to do it right? I found a list of them and then I watched the variables change as I tested moving around and setting things manually to see what I should be looking at in the pound variables. Then I saw a set pos call that exists for machine location and it does not work. It exists, does nothing though. Then I realized I did not need the actual machine coordinate to be set. I just needed to update the current work offset coordinate to match the first probe location once I change tools and probe. It is a super simple way and requires nothing but capturing the first position and the later setting the current position to that first position.

---

## Post #88 - Michael Woodrum

**Time:** 2023-02-19T15:27:10.498Z

Just a little update I had to make to things.
I was testing everything out again this morning and found an issue. It is all fixed in the updated code I have on git.
I was replacing the z offset with an updated value. Instead, I actually needed to ignore that value other than knowing where it was. The m6 script now just uses the original z height of the second plate for all tool changes after that. It always has to equal that height to stay at the right height for the setup.
I also realized that I was storing the z machine height before entering the tool change. This would return it to a higher or lower position depending on tool size. I changed that to store the offset z height and go to that position after tool change occurred. This brings it back to where it actually started the m6 with the new tool lengths.
It fully works now. I have tested for the past hour with different tools to be sure.

---

