# MB3 Overview and Setup Part 1

## Video Information

- **Video ID:** ab6PXwBP62A
- **URL:** https://www.youtube.com/watch?v=ab6PXwBP62A
- **Channel:** DazTheGas
- **Upload Date:** 2019-05-13
- **Duration:** 18:21
- **View Count:** 8,333
- **Downloaded:** 2025-10-18 00:42:22

## Description

This is an overview of the new MB3 BoB for the ESS

In part 1 we have a quick overview  of the board
In part 2 we will set it up on a working machine

---

## Transcript

hi well once again I've got another project on the go I've got a 210 lave it's all stripped down at the moment but already stayed on the electrics got the ESS of course and I needed a bob for the lathe now I didn't want anything too too

much because you know the delays only two axes and a couple of inputs and a few outputs that's about it you know didn't want much so I've come onto the walk 9 site having a look at the different bobs that was on there and I

got down to the mb2 and I thought well you know yes the mb2 I've got that running in my mill and I've never had a problem with it it's always done exactly you know it does what I ask of it but then I know it's underneath there's a

new MB free so that got me into thinking well what's know about it apart from it looks good so I've nipped over to CNC room to have a look at this mb3 and just looking down at some of the specs things that jumped

out to me straight away is obviously you only need the single 24 volt power supply which does all the electronics on the board plus it runs the ESS for you status LEDs for all inputs and outputs it is is a big one for me because I'd

like to be able to see what's going on if I'm doing any diagnostic the a no speed - naught 10 volts absolutely great in the MB - is only nought to 5 volts or unless you add an external 10 volt power supply you know to bring it

up to the north of 10 volts let's just you know so much stuff on it that that's completely new I decided on the fact right then I'll tell you what I'll get the mb3 and I'll put that on the mill because it's got more stuff on there

that I'd use on the mill and I'll take the mb2 and use that for the lave so you know that's what I'm thinking of and you know I was mulling it over for a bit and I come across this top panel so far we'd

have a quick look at this top panel $10 and it protects the ESS board asked it's in the case which sounds a right to me so yeah I might as well get one of them as as well but it really that done it for me look at all them flashing lights

I've got to have one of them that's what made my mind up no seriously though it from looking at it I thought yeah I'll go for that so we ordered one and it's come from Thailand and it got from Thailand to the UK in three days now

that's what I call service when I bought the mb2 it was exactly the same you know very speedy service if it says it's in stock it's in stock and it's it's posted out to you straight away so let's sever quick look at what has

come in the post as usual would DHL we've got customs sticker to say that way buddy look we wanna see what goodies anyway this is how it's turned up have the mp3 board obviously a bag of bits hands that is obviously the top

board let's have a look at the board I I was very impressed with this it is so clean and spotless there's there's no splatter marks from the sole in flux residue it's just absolutely spotless and clean so that was a good impression

to start with so let's have a quick overview of the board starting from the top we've got 23 input pins and these are divided up into four sections of a B C and D now a has got 6 inputs B has got 6 inputs C has got 6 inputs and D has

got 5 inputs now any one of these four blocks can be either NPN or PNP the way we do this each one of the blocks is got a common so the CM a that you see is actually common a E and then common be common C and common D now to make an NP

n inputs we would join the common a with the 24 volts now to make a PNP we would cross or join together the common a with the zero volts now for the 5 volt inputs if you've got anything that needs a low

current input like an encoder or an mpg then you'd use the 5 volts but there's a little bit more setup for the five volts which I'll show you a bit later within the video now these four blocks block a B and C

actually 14.3 kilohertz optocouplers that are on here now block D is slightly different as you can see it's settled by itself now that's got five twenty eight point five kilohertz optocouplers on them which is twice as twice the speed

of the other three blocks so it's you know if you if you're gonna run a spindle index or anything like that this is going to want to be on block D moving on to the right hand side we could probably call this the axis side if you

like because basically well it's labeled up as all you axes at X Y Z and yet a B C and D now starting at the top we've got a ground and we got two VC C's and these are five volts and these being fed by DC to DC converter which is this one

here but the maximum it will actually output it's six hundred milliamps so if you're gonna use a system for your steppers that you need to feed five volts into them you really might want to think of sourcing that five volts from

somewhere else now incidentally talking about the VCC now if you actually you know sort of like haven't got you read the manual head on in the morning and you go and connect 24 volts to that VCC and gray

then there's a tiny little thing you can't see it in this photograph here but if that's filled a borders I think it's TV is TV s one which is a handy little device and it was very handy for me because if we said try and send 24 volts

through it it will just short out and blow and protect the rest of your board now to recover from that you will have to either replace that TV s1 or like I did on my board I've just soldered the two pads together and it's been working

ever since although I have lost that extra protection on the VCC circuit anyway that was me just being a plonker so don't put 24 volts into the VCC and physically you know that's all I can say about that block there apart from don't

worry if you've only got an X Y Z you haven't lost all them outputs that have been assigned to the I access B axis and C axis because you can still use them as outputs so that brings us to the bottom block of connectors and these are all

outputs apart from the 24 volts and the zero volts so this is your main 24 volt input and it's recommended you use a power supply of 3 amps now it is safety protected and there is a fuse on board purely for that 24 volts so if your

board does go dead for any reason then f1 which is the fuse is just worth checking to the left of these we have a five volt and a zero volt output just for general usage the mb3 has three relays built on

board and each one of these three has got a normally open terminal and a normally closed terminal they've also got a common terminal as there are some jumpers on the back well actually pad you have to cut we'll have a look at

those later on which will disengage the relay and make that pin just a normal output pin now the relays themselves are rated at half an amp 120 volts AC which is not much used to anybody in the UK since we work on 240 volts or 230 in

most places but you can't have one amp at 24 volts DC wise these really are for your forward and reverse and spindle enables on your VFDs this brings us to our outputs and these are all sync outputs and capable of sinking 70

milliamps there's a bit of a drop from the MB to because the outputs were 100 milliamps on them but anyway these are 70 milliamps and per bank of seven you can't use no more than 500 milliamps and last of all down in the corner here

we've got the ana speed 2 circuit and the attitude to Hana to the ana speed 2 circuit actually has its own DC to DC power supply so it's supplying its voltage to it it's isolated from the rest of the board and it will not suffer

from any voltage spikes any rise in allowing so the speed you set will always be a constant voltage going to the VFD so that was a quick walk around the board just giving a general overview of the inputs and outputs but we aren't

finished there because we're now gonna flip it over now we have some additional configuration items on the back of the mb3 and these are very well documented within the manual but just a couple of points I'm gonna show you which will

correspond to some of the things that I've shown you on the front of the board now you remember earlier when we was looking at the inputs I mentioned if you're using five volts whether it be NPN or PNP there is an extra step that

you need to take now if we look at the diagrams from the manual you'll see both of these five volt tolerance ones have got this extra little bridge CIN underneath now these little bridges are referring

to these little pads here now if it's got a red link on it and you want to make it five volt tolerant then you need to solder or join these two pads together so as you can see X 3 1 0 which is port 3 pin 10 I'll be using for a

spindle index and it needs to be 5 volts so the pad has now been soldered to join the two together which is made it 5 volt input now you can't put a 24 volt on that now it will damage it but let's take it one step further this is our D

block of inputs which is using the fast optocouplers so so the fast inputs now let's say we only want to use four of those at 5 volts but yet we need another one which is 24 volts so let's assume we've soldered all our

pads on v-103 11 312 and 313 so they're all now 5 volt tolerant now 3 1 5 we want that to be 24 volts as you can remember we've already got 5 volts running on this rail at the top here and this is where we can free that actual

pin 3 1 5 from the rest of that rail and we do that by cutting this tiny little track here now once you've cut the track that X 3 1 5 is no longer a part of that block so we can now solder a link from the bottom

pad of 3 1 5 and we can actually move that across to whether it's block C B or a whatever they're set up as and they become tolerant to whatever they that then whales the self cell so if you've got X - 1 5 set up as a PNP and you

bridge the bottom track from 3 1 5 to 2 1 5 that now becomes a high-speed PNP using that pin in block D no everything else on the back of the board is all self-explanatory it's written in the manual a straight forward if you want to

override the charge pump then just solder them to Prats together if you want the delays on the K 2 and K 1 and relays then you just solder them pads well that's it for this video I will see you in part 2 where we'll get it all

open one in in Mach 4 I know I just couldn't resist it
