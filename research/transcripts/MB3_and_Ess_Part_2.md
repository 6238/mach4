# MB3 and Ess Part 2

## Video Information

- **Video ID:** ry80BT3xGIo
- **URL:** https://www.youtube.com/watch?v=ry80BT3xGIo
- **Channel:** DazTheGas
- **Upload Date:** 2019-05-28
- **Duration:** 17:52
- **View Count:** 6,979
- **Downloaded:** 2025-10-18 00:42:11

## Description

The Simple way I config the MB3 and ESS

---

## Transcript

hi welcome to part 2 of setting up the ESS and MB free combination now it's normally about here at the beginning of my videos I normally give you a brief outline of what I'm gonna do during a video but one thing I need to stress

that one thing I'm not doing in this video is showing you how to wire your machine up it's an overview of how I went about and decided how I was going to connect everything from my machine here to the mp3 board and then setting up the ESS

and Mac for to run all this lot in just a few simple steps so this is what it looked like inside my case before I decided to change to the MB free board I've got an external PWM to analog I've got a breakout board from the ESS port 3

I've also then got another breakout board which was running up to a Dinn for servo drive which I was using for my spindle so I had to rip all of this out and Stark in with the mb3 but I'm so glad I'd done it because this is what my

case looks like now well I don't know about you but I'm I'm pretty impressed I'm happy with that so let's have a look at the steps that I went through to be able to set it up nice and neat and tidy like this

so the first step I took was to go around the whole machine and list down everything that was an input and an output like the lights the pump for spindle to e start step and direction for all the drives enables for the

drives alarm for the drives until I had a complete list of all inputs and outputs so my complete list was my X Y Z and ay axis me limits and home switches spindle one and two MPG lights probes and the e stop now everything came blue

is outputs red is inputs and green are outputs that require a relay for the next step you'll need to go across to a CNC room website and download the mp3 Mon mones the MBA and b3 owner's manual Damona now once you've got this downloaded

inside the manual you'll find a paid page that looks like this which is the MB free layer so I've printed out the diagram from the manual and I've taken my inputs and outputs from the list that I previously made I've had a bit of a

shuffle about different ideas and this is what I've come up with I'm happy with it so this is how I'm gonna go and wipe out in the machine so that's the machine all wired up but something we're gonna do to make easier

for ourselves before we go into the ESS config is if you have a look in the owners manual you'll see a table like this notice this table is already set up for the mb3 profile that's already pre-configured for you which I'll show

you later on in the video now all these numbers down the side XS XD ys & yd they actually correspond with the pin numbers who on the board XS x d ys and yd and of course all the inputs and outputs as well so to make

things a little bit easier i've created a small spreadsheet this is done with Google sheets I will upload this to the forums so anybody else can use it so everything that you've wired up if you ever look at the pen name that

you've wired it to they tell you up with all of these on this sheet so mine actually transferred across from Wow and out came out and looked like this now this this isn't just a left once you'll actually see how helpful this is now for

setting up the config within the ESS config within Mach 4 so here we are in Mac 4 I'm going to assume that you've got your Mac four loaded and installed and the plug-in for the ESS smooth stepper if you haven't installed your

smooth stepper yet there's some great advice over on the warp 9 site there is just so much information on this page here it's against like say it's the getting started page and everything you'll need to know about a smooth stepper for

getting it up and running is all all on that page there so from that for now I haven't actually got an ESS connected to this machine but I can still get into the config to show you how now to config your ESS config to run with your mb3 now

if we go into the ESS config one thing that will happen is this configuration screen will always be on top now if we go back to the sheets that we made earlier this is we transferred all these across from the ball now we wide out but

this is actually a duplicate here of our config that we're now going to set up in here now if we go across from tab to tab general don't really need to change anything in there because if you're the ESS is already set up then your IP

address is all the same I never had to change the plug-in frequency or the buffer size motors we're using step and direction one thing I will enable is the anti clunk or low um using hybrid step OHS step hose what's a stepper hybrid

steppers that does make a difference during home in on my machine now the spindle we're going to be using PWM and the base frequency which is written down here on the she is two hundred and sixty Hertz smoke we don't

need laser pins comfy if we notice here on the first screen we've got a port two pins two to nine direction and we're going to port three pins two to nine direction then they can be either inputs or outputs now to set

up with the mb3 as it's written at the top here port two needs to be inputs which it is and port for to be outputs so we'll just change them over next is all we need to do is copy everything that we've put into port one from pin

one to pin seventeen and transfer that across to here now on our seat that we created port one pin one is our spindle to enable so that's already named or given an alias to that pin itself now I'm going to go across I'm not gonna do

this while you watch me I should go across and transfer a whole lot of this into the ESS config and then I'll bring you back so that's all our pin names transferred across to the ESS config so let's go across now and let's map some

input signals now on our sheet all our inputs are in red so our X minus limit stroke home will be this one here so we can give that a limit and home and of course is apart from just being a home is our motors zero minus limit and next

one down X plus limits which is mo 0 we can assign that to that one so that's the X done do exactly the same with the why and then we can do exactly the same again with our said limit now that's our Z plus and home so don't get it mistaked

and put it down here so that's gonna be this one up there so that's all our inputs from port 1 already put onto here so let's do exactly the same with port 2 and there are some important things and then I'll bring you back again so that's

the other two ports added and we've added our he stopped our MPG 2 probes and our spindle index so let's now hop on to our output signals so with outputs we're going to map them exactly the same as we did with the inputs but apart from

we're going to read all the blue ones off of our sheet so we would just fill them in X step X directory why do I call it directory direction and then we got our Y and Zed so that's all our outputs assigned which next one we've got the

green ones which is our three relays on the board and these become why do we got SP one enable SP one forward so we're on a spindle so we've got our spindle on which is our SP one enable spindle forward which is SP one forward and

we're gonna need SP two with she's gonna become an output zero so that's all our relays put on there which only leaves us our not to ten signal for spindle which is our PWM here is our zero to 10 volts now that is exactly how

I've set my machine up exactly how I've shown you in them few steps now that is the manual way of setting up the MB free and the ESS now if you're just starting out and you're little bit unsure let's show you a little different way which is

an MB free profile that's already set up for you now to use the ready-made profile for the MB free if you go to the CNC room for them website you scroll down the page for the MB free you'll come across this Mac for a SS plug in 2

3 2 and the mb free profile now if you download that file and then open up the archive or the winzip filed it downloads you'll find it's got a plugins directory and a pro files directory now I'm not going to show you how to install the ESS

plug-in because hopefully you've already done that and I think - 3 - I think we're on to 40 now so you'll get an updated plug-in but let's do the profile now from your Mac for installation directory you've got a directory called

profiles so if you drag or copy your mb fee from the zip file over into mac 4 and then we'll start off Mac 4 and load the mb free profile and yes as you can see the ESS thing give me a problem this time

I'm actually plugged one in now if we go to configure plugins and the ESS now we've got a profile that's already set up everything is configured for you in here now all these that have been input here or your inputs and your outputs is

the board set on default now all of those pins tally up with what's in the manual and as you can see we've now got this same sort of spreadsheet cheap spreadsheet that that I used for mine but this is the one for the default

profile now if you using that profile everything in this manual like setting up the drivers I use in what's already set up in the profile your limit switches and everything are all set up and even the diagrams are using the pin

numbers they're set up in them profiles even down to the mpg using the high speed inputs that is just the most simplest way of getting your machine up and running from scratch is just to connect everything how it shows you in this

manual there is some experts down the bottom here that show you that's Mack free if you go past that you'll actually get some help to set up your Mac for profile with your motors and things like that and like I say that is the easiest

way of doing it from scratch but my machine was already configured in a different way coming from the MB too so that's the whole reason why I've done it that way well I hope this video has been of some use to somebody and I'll see you

in the next video
