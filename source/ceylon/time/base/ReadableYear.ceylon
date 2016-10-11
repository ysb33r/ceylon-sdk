import ceylon.time {
    Date,
    DateTime
}
import ceylon.time.timezone {
    ZoneDateTime
}
"A common interface of all year like objects.
 
 This interface is common to all data types that
 either partially or fully represent information 
 that can be interpreted as _year_."
see(`interface Date`,
    `interface DateTime`,
    `interface ZoneDateTime`)
shared interface ReadableYear {
    
    "The year of the date."
    shared formal Integer year;
    
    "True if the year of the date is a leap year."
    shared formal Boolean leapYear;
    
}