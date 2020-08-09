# reperl
From-scratch rewrite of Perl 5 written in C.

## Design Goals
The primary reason for this project's existence is Perl's
age. An amazing programming language and an indispensible
day-to-day tool for many of us, perl has been around since
[Larry Wall](https://github.com/TimToady) started a movement
in 1989. In the intervening years, however, technologies
have come and gone. Mostly gone, though. And the
ever-reliable perl compiler continues to compile on
[over 100 platforms](https://perldoc.perl.org/perlport.html#PLATFORMS).

This project is not meant to replace perl5, nor the upcoming
[Perl 7](https://www.perl.com/article/announcing-perl-7/)
(nor its sister language, [Raku](https://www.raku.org/)),
but rather provide a simple, clean, optimized implementation
primarily targeted towards x86-64 and ARM processors. The
goal is to provide a leaner, less feature-ful implementation
that will (hopefully) provide a significant speed-boost when
it comes to parsing regular expressions. At least that's the
goal.
