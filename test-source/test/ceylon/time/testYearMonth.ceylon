import ceylon.test {
    test,
    assertEquals
}
import ceylon.time {
    YearMonth
}
import ceylon.time.base {
    january,
    december,
    february,
    october,
    Month,
    november,
    march,
    april
}

shared test void testYearMonthComparision() {
    assertEquals(YearMonth(2016, january) <=> YearMonth(2016, january), equal);
    assertEquals(YearMonth(2015, january) <=> YearMonth(2016, january), smaller);
    assertEquals(YearMonth(2016, december) <=> YearMonth(2016, january), larger);
    assertEquals(YearMonth(2017, december) <=> YearMonth(2016, january), larger);
}

shared test void test_jan_1900() => assertYearMonth(1900, january, !leapYear);
shared test void test_oct_1974() => assertYearMonth(1974, october, !leapYear);
shared test void test_dec_1982() => assertYearMonth(1982, december, !leapYear);
shared test void test_dec_1999() => assertYearMonth(1999, december, !leapYear);
shared test void test_jan_2000() => assertYearMonth(2000, january, leapYear);
shared test void test_feb_2012() => assertYearMonth(2012, february, leapYear);

shared test void testYearMonthPlusMonths() {
    assertEquals(YearMonth(2016, january).plusMonths(1), YearMonth(2016, february));
    assertEquals(YearMonth(2016, january).plusMonths(12), YearMonth(2017, january));
    assertEquals(YearMonth(2016, december).plusMonths(13), YearMonth(2018, january));
}

shared test void testYearMonthMinusMonths() {
    assertEquals(YearMonth(2016, january).minusMonths(1), YearMonth(2015, december));
    assertEquals(YearMonth(2016, january).minusMonths(12), YearMonth(2015, january));
    assertEquals(YearMonth(2016, december).minusMonths(13), YearMonth(2015, november));
}

shared test void testYearMonthWithMonth() {
    assertEquals(YearMonth(2016, january).withMonth(december), YearMonth(2016, december));
    assertEquals(YearMonth(2016, january).withMonth(march), YearMonth(2016, march));
    assertEquals(YearMonth(2016, december).withMonth(april), YearMonth(2016, april));
}

shared test void testYearMonthPlusYears() {
    assertEquals(YearMonth(2016, january).plusYears(1), YearMonth(2017, january));
    assertEquals(YearMonth(2016, january).plusYears(12), YearMonth(2028, january));
    assertEquals(YearMonth(2016, december).plusYears(13), YearMonth(2029, december));
}

shared test void testYearMonthMinusYears() {
    assertEquals(YearMonth(2016, january).minusYears(1), YearMonth(2015, january));
    assertEquals(YearMonth(2016, january).minusYears(12), YearMonth(2004, january));
    assertEquals(YearMonth(2016, december).minusYears(13), YearMonth(2003, december));
}

shared test void testYearMonthWithYear() {
    assertEquals(YearMonth(2016, january).withYear(1900), YearMonth(1900, january));
    assertEquals(YearMonth(2016, january).withYear(1970), YearMonth(1970, january));
    assertEquals(YearMonth(2016, december).withYear(2020), YearMonth(2020, december));
}

shared test void testYearMonthString() {
    assertEquals(YearMonth(2016, january).string, "2016-01");
    assertEquals(YearMonth(2015, april).string, "2015-04");
    assertEquals(YearMonth(2016, december).string, "2016-12");
}

shared test void testYearMonthNeighbour() {
    assertEquals(YearMonth(2016, january).neighbour(0), YearMonth(2016, january));
    assertEquals(YearMonth(2015, april).neighbour(1), YearMonth(2015, april).successor);
    assertEquals(YearMonth(2015, april).neighbour(-1), YearMonth(2015, april).predecessor);
}

shared test void testYearMonthOffset() {
    assertEquals(YearMonth(2016, january).offset(YearMonth(2016, january)), 0);
    assertEquals(YearMonth(2016, january).successor.offset(YearMonth(2016, january)), 1);
}

shared test void testYearMonthOrdinal() {
    YearMonth ym1983_01 = YearMonth(1983, january);
    variable value cont = 0;
    for ( current in ym1983_01..YearMonth(1984, january) ) {
        assertEquals( ym1983_01.plusMonths(cont++), current );
    }
}

void assertYearMonth(Integer year, Month month, Boolean leap) {
    value actual = YearMonth(year, month);
    assertEquals(actual.year, year);
    assertEquals(actual.month, month);
    assertEquals(actual.leapYear, leap);
}
