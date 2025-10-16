# Mach4 Screw Mapping Explained

*Converted from PDF: Mach4 Screw Mapping Explained.pdf*
*Conversion date: /Users/chondl/learn/mach4/scripts*

---

<!-- Page 1 -->

The map is by motor in the Profile's directory
Motor_ 0 _Map.dat
Motor_ 1 _Map.dat
Motor_ 2 _Map.dat, etc...
It is a comma separated file: Start, Length of screw, Number of points,
point 1 error, point 2 error, point 3 error, etc...
The file format, again, is this:
[start pos], [length of screw], [number of points mapped], [point 1 error],
[point 2 error], [point 3 error], etc...
All positions are in counts. The error is the actual error, in counts. A
negative or positive number.
For example, say you have a screw that is 1 0 0 0 0 counts per inch and you
measure the table every inch and the axis is 2 0 inches. Start would be 0,
length would be 2 0 0 0 0 0 (1 0 0 0 0 * 2 0), number of points would be 2 0 (2 0 0 0 0 0
/ 1 0 0 0 0). You would start at zero and move the X axis precisely 1 inch
(this is where the precise measurement comes in). Then you look at your
screws encoder counts. Say it reads 1 0 0 0 1. That means the error is 1
count positive. If the encoder read 9 9 9 9, then the error would be 1 count
negative (-1).
In the core, we always "add to take the error out". So when we move to a
virtual position, we look up the error for that position in the map and
ADD the error value. A planner position of 1 0 0 0 0 would output 1 0 0 0 0 1 as
the destination point.
If the point is between two mapped points, we interpolate between the two
points. This is why the granularity you choose is important. It
determines the "acceptable" amount of error. It they want 1/2 degree
accuracy, you will need 7 2 0 points per turn. Anything in between a 1/2
degree will be interpolated. But, as you can imagine, it is going to be
pretty close at that point. I'm thinking a point every degree is
probably going to be fine. So 3 6 0 points per turn.
It is a painstaking process to do it right. Super accurate
glass scales can be purchased. They are made for this stuff. It is magnetic and
just sticks to the table. The scale alone cost around $3 K. As you can
imagine, it only works for linear applications.

