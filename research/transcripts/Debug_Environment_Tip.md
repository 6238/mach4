# Debug Environment  Tip

## Video Information

- **Video ID:** _0WhzbFvoAM
- **URL:** https://www.youtube.com/watch?v=_0WhzbFvoAM
- **Channel:** DazTheGas
- **Upload Date:** 2018-07-14
- **Duration:** 5:35
- **View Count:** 527
- **Downloaded:** 2025-10-18 00:41:23

---

## Transcript

[Music] hi welcome to another video well when you're debugging in Xero brain the one thing that you really need is for the environment itself to be as close as possible to the GUI with what its gonna be working with so let's take an example

let's go and have a look in fact we'll look in the screen load script first now were the bomb I've stuck a fictitious function called myfunc which is just gonna return a text box so let's go in this nice button here in our left up

script and let's just pretend that function requires the machine to be enabled so the first thing we want to do is enable MC in a ball there enable and to use this we're gonna need the inch number and obviously a 1/2 say we want

it enabled and then we want to run my funk whatever arguments is now the screen load Swift is everything in there is global it will work around the whole of the GUI so if we run this file everything should be ok but if we run it

you'll find it doesn't even know what our inst is so it's not very global within the debugger so it's not running in the correct environment now a nice thing that is within zero brain is the ability to run another

file when you go into debug mode now Mac for every time you come out of the screen editor it saves this file here called screen script dot Lua now really you should be able to tell it says start file and is what it will do

is when you press f5 it should run that file first but the problem is it can't activate the file now if yours to load the file and go back to this one and do exactly the same do you f5 if I pressed f5 no hang on I'm

going to try again f5 now it's what its gonna do it's gonna want you to step all the way through that screen script dot lower so as a workaround to get your environment in well this is the way I've been doing it for a long while you can

get rid of that and we can use something else and we've already got a command in Mac four and it's called in editor in adage foe in edit poor and if that is equal to one then is what we can do he's a do file so that do file we can

put our screen script and it's a doctoral file you need to put your extension in there and we can do it like that so let's step into our file yep it's in in the editor so it's gonna do that so we can enable our machine which

is done and it would then run our myfunc and that should be the end of debugging so that now brings your debug environment just like you GUI would be you don't need to keep declaring your instance and you know rewriting

functions loading modules within it you just need to use those three lines at the top of your zero brain-dead oh well that's it I hope I've bored you enough and I'll see you in the next video
