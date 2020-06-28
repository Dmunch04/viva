module viva.time.datetime;

import viva.time.time;
import viva.time.date;

/++
 + A struct containing information about both a date and a time
 +/
struct DateTime
{
    /++
     + The time
     +/
    Time time;
    
    /++
     + The date
     +/
    Date date;
}