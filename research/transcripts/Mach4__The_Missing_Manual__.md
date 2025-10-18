# Mach4: The Missing Manual ?

## Video Information

- **Video ID:** G85p1VsD3lk
- **URL:** https://www.youtube.com/watch?v=G85p1VsD3lk
- **Channel:** Build Bug
- **Upload Date:** 2020-04-10
- **Duration:** 24:45
- **View Count:** 3,579
- **Downloaded:** 2025-10-18 00:42:31

## Description

Slide deck presentation of the high level architecture of Mach4 learned during my effort to create a Mach4 module. The Mach support forums are the source for most of the information provided here. My goal was to distill some of that information in this video to help others learn faster.
-https://www.machsupport.com/forum/index.php
-https://www.lua.org/
-https://www.wxwidgets.org/

---

## Transcript

so I wanted to make a video about coding in mock four through my experience trying to get the Z touch plate module up and running I learned quite a bit about the entire sort of environment I feel I kind of had an unfair advantage

I've been coding professionally for longer than I'd like to admit I've never used Lua or mock four before so anyway this stuff I learned I kind of want to share basically the gold standard for the documentation for mock for is out

here in their mock for Hobby Doc's directory so basically all these PDFs and charm vials form the documentation ones I found most useful as a scripting manual and the API core which is really good when you're actually coding and so

you know this is sort of documentation that is pretty fine-grain so this basically helps you when you're actually coding you know it tells you what what methods are available and what to pass them and what they return and things

like that but some of the hardest things that I found to understand was the higher-level architecture is how are things laid out in mock four and what's going on with all these files and and various threads and things and so I

thought I'd focus on that because I thought you know a lot of that information was kind of hard to find it's basically everything that I'm gonna talk about here today I've learned from reading this documentation as well as

sort of scouring the mock for support forums there's a lot of good information in those forums and not all of it percolates out it's sort of buried in there you really have to get around so since I didn't see any videos like this

on the interwebs I decided I should make one so here it is here's my attempt if you're a you know mock forward coding wizard or even even one of the architects and you notice I say anything incomplete or incorrect please say

something and we can get it corrected because I just think it's important for this stuff to get out there I think a lot of people use mock for and it you know it's you know I mean these are milling machines

this stuff can get dangerous in the real world so it's important to get good at this if we're gonna modify and you know extend the functionality of this software so anyway here's my my go at it I threw together this little slide deck

to talk about certain things and so here's sort of my view of the skills that are kind of required to get good at coding in mock 4 the first one here in this circle is the Louis Lua programming language so I've never used Lua before

but I've coded in so many different languages that what's going on in Lua is not very particularly surprising but I think if you're just starting out coding or maybe you're just coming from a different language what's going on in

Lua can be a bit jarring if you're not aware of it so I was just gonna point out some things I think is beyond the scope of this video to be a tutorial about the Lua programming language but this is one of those areas that at least

to give you an idea of maybe the things that you should be aware about but maybe aren't and so it will help you go and read up on them so you aren't surprised by things that are going on in the language and then the next paradigm is

this second circle which is WX widgets toolkits so this is a cross-platform toolkit for making desktop user interfaces and so there's a bunch of tools that are very similar and so I feel like if you've used one of them you

kind of get the gist of it there they're all different they're all snowflakes but you kind of get the the broader idea so if you haven't used one before or certainly if they haven't used WX widgets just expect that you're gonna

have to learn something about it and so so that's another sphere in the in the mix here and then lastly here is Mach 4 code organization and this is one of the areas where I thought the documentation kind of felt

work is it doesn't really give you a good idea of the the the high-altitude view of how is this stuff architected what is running who does what and so that's what this video is attempting to address is some of that code

organization and so I feel like a lot of the best information that's out there is on those forums on on mock for support and it's not in the documentation at least I didn't see it so anyway this little little triangle like shape here

in the center this is the the place we'll probably all have to to enter to get at least reasonably good at coding in Mach 4 so I thought I'd first talk about some aspects of the Lua programming language that you should be

aware of and if you're not then you can go and do some research on it so your aren't surprised and so first thing is dynamically typed basically these are the types in Lua there aren't that many of them you know other other languages

have a lot more but the key here is that in certain in other languages like say Java when you declare a variable you say this is a string and whatever I do in the future if I'm ever dumb enough to try to put a number into a string

complain about it throw a compiler error so that I can fix it and essentially this that that's what we usually call a strongly typed language and so one of mine is Luud doesn't behave that guy Lua treats variables essentially as as

containers their buckets or bins that you put things in sometimes you put your shirt in in the bins sometimes you put a car tire and the variable is just a container a bucket for whatever and so these are the various types that can go

into the bucket and so you can create a variable and then assign it nil which is essentially nothing null and then you know the next line you can assign a boolean to it or a number or a string or you know a thread or a table and so this

gives you a lot of flexibility but it also gives you enough rope to hang yourself so you can do some some horrible things in your own code and the compiler is just not going to help you out so it gives you flexibility and the

cost is your you're responsible for what's going on and so it's just something to be aware of if you're come from some other programming paradigm next up is that this is essentially functional programming as you see here

one of the types is a function many languages don't support this is all a function is a different thing it's not it's not what they call that the first order type or first order object and so this means that you know I can assign a

function to a variable and that means I can pass it in to other functions I can return it from functions I can be a lot more expressive with with what I'm doing basically code becomes data essentially and so it's it's good to know that this

language is capable of that and you'll see those idioms sometimes used and you should just be aware of it and if you're not fully versed on it you can go and read up on it so and then the next is lexical scoping I'm not gonna get too

much into it scoping essentially tends to focus on how variables are visible within let's say nested function calls and so each language tends to do this a little bit differently and so Lua uses what's called lexical scoping or even

full lexical scoping and so it's important to know what that is and so so when you see certain behavior in their code you'll understand it so I'm just gonna leave it there to let you research that on your own so and then lastly we

have asymmetric co-routines and so Lua provide LOUIE LOUIE essentially at its heart is is single threaded it doesn't support what other languages would call full multi-threaded features and so it it has something

called co-routines which provides equal and maybe even superior sometimes functionality that looks like multi-threading so bottom line is is a deep topic and it's probably definitely beyond the scope of my ability to to

teach that here but just know that that's available and and and used in this language and so you'll see it eventually and probably at some point you'll want a code one if you're doing anything reasonably complicated in your

in your mock for coding adventures so that's just something to be aware of on to architecture so if we go to the mock for hobby directory we'll see all the executables I think almost everyone is using this mock 4gu exe just launch

their mock for what I want to do here is actually start up the task manager and we'll take a look about what's going on there so anyway I'm gonna launch the GUI and we pop up the profile selector and so we want to sort of watch what's going

on here so we have a select profile obviously so we're gonna collect select one and see what happens so basically you see that we spawned already these child processes so we have a hobby a core and a PMD X smart Bob and

that's what's prompting me here my machine is not connected and so that's what it's complaining about so anyway we've click through this and we'll see essentially we're loading I think they're screen elements and there we go

so the important takeaways here is that we spawn two sub child processes one called mock for hobby and the other mock for core and so if we head back to yours like so here we have that that file the mach

4 GUI executable so this is a closed source it's not available to be read so I don't really know what's going on it but we we can infer what's going on from the task manager and other things we don't really need to to read this code

it's to understand what what's going on and so so as we saw the mach 4 GUI executable spawns to child processes the GUI and the core and it's important to know that these are just separate processes and they they communicate with

each other but in you know it affects our mental model of what's going on in the code and so so let's start with the GUI so it's written in Lua it uses WX widget toolkit for the UI stuff and it primarily exists to allow users and

vendors to customize Mach 4 from functionality in the previous version of Mach Mach 3 the core and the GUI were mixed together they're essentially combined and you use Visual Basic 2 to code both of them and I think that at

some point they hit the wall as as far as what was possible as far as customized ability and so they decided to separate out the core from the GUI which is probably not a bad idea and so they wrote their GUI in in Lua but you

don't you could write your own you could write your own in c-sharp in Java and C++ whatever the important thing is that the the core now provides a separate functionality from that and they allows them to evolve sort of independently so

moving on to the core the core is written in C++ and it's built so essentially like an operating system it's true there to provide services that control the motion at a very high level and the details of that motion are

essentially implemented implemented by plugins and so here we have interfaces with hardware via plugins and so this allows companies like PMD or warp 9 to to build Hardware controllers and then write software

plugins for mop 4 to go with their products and in order to make all that work Mach 4 is exposed an API and so if we go back out to the file system in the docs directory so this guy so essentially this is the core programming

interface it's basically defines all the methods that you can call to control the core and that's essentially what's being used by the GUI and by any GUI you would make any code you would write to extend

this GUI you will be doing the same thing so anytime in your Lua code where you see MC dot essentially you're calling into the mock core and these are the functions that provide and the the details of let's say the you know the

movement will probably be delegated to one of these plugins to do various things and so that's basically the layout so so as we see the the GUI calls functions in that API and that's it's sort of the main flow is the GUI is

controlling the core it's not the other way around so the other layer this is covered in the documentation pretty well but the concept of registers so registers is essentially a place to read and write data that is available to both

the GUI and the core so it's sort of a DMZ a demilitarized zone it's it's basically they can both access this data storage mechanism and so it's a very useful way for data to be passed or shared between these two processes so

it's good to know that that's there it's documented pretty well so so moving on back to the GUI so if we go to the screen script lua so let's go back out to mock so if we enter the screen editor and then we click on this high-level object

let's not move that let's move that and then come down here to this events tab you'll see these various scripts so there's a screen load script a screen unload PLC script signal script and timer script and so these scripts

together essentially form the code that is the GUI it allows you know this interface allows you to edit them independently and so if I click on this ellipsis will load the screen load script the zero brain editor will launch

and essentially we've made a temporary file so every time you do this you'll get a different file name because it's a temporary file and so it's important to know that in this directory that there's the top-level there's this thing called

a screen script this script file is not here it's not meant to be edited by you in this location so every time you exit the screen script this file is generated by merging together the various the various scripts it's merging together

the screen load unload PLC signal script and timer and so it's provided here mostly as a convenience so that when you use 0 brain editor to debug it will actually open this file to allow you to you know set breakpoints and and step

through the code but you shouldn't be editing this file as it's gonna be replaced each time so that's an important thing to know and so back to the deck I think I'm not gonna go too much into the detail of each one of

these scripts as the documentation I think covers this pretty well but what I will talk about is the importance of the modules so basically the screen load script go back to the code if we search remember this is the screen load script

if I look for the word load there's a section here that loads modules and so here we see that essentially all of this GAC is essentially adding locations to the path so it's important to know that you could have modules in a

in your specific profile let's say you want a module that's only available to one profile then you put it in the profile slash modules directory and thus that module is only available to one profile and if you want it available

globally then you would put it in the top level modules directory and so bottom line is the paths to those locations are being load loaded here the modules themselves are not loaded until you use this essentially function called

require and so here the MC master module is being loaded and then MC probing module is being loaded and the error check module so anytime you see the require is when a module is actually being loaded so back to the deck here so

you see there's lots of modules that are available and certainly the paths are loaded but the the the actual code itself may or may not be loaded based on what's what's needed at the time so it's important to know that and so back to

the core so one of the first things the core does is it loads its dynamic link library that's mock for code DLL I think it's not too important to discuss this but it's just important to know that that that dynamic link library which is

a Microsoft's way of wrapping up shared code is is being loaded and then that thing itself is loading the plugins and so there a lots of different plugins some are written by mock for and others by third parties like PMD X and you you

may install a whole bunch of them more or they're a few of them this MC Luo Wan is important we'll talk about that in a while it's green here because it's indicating that it's using Lua everything on this screen actually is is

mark green is written in Lua so this was this is kind of an important point we'll get to in a second so anyway there's keyboard inputs which is a common one then your controller plug-in itself I use the PMD x4 to four so I

have a PM DX plug-in you may use ESS and have their plug-in it's also worth noting this is kind of the root of if you've ever had you notice when you start mock for GUI if there's if it's ever error it out and says there's

already an instance running a common thing that happens is that something will go wrong in the plug-in and this plug-in will hang when this GUI closes and and it tries to kill the dollar process of the core but it doesn't die

it stays alive and the GUI disappears and then when you try to start it up again it has a guard where it says hey there can only be one core running at any one time and so you have to go into the task manager and kill it so so

basically this is sort of exposing the reason why that that happens and so it's possible that something goes on wrong in this plug-in for the controller it doesn't close cleanly or it doesn't close at all and the core is left

running or hanging so just be aware of that I will do a little bit of hand waving here is that I know when you install a plug-in there oftentimes UI components that come with it I'm not exactly sure how that mechanism is

working I assume the core provides some ability to inject some UI components but I'm just gonna leave that alone maybe somebody else that can provide more details on that but that's a thing just to be aware of and then this reg file

plug-in which sort of handles interacting with the registers and then Modbus and there's there's you know sort of an endless variety of these but it's just important to know that the plugins are getting loaded by the core and

they're in the core and so that was a piece of information that took me a while to discover and so here we have macros and so for all of us you know more focused on the machining part of it when you have these M

functions it's very common to want to override or add functionality to the various things they can do you know to tool changes and and all sorts of functionality that may be specific to your operation obviously want to go here

and so those are written in Lua and so it was when I first got into this I was convinced that these macros were all loaded by the screen script but they're not they're actually loaded by the core and the core doesn't know anything about

Lua it doesn't want to know anything about it but it has this plugin which provides that facility and so here the the macro functions are written in Lua but there it's important to know that they're in

there just a different process they're there they're totally separate so you can't share data that's in let's say the screen script with one of the macros because they're just not running in the same thread at all so I just wanted to

clarify this point you can share data between the macros and the GUI code but you have to use the registers do it you can't assume since they're both lua that they're sharing the same scope they're not only not in the same scope they're

not even in the same process they just don't share memory like that and so that's important to know and so there's essentially a very common way if you if you want to write code that the various macros can share amongst themselves it's

typical the pattern is to just write a file and you name it whatever you want in my global macro code and as long as it ends in an MCS it will get incorporated and compiled together as a lump into this WX lua and so in that way

the various macros could share code that's written in this file and so that's one way of sort of sharing code and then the other way is that the this load underscore modules which is comes from mock four is actually enables you

to load module and so they just like the screen script can load common or communal data that's that's in a module and then use it amongst themselves here in the macros but it's important to realize that

they're they're not the same instance you know this this has a separate running it's basically importing them separately than the screen strip that you can both use them but they're they're separate so

I think that's an important detail that that was lost on me in in early on so I think that's that's pretty much all I have that's the end of my slide deck I hope this was useful to somebody I think a lot of this information took a while

to to pull together for me and if it is documented well somewhere please somebody put it down in the comments cuz I couldn't find it so anyway thanks for watching
