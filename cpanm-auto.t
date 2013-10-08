#! /usr/bin/env perl

use strict;
use warnings;

use feature 'say';


use Test::More 'no_plan';

BEGIN { push @ARGV, 'test'; require_ok('cpanm-auto') }



use List::MoreUtils 'uniq';


my %packages;
my @expected = qw(libxslt1-dev libxml2-dev libgdbm-dev libmysqlclient-dev);

for (qw(libxslt libxml2 libgdbm libgdbm_compat libgdbm)) {
	App::cpanminus::AutoResolution::determine_devlib($_, \%packages);
}

App::cpanminus::AutoResolution::determine_file('mysql_config', \%packages);
App::cpanminus::AutoResolution::determine_file('mysql_config', \%packages);
App::cpanminus::AutoResolution::determine_file('mysql_config', \%packages);

my @packages = uniq(values %packages);
is_deeply([ sort @packages ], [ sort @expected ]);

say "  * ", join "\n  * ", @packages;


__END__
my $obj = {
	lib => 'libgdbm_compat',
	pkg => 'libgdbm_compat-dev',
	pkgs => \my %packages
};
my %matches = (
	'abi-compliance-checker' => [ '/usr/share/abi-compliance-checker/modules/Targets/unix/descriptors/libgdbm_compat.xml' ],
	'libgdbm-dev' => [ '/usr/lib/i386-linux-gnu/libgdbm_compat.a' ],
	'libgdbm-dev' => [ '/usr/lib/i386-linux-gnu/libgdbm_compat.so' ],
	'libgdbm3' => [ '/usr/lib/i386-linux-gnu/libgdbm_compat.so.3' ],
	'libgdbm3' => [ '/usr/lib/i386-linux-gnu/libgdbm_compat.so.3.0.0' ],
);
my $package = App::cpanminus::AutoResolution::disambiguate($obj, %matches);

say $package;

