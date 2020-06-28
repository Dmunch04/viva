module viva.time.date;

import viva.types.number : clamp;

/++
 + An enum containing each month
 +/
enum Month : ubyte
{
    january = 1,
    february,
    march,
    april,
    may,
    june,
    july,
    august,
    september,
    october,
    november,
    december
}

/++
 + A struct containing information about a specific date
 +/
struct Date
{
    /++
     + The day number
     +/
    int day;
    
    /++
     + The week number
     +/
    int week;
    
    /++
     + The month number
     +/
    int month;
    
    /++
     + The year
     +/
    long year;

    /++
     + Default constructor
     + Params:
     +      day = The number of day in the week
     +      month = The month number
     +      year = The year
     +/
    this(int day, int month, long year)
    {
        this.day = clamp(day, 1, 31);
        this.week = 0; // TODO: Calculate week
        this.month = clamp(month, 1, 12);
        this.year = year;
    }
}