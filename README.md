# World Clock

A program that displays the time of cities around the world. Works by taking a time source and modifying it with a table of timezones. Time source is pulled from system clock or NIST Internet Time Service.

## How to Run

### Prerequisites

* Ruby 2.3.1 or newer. Instructions can be found [here](https://www.ruby-lang.org/en/downloads/).

### Running the program

Navigate to "time.rb" and run with "ruby time.rb"

```
cd ../directory/world-clock
ruby time.rb
```

### Program options

Starting the program will prompt you with options on how to proceed. Option 1 uses your system's time, option 2 pulls time from the NIST Internet Time Service, and Option 3 quits the program. 

The program will update the presented time by continuously printing every second.

Terminate program with Ctrl + C.

## Things to work on

* The program continuously prints new lines rather than update the time of existing ones.
* Only adjusts for Daylight Savings for cities in the northern hemisphere
