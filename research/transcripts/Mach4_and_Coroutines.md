# Mach4 and Coroutines

## Video Information

- **Video ID:** t2xQYvAXT8o
- **URL:** https://www.youtube.com/watch?v=t2xQYvAXT8o
- **Channel:** DazTheGas
- **Upload Date:** 2017-12-17
- **Duration:** 14:42
- **View Count:** 2,456
- **Downloaded:** 2025-10-18 00:41:14

## Description

Simplified explanation of Mach4 and Coroutines

---

## Transcript

hi welcome to another video on Mac for the journalist video I'm gonna try and explain in most simplest terms how a Co lutein works to do this I'm going to use use a dummy bone up here by the dr oz and i'm gonna make a little command

that moves my X my access to a certain position on the machine and well let's just see what happens so the first thing to do I'm gonna go into my screen editor select the button I want to use and what am I gonna do well I'm gonna

move my X Y to the center of the table now fictitiously I'm gonna pretend I got 200 be 200 table so I'm gonna move with the g-code command execute that one or two and we'll give it our instance my X 100 and my Y to 100

I'm even gonna make it so I don't get an error eight no after that let's inform what no way whoops I didn't mean that as a don't way going like let's inform the user we've finished so message box and simple

finished if I can remember it great complete let's come out the editor you'll have to excuse my sniffles of course it's a week away from Christmas and I'm getting a cold it's enabled our machine tester button

Oh so we've got a message box come up that says finished although up the arrows still still going right I know how to fix up quite simple it's going to screen editor st. button and we're gonna stick away on the end there

we'll get another clown called MC control G kxq wait so now is what's gonna happen is we're gonna execute the G code but the goo is not gonna move on it's not gonna do our message box until Mac 4 has finished

executing that command great let's go forth and do it go forth so let's enable our machine they were then back off again let's move to the center Oh what's happened there now according to Mach 4 it's not responding

oh but we finished and add the arrows have not moved the screens not updated no yeah no it's updated so we've blocked the GUI the GUI doesn't work because it's been told to wait until the g-code has finished running and it's

not very nice when you lock the GUI up because it can become unresponsive if you start clicking your mouse about all over the place now this is where colu teens come in handy so let's try and explain what a co-routine is

so this is a piece of code that we one of them and this is our mat for GUI now in an ideal world multi-threading we should be able to run these pieces of code the code we actually want and the GUI side by side so from start to finish

that's how the application would work now Lua is not a multi-threading program so we've got a GUI which contains Lua and we've got our code that contains Lua and the way it works when we execute the program it has to run in a single

instance so the code gets run before it hands back to the GUI so this is where co-routines come in let's take our code and we're gonna change this into a coding so how does it co-routine work well first off let's look at our GUI now

our GUI he's got a PLC running in the background so from the beginning it runs it then once it's got to the end it starts again and this is continuously looping in the background of the GUI now if we originally run the

code we would break that loop within the middle causing the GUI to pause a co-routine will execute the code in chunks so let's say our code here has four chunks the first thing it was gonna do it's gonna execute the first chunk

and as you can see while it's running that first chunk the GUI loop physically paused that's where you get your unresponsive Mack for screen now look at our co-routine it's not gone any further so basically it's poor

now when it's paused is Inco routines it's basically what's classed as suspended so somewhere in our gooood loop we need to tell that co-routine to resume now we can resume our co lutein from our PLC our loop but whilst it does send

that coaching resume now our GUI is also gonna stop the plc whilst our Co routine runs the next one but this happens so fast you would never notice at all now once the last chunk of the code has been run our Co lutein comes as what

is classed as dead it's it's no longer functional you cannot resume it again you'll get an error if you try and resume a KO routine that is dead so you know physically that is how a KO lutein works so let's go and write a co

routine now for the commands that we tried earlier so back in Mach 4 I'm gonna go back to my screen area and go to the button which I wanted to use for centering and I'm gonna create a Col routine for these two pieces of code two

pieces two lines of code now to create Ovaltine we have to give it a name and we do that from the beginning so our C table is going to be our ko lutein so straighforward we're going to do a KO routine dot 3/8 and

that's how we create it but we're going to create a function little bit different too if you've looked at the reference all home co-routine it's going to be slightly different so we'll create a function here and then

we'll just do an end we'll drop that down there so what do we want to do in our cocoa team well we want to do this line here now if we were to do a Kovu team with g code execute weight written inside it it wouldn't be

any difference what we had before because mac fours API will do the weight for you so we're going to change that back down to the G code execute we had before and I'm even gonna add G zero zero they're very bad not to put

that in the first place so we've created a KO routine so what do we what do we want to do well we want to run that now to run a KO routine we absolute send their command called yield which physically you know yield

the co routine but after the co-routine is died or finished is what we want to do is add in this message box so let's put that in there and quickly I like these out before I forget now that is our coating now the first time you run that

coating it will not run any of that G count as soon as his coley-cole routine starts it will be started up in a suspended State now that's our bond code as we saw earlier we're gonna need to put something

in our PLC script to make that resume I'm gonna cheat a little bit because there's not many ways of doing this so we might as well use what's already in here if I can remember where it is there so I'm gonna copy out in fact I'm gonna

copied a bit of top as well and I'm gonna stick this down the bottom here so we've got to change these weights it's because the name of our Co routine is C table so we'll quickly change them there so what is this

so what is this actually doing well if I start with beginning it's gonna look for anything that's been declared as see table now if we don't press the button when it runs through the PLC there is no see table so it's

nil you know doesn't exist so this is looking for if the see table is not equal to nil and our map state is idle then we'll do what sit between it now the states of a co-routine there are three states that are running there are

suspended and dead so we're getting a state of the sea table and if it's suspended then we're going to resume the sea table you can even put that the other way around if you like if the state is not equal to

dead you know you can do it that way then resume the sea table now this is the bit where it's bouncing backwards and forwards between the GUI and the co-routine until it gets to that state is dead so let's go and have a look what

will happen if we run that same piece of code now it's just a zero these back heel so same piece of code and as you can see our d arrows are now running and we should get our message box now and that's it that is how a KO

routine works well I hope that's made ko mu teens a little bit simpler for you to understand and not blocking the GUI so and the next video I hope you have a Merry Christmas and if you don't hear from me

before then Happy New Year
