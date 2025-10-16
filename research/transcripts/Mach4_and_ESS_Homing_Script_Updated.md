# Mach4 and ESS Homing Script Updated

## Video Information

- **Video ID:** HhcCGt0Lywo
- **URL:** https://www.youtube.com/watch?v=HhcCGt0Lywo
- **Channel:** DazTheGas
- **Upload Date:** 2015-09-17
- **Duration:** 4:48
- **View Count:** 4,262
- **Downloaded:** 2025-10-16 05:33:08

## Description

Updated the script to show the correct machine co-ords.

---

## Transcript

hi and welcome to another video on Mac 4 and this one is an update to the homeing script that I wrote quite a while ago which unfortunately is now broken if I do a reference all home from here you'll notice that my offsets have

now been applied of 55 and minus 2 but I haven't got my script running in the background tell it to do the offsets so Mac 4 is actually applying these offsets even though the machine hasn't moved if I go into my screen load script

and I think if I remember rightly we put one in the reference all home button we put in an offset applied variable for it to find if I a these once again so we've got the script running we going have a

look to see what happens to the axis once it's got the offset applied to it again so if we enable the machine and do another reference home as you can see we've got everything as asked for from our offsets a 55 and

the minus two if you take a look at your machine coordinates you'll find it's now doubled up we've got a a 10 10 and a four so we need to make some changes in our script itself so if we go into the screen load

script within the screen editor and go to our PLC script where we've got our homeing script written in here and underneath the MC gcode execute weight we're going to insert this slot we're going to be using a command

called mc motor set home position after we've executed our offsets we're going to tell the machine coordinates they are at them offsets that we've set in the Mac config the command starts off as most commands do

in Mac using the instance that we set earlier on in the script and this does not run by axes this runs by a motor number so the zero is our motor zero and of course we need to tell it what our offset was so we can tell it

what the motor coordinates we need to set it to but it doesn't stop there the mc motor set home Precision is set up with counts per unit on the motor which you would have set up during the M configuration ation but an easier way

for us to convert that is just to multiply our offset by what we've already got in our counts per unit so we can just call that with our MC profile and get our counts of counts per unit for that one motor the zero on the

end is purely a fullback if it doesn't find what it's looking for it will set that to a zero because these are motor offsets if you have any slave drives at all that are homing like I have on motor 1 and

motor 3 are twined together as one axes you must complete this for all the axes that are there and last of all we'll set our aess to our offsets so both our machine coordinates and a axis coordinates are

set exact exactly the same if we now exit out of our lure editor and our screen editor we can enable our machine and we can do a reference all home it'll do the reference home it'll apply the offsets and if you notice the

10 came up and we took it took it back off of it and stuck it back down to five where we wanted it so our machine coordinates and user units are now more aligned with each other well I hope you enjoyed the video and once again I'll

see you in the next video thanks for watching
