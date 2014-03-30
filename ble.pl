#!/usr/bin/perl

use common::sense;

my $dev   = 'hci0';
my $major = "00 00";
my $neg   = 0;

my $version = `hcitool -h | grep ver`;
$version = $1 if $version =~ m/ver (.*)$/;
print "Version: $version";

if ($version < 5.17) {
  die "You are using old version of BlueZ ($version), please upgrade for this ".
      "script to work properly.\nhttps://www.kernel.org/pub/linux/bluetooth/\n";
}

while(1) {
  my $temp = sprintf( "%.1f", rand(100) - rand(100));
  chomp($temp);
  print "Rand: $temp\n";
  $temp = $temp * 10;
  if ($temp < 0) {
    $neg = 1;
    $temp = abs($temp);
  }

  $temp = sprintf("%u", $temp);

  my $minor = sprintf("%04x", $temp);
  $minor = join( " ", $minor =~ m/../g);

  if ($neg == 1) {
    $minor =~ s/^./1/;
  }

  print "Temp:  $temp\n";
  print "Minor: $minor\n";

  `hciconfig $dev up`;
  `hciconfig $dev noleadv`;
  `hciconfig $dev leadv 3`;
  `hcitool -i $dev cmd 0x08 0x0008 1e 02 01 1a 1a ff 4c 00 02 15 74 33 73 74 32 33 34 33 00 00 00 00 00 00 00 00 $major $minor c5`;
  `hcitool -i $dev cmd 0x08 0x0006 A0 00 A0 00 03 00 00 00 00 00 00 00 00 07 00`;
  `hcitool -i $dev cmd 0x08 0x000a 01`;
  `service bluetooth restart`;
  sleep(10);
}
