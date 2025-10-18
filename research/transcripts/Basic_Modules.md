# Basic Modules

## Video Information

- **Video ID:** TMzAT0eb3p0
- **URL:** https://www.youtube.com/watch?v=TMzAT0eb3p0
- **Channel:** DazTheGas
- **Upload Date:** 2017-05-28
- **Duration:** 32:36
- **View Count:** 1,496
- **Downloaded:** 2025-10-18 00:40:54

---

## Transcript

[Music] hi welcome to another video and this video is going to be all about modules so what is a module well if you've done any programming in any other language PHP C++ you want to come across classes

these classes is a cluster of function a class of functions just loads of functions put together in one file these are same with lower modules it's called modules instead of classes if you have a look at how many modules

that are in the modules directory in Mac 4 you can see just how cluttered your screen load scripts would become if you piled all of that into there so it can be made a lot tidier and a lot simpler by creating modules our module normally

does a specific purpose this is the master module so it's holding a lot of the functions that Mac 4 will look for when it's getting registers set in registers and saving registers etc etc so before I go ahead and show you how to

create your own custom module I'm going to show you first how to load a module from Mac 4 if you go into the editor and then the screens load script you'll find this little section here now in lower your modules are loaded into a table in

lower called a package table now first off with lower you must tell Lua where this package path is this is the path it's going to look for your lower module now it doesn't only have to be one path you can

put a search criteria in here and it will look in each one of these directories for your module this path here is looking in your Mac for profiles modules directory so it's specifically looking in a profile and then the last

one is looking in the Mac for modules directory once you've loaded a module it stays within this table does not change if if you do the require master module and the master module is already loaded it will skip that require so if you've

made some changes in your master module it will not get loaded again so it's what we need to do is add in this little package dot loaded master module equals nil is what that will do is unload it from the package table which then when

it comes across to the next require master module it won't find it in the package table so it will reload it again great so now we know how to load a module and unload it with the nil command it's going to create our own

module and put some custom functions in it if you go into your operator and edit debug scripts don't worry about putting anything in just for a load of rubbish in there and click open the millwork editor will not find it so

I'll give you an hour but it's opened up your lower editor you can then go save as go to your Mac for how we directly into your modules and then give this a name that you'll remember this your module but it's going to be custom

functions for me so I'm going to put cusp func just abbreviate it then give it the extension of the work and save it you've now got a file within for your modules directory called custom lower right so in our module the first thing

we need to do is declare our table of functions or class of functions so we'll declare that as local hand with a we've called custom funk so we'll just abbreviate it like that and we need to tell it that is a table which is done

simply like that to close off a table or to tell it it's a module close off a module whichever way you want to put it whatever it does in there you want to tell it to return whatever the custom fun function has done and it's as simple

as that that's the start and end of a function they of a module so that is how all of them are done so obviously if we're using women Mac for so one of the biggest things we need to put in here is our instance

which is like so now in the master module you'll see there was functions in there for get register set versus a registers well you can have functions for anything well this is your own custom functions so you could move those

registers over to here even though they're already declared within the master module you can still declare them in here and keep all the commands you use in one spot something is used a lot in Mac for his signals input signals

output signals control signals so all the time we're using a command to get the handle of this signal so then we can get the state of that signal so I'm going to do two custom functions in here to start with which will be to get the

state of a signal and set a state of the signal so start with two functions that seem pretty straightforward to me or something that will be required a lot is to get a signal state and to set the signal state so let's do a couple of

functions so the first function we're going to get the signal state now within a module to show that it is we can't just do get C state whoops which I can do that we can't just do get six state we need to tell it it is part of a

module and we do this by putting the module name in front of the function itself because custom funk is a table and then within that table we're going to put in a function of get sick state so you'll find they all start like that now while

we get in the state off we're getting a state of a signal so from anywhere else in Mach 4 we need to pass the signal across to that function of course function we end next function was function again our custom folks and

we're going to set our sick state what is up on my T there now within this function yes we've got a send it what signal we want the state of or signal we're going to set the scale of and then obviously we've got to pass it the state

of what we want that signal to be so that's two functions let's fill up our get sick and first thing we want to do to get the state of the signal is to get the handle of the signal so let's declare another variable equals

MC and it's a signal command because with one pick it up because NASA made a boo-boo should get it now MC signal gets handled of course we need to pass it the instance which was already decayed as inst

and we need to pass it the signal ID of what we want so we passed from Mac for we've passed to this function sick so that's what we're going to look for is sick so now we've got a handle to our signal we need to get the state of it with once

again we can just use a straightforward state and that is equal to MC MC signal command which will bring up these we've got to get state there as you can see is all we need is the signal handle to get the stay of that so we can just pop in

paid sick great so we've got the state of our signal what do we do with it now well we need to return it to whoever asked for it so we return it and we'll tell it what we're going to return which is going to be the state that function

is complete that's done that's all it needs so let's now do exactly the same with the set register now obviously we need to get the handle for a signal so we can copy and paste that which is going to be

exactly the same now this one's going to be basically the same underneath as well apart from we don't need to declare anything to it at the moment so we can do an MC MC signal and we can set the state we can

set the state of that we've got our H cig again which we've already got and then we can set it to the state of what we've told it to be that's another one as complete now we don't need to return anything in here it's always wise to put

some error check in etc but that's going to come in another part that'll be in advanced modules one this is just straightforward simple get you going stuff so before we move any further and load us into Mac for it's just still a

quick check if anything's okay if we press f5 nothing to add one I don't know why because I'm not highlighted right if we press f5 will now go into the deep bug mode of the editor and you can skip using your every

level all the way through which will just go and check the basic syntax of it it won't go into the MCS it will get handle etc because it's a function it will only declare the functions and check and we know that's okay so let's

go into our file and save and then come out of our editor so we've got a module called cussed funk and we need to load this into Mac 4 so let's go into our screen editor I like the top of your tree which we can then find our screen

load script and we'll go to the module section we'll keep it all together which is here so we go let's this is going to be our cash Bank model again we need to unload it in case it's already loaded so we'll tell the package

table and all that we called again custom cast front and we'll tell it that equals nil now loading our module we called it cast func now we do not have to call it cast func anything if you notice with all the other packages then

breviary this makes it simple for you to type quicker for you to type but you can call it what you like I'm going to call it CF just short for custom function and the custom function CF is going to be the our module which was just drunk no

need to put the dot lower on the end of it because we've already told that within our package path to look for dot lower files and well I set that should now load our cusp funk module and there's no errors so we've now got

our custom function module running within Mach 4 so let's now test them our new function will go back into the screen editor and I'll use one of the dummy buns which are here you've got one at the top and you've actually got one

at the bomb here so I'm going to go into the left up script of this one and I'm going to get let's say get the state of input 1 so let's declare a variable called state and that is going to be equal to the

value we get from our CF get sick state so now we need to pass the signal to that function that we wanted which is going to be our input 1 that's it and we'll use a bit old message box to output the result from it which is going

to be a number integer so we need to cater to string as the message box requires Springs which is going to be our state we can close it off so let's say I have f5 to go to debug mode and then f11 to skip through it now you'll

notice now we've got an ever it can't access CF which is our module when in debug mode debugging buttons panels anything it tends to be in a local environment but there is a way of debugging and it is a lot better to do it this way

because you'll be debugging your module at the same time as what we what we need to do is come out of here save it obviously go back into your screen and load script now is what we need to get this of working is a part of our screen

load scripts which is our packaged up loaded custom func and obviously the package path we need those to get things going again so back back in our button we'll go back to the left up script and we're going to

put all of that in the topic and it's purely for debugging purposes so what will become that we need our instance the directory path for it to search for and of course the CF require there was what this will do what we now go into

debug mode by pressing f5 it will load our package into the debugger we click open here you'll notice is now debugging our module so now we'll get to the local state equals CF gets it so we press f11 it's now gone to our custom function get

six state and it will actually run what is happening in our module bring us back to the message box which is now for the message box here and we can see that the state of our signal is 0 it's great enough

so let's go one step further let's set the state to one which is going to be C F dot set cig state like that obviously we need it needed to tell it the signal that we're going to set the state of and also what do we want to set it at

obviously one is going to be on or you can do the emceed on true and bits and pieces like that so if we set the state and now press f5 and run this again we can now skip through the functions with f11 again when it gets to here it's

gonna unload the custom function and reload it just in case was making any changes in it so as our function reloaded CF set six state we've gone to the set signal state it's got the handle and it's set the state nothing to return

so it's fine local state we're going to get the state of that input one that we just did so go through same thing and it will return the state and give us the message box which should be what we just set it to which is one so our input

signal is now on so just for the sake of me because is connected to my machine although the powers not on hung stuff like that back over and in fact I don't need to I can just do so my signals back on zero great so that's our first thing

when you debugging you will need those to load your pack each your module within where you're debugging so when we're not debugging we don't need all this power that's up don't need that so let's get rid of that

we can close this off or hide it from the script if you like by doing an open statement like that and then a closed statement which will then just turn that into well nothing basically it won't be there if we come out of the lower editor

quit out the screen area this will now be running from the screen load script if we enable you'll see that command from our module is working and we don't need all that stuff next time you want to edit anything from there they go to

the button if you're going to do any debug in you can just take these back off and then you can run it in debug mode so we've now got our custom module working throughout our mat for GUI one extra little piece we need to do now as

it stands it will not run in a macro as a small addition you need to make if we go to the operator and edit debug scripts you'll find a new script now in your macros folder called load modules this is an addition to 3 3 9 0 if we

open this module up you'll find it's already loading some of the modules this one is loading the error check if you want to load or use your modules within your macros when running g-code then you're going to need to load your

module in this file as well so it gets compiled at runtime when Mach 4 stars up so underneath the attack modules let's add our custom function model model module and quit and save what we've changed so debugging macros is a

slightly different way of doing things if we go to edit macro I've got a memo m101 so here this is our Bob basic layout for a macro in Mac for now once again if I was to go and put the command in here we want to set the stay CF set

sig state of MC dot mystic input 1 set back to a value of 1 if I was to run in debug mode again you'll find we've now got an error it's not loading up the custom module now there's a different way we can do it in our macro now one

thing we want to do is within our macros it's loading other stuff as well you'll notice there was commanding therefore the error checks so let's get the state of our macro exactly how it would be if g-code was running

now we can do that in Mach 4 or lower with a command called do file is what this is going to do it will load our load modules MCS and run that within our macro so the environment of our macro will be exactly how it would be is if

you was running the MDI or running some G code so if I've done an f5 now to start off the debugger go through the f11 you'll notice when it gets to the do file it wants to load the load modules it'll go through so everything cup there

is a lot of effort levels to do when you're going through this stuff like this but you get there eventually so we're now in a state of exactly how it would be if g-code was running all MDI so now we can do our set cig which

goes across as you know it's across there in the background on the input signals is now turned on our input number one so we now know our macro will work perfect and everything's finished debug session is finished I think so

okay now if you want to do it quickly if you're just changing one thing you just want to see if it brings an arrow back you can physically just do a run and it'll go fools whole script something missing in this editor which will be an

absolute fantastic addition as if it had to run two on it where you could toggle we're a break point on it but I can't seem to find anything in this editor they'll do it so we could have just run up to that point of where we need it

then I guess bit off-topic that one but so we know that is now going to work that's worked in a debug environment now we don't need that when we not debugging so we can save let's cancel that a minute I need to change that to number

one just for the demo so it turns a signal on let's save what we've got in there bin just to our Mac for screen again and I'm going to load up the good old Roadrunner and within this Roadrunner I've stuck one of our mo 100

ones in there just to show this will turn on our input number one while still running the g-code and of course I put it in a longest place you could waste some video time in it that's now gone fast I 101 I'll input

one as now come on so we know our module is working is being called from the macro and basically everything is fine well that is the basic way of how to set up a module use it same commands within your GUI and within your macros and it

is exactly the same way as you would do it if you was creating a wizard you could also call that module from a wizard you can call it from a little panel as long as you've got a way of loading it those functions will be right

once but you can use it as many times as you like in different places so there you have your basic steps of creating and loading modules in Mac for whether it's the GUI or g-code well I hope you enjoyed the video and I look forward to

seeing you in the next one you
