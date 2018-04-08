#!/usr/bin/perl
#
# Copyright 2014 Pierre Mavro <deimos@deimos.fr>
# Copyright 2014 Vivien Didelot <vivien@didelot.org>
#
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# This script is meant to use with i3blocks. It parses the output of the "acpi"
# command (often provided by a package of the same name) to read the status of
# the battery, and eventually its remaining time (to full charge or discharge).
#
# The color will gradually change for a percentage below 85%, and the urgency
# (exit code 33) is set if there is less that 5% remaining.

use strict;
use warnings;
use utf8;

my $acpi;
my $status;
my $percent;
my $ac_adapt;
my $full_text;
my $bat_number = $ENV{BLOCK_INSTANCE} || 0;
my $charge_status;
my $battery_percent_status;

# read the first line of the "acpi" command output
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected output
if ($acpi !~ /: (\w+), (\d+)%/) {
	die "$acpi\n";
}

$status = $1;
$percent = $2;

sub is_charging() {
    if ($status eq 'Discharging' || $status eq 'Full') {
    	return 0;
    } elsif ($status eq 'Charging') {
    	return 1;
    } else {
    	open (AC_ADAPTER, "acpi -a |") or die;
      $ac_adapt = <AC_ADAPTER>;
      close(AC_ADAPTER);

	    if ($ac_adapt =~ /: ([\w-]+)/) {
		     $ac_adapt = $1;

		     if ($ac_adapt eq 'on-line') {
			      return 1;
		     } elsif ($ac_adapt eq 'off-line') {
			      return 0;
		     }
	    }
    }
}

sub create_printable_symbol {
    my $symbol = $_[0];
    my $spacing = " " x 2;
    return "$symbol$spacing";
}

sub get_charging_status() {
    if (is_charging() == 1) {
        return create_printable_symbol("");
    } else {
        return "";
    }
}

sub get_battery_status() {
    if ($percent <= 10) {
        return create_printable_symbol("");
    } elsif ($percent <= 25) {
        return create_printable_symbol("");
    } elsif ($percent <= 50) {
        return create_printable_symbol("");
    } elsif ($percent <= 75) {
        return create_printable_symbol("");
    } else {
        return create_printable_symbol("");
    }

}

$charge_status = get_charging_status();
$battery_percent_status = get_battery_status();

print "$battery_percent_status$charge_status$percent%";

exit(0);
