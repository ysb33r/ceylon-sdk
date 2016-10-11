import ceylon.time.base {
    YearBehavior,
    MonthBehavior,
    ReadableYear,
    ReadableMonth,
    Month
}
import ceylon.time.chronology {
    impl=gregorian
}

"Combination of year and month implementation based on ISO-8601 calendar system.
 "
shared class YearMonth(year, month) 
        satisfies ReadableYear & ReadableMonth 
                & YearBehavior<YearMonth> & MonthBehavior<YearMonth>
                & Ordinal<YearMonth> 
                & Comparable<YearMonth> 
                & Enumerable<YearMonth> {
    
    shared actual Integer year;
    
    shared actual Month month;

    shared actual Comparison compare(YearMonth other) => 
            switch(year <=> other.year) 
            case(equal) month <=> other.month
            case(smaller) smaller
            case(larger) larger;
    
    shared actual Boolean leapYear => impl.leapYear(year);
    
    shared actual YearMonth plusMonths(Integer months) {
        if ( months == 0 ) {
            return this;
        }
        
        value o = month.add(months);
        value newYear = year + o.years;
        
        return YearMonth(newYear, o.month);
    }
    
    shared actual YearMonth minusMonths(Integer months) => plusMonths(-months);

    shared actual YearMonth withMonth(Month month) {
        if(this.month == month) {
            return this;
        }
        return YearMonth(year, month);
    }
    
    shared actual YearMonth plusYears(Integer years) {
        if ( years == 0 ) {
            return this;
        }
        return YearMonth(year + years, month);
    }
    
    shared actual YearMonth minusYears(Integer years) => plusYears(-years);

    shared actual YearMonth withYear(Integer year) {
        if( this.year == year ) {
            return this;
        }
        return YearMonth(year, month);
    }
    
    shared actual YearMonth neighbour(Integer offset) => plusMonths(offset);
    
    shared actual Integer offset(YearMonth other) => countInMonths() - other.countInMonths();

    Integer countInMonths() => year * 12 + month.integer;

    "Returns ISO-8601 formatted String representation of this year and month moment.\n
     Reference: https://en.wikipedia.org/wiki/ISO_8601"
    shared actual String string 
            => "``year.string.padLeading(4, '0')``-``month.integer.string.padLeading(2, '0')``";
    
    shared actual Boolean equals(Object that) {
        if (is YearMonth that) {
            return year==that.year && 
                month==that.month;
        }
        else {
            return false;
        }
    }
    
    shared actual Integer hash {
        variable value hash = 1;
        hash = 31*hash + year;
        hash = 31*hash + month.hash;
        return hash;
    }
    
}