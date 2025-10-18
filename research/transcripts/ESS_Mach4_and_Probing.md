# ESS Mach4 and Probing

## Video Information

- **Video ID:** AthCnSaqV08
- **URL:** https://www.youtube.com/watch?v=AthCnSaqV08
- **Channel:** DazTheGas
- **Upload Date:** 2018-12-27
- **Duration:** 13:32
- **View Count:** 5,555
- **Downloaded:** 2025-10-18 00:41:53

## Description

How to use the probe registers for the ESS in Mach4

---

## Transcript

[Music] hi welcome to another video and this is all gonna be about probing with Mac 4 and the ESS anybody that keeps up with the forum's recently we had another release of bill - 3 - which added some registers in for probing so let's take a

look just what you can do with these new registers that's been added into the plugin before we start let's take a quick look at how mak 4 and the ESS together perform a g 31 probe command so let's do a G 31 X 10 the Mac for will

first instruct the ESS to do this who in turn will then move the axis which is X 10 and once it's either successfully hit or not hit report back to Mac for that is finished and the only thing that Mac for knows is the coordinates of where

the axes are that second it doesn't know it was a success or it was a fail now let's take a typical probing routine and find the center of this 1-2-3 block in almost any probing screens you'll have little box to enter the rough

length of the X that's got a probe so we'll fill this in about 80 mil and the first thing the probing routine will do is get the Z and then move half that distance plus an overshoot to the left it will probe that edge record the

beginning of the probe and then it will do exactly the same the other way it will probe the right-hand side of the block and also record that so the distance between the first record and the second record is your sender so

let's run the same routine again but by mistake let's put the long dimensions and make it well make make the part too short so again we'll gals ed and we'll move across it's about here that you need to quickly

press your East stop before you plunge you probe down onto a hard surface but let's see what happens to this probe from using the registers in the ESS as you can see from a little bit code in we can send our probe back to our start

position and warn the user that the value they entered was well basically not enough so make it greater so let's try this again but this time we'll actually make the measurement too big [Applause] and once again because of our Ella

we've moved back to our star precision and our Center will give us a smaller amount this time so this is all using registers so let's have a look in the background just how to use them so this is the code behind that bun that I was

using for demo purposes I'm not gonna do a tutorial on what to type and that I'm just gonna run you through the first power of it and it will give you a basic idea on how to use the register now to use the register the first thing we need

to do is get a handle to this register which is this top line here and corresponds to what is in the registry itself now the registry you'll see it's got a probe in-state probe in zero one two and three now the only register

you'll need to use is the probe in-state at the top there's probing zero one two and three are the information if you like for each one of the probes of which has been used but when doing a G faerie one you can only do a D 31 on one of the

probes at once so the probe in-state is always going to be the one that's giving you the right information back all the variables etc on the top here are straightforward of what is on the screen like me X length Y length what speed I'm

gonna do things different bits and pieces like that so let's have a look at the code the first line is our G code if you wait which is our first probe which is to get our Z height now we use in decode execute wait because it will

allow the probe to finish before it goes to the next line if we don't do the decode execute wait it will go straight to that if statement whilst it's probing which will then it won't be a minus one so it goes straight

past that and then it will try to do the next decode X cube which Mac four we'll just give it an error as mo not now so let's do our G 31 go down to probe our Zed now if it doesn't hit the Z then we're going to get a minus one back from

that registry and if we do it means we haven't struck obviously so we'll send a message to the user to say that we're going to abort the rest of the routine and then we'll return that in return here does not return just out the if

statement your burn is actually a function if you look in your screen load script so it returns out of the hole of the button now if the register if it does like the register is not going to be minus one so

it will go to the next G code execute weight command which we're gonna raise our Z by two so our Zed height will be at two and I'm going to set an origin so that gives me always a reference that I can send the Zed to that I know is above

our our work stock or workpiece so now we can do our first move to the left-hand side of the stock and we can do this where by moving half the size of excellent plus ten mil I've got on mine which gets us in position for the first

move we're going to make down now we're not gonna do a g1 move to move it down that's how you crash your probe we're gonna use a G 31 command to go down so we're gonna probe downwards if it hits anything if the probe comes back with a

success then we know we've hit the stock so technically we want the probe to give us an error so if we do a G code execute weight and a G Ferdie one down zedd minus a which is basically what we're only moving six meltdown on the stock

but if it comes back and it's not equal to an error then physically to us there is an error so we can then do our G 1 Z 2 are 0 region which was 2 so we're gonna go with G 1 Z 2 and then we're also going to do a G 1 to our X origin

which was our start so now we know that the stocks been here enter a higher value now if it doesn't if it does go down let's take the second example where we had an overshoot so if all of this was okay and we did get a -1 back so we

know we're down past hours it's a fight now we can do the g-code execute way and we're gonna do and I've lost where we am at the moment x-15 there we are start here so G code execute wait and we're going to probe across 15 now if it meet

if it equals minus 1 then it's an error again and it so we're going to send it to our Zed origin and move it to our X origin again to get it out the way if it doesn't if it does hit anything so we're going to go to our next command which

we're going to move move back half a mil and then probe to our stock on the slope VOC rate which I've got here you'll notice that I'm using minus 1 all the time to see you know to see if it's an error now because you're using G code

execute wait you will not get any of the hope state probing probe state contacted during the G code execute wait but the end of it you will always get whether it's a minus 1 or not so for me it seemed so much easier just to use that

minus 1 so hopefully that's give given you an idea on just how to use these registers you don't have to do it the way I've done it where it's all out in one spot you could make your own module with different commands but eventually I

mean all of these on the screen here they all work the old function they've all got error checking on them and I can't crush my probe anymore which honestly I have never done yet that's why you can see it homemade probe

hanging from the bottom of it because I I did plunge my Zed straight down into the workpiece and it curled it up it broke the inside of my probe as well and well I just don't want that to happen again so with the these

no registers and with a little piece of script in behind the buttons with the registers it shouldn't ever happen again well that's been of some use to somebody and I'll see you in the next video but if

you have got any questions about the script or how to use them just leave it in the comments below or on one of the forums walk 9 or Mac for them you'll get them answered so I'll see you in the next video
