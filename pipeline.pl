#!/usr/bin/perl -w
#requirement: (1) bowtie2;
die "Usage: perl $0 <file1> <file2> ...\n" unless @ARGV >0;

my $ref = "allergens.fa"; #the reference should be bowtie index

my @FILES = @ARGV;
#print "processing files: @FILES\n";


#--check if the file exists
my $numFileNotExist = 0;
foreach my $f (@FILES)
{
	unless(-e $f)
	{
		print "$f does not exists\n";
		$numFileNotExist++;
	}
}
if($numFileNotExist >0)
{
	die "$numFileNotExist files do not exists!\n";
}

my %h;
#--map and count mapped reads
foreach my $f (@FILES)
{
	my $outF = "$f\.sam";
	my $outLog = "$f\.log";
	my $outErr = "$f\.err";
	my $tmp = `bowtie2 -x $ref -U $f -S $outF 1>$outLog 2>$outErr`;
	open IN, "$outF" or die "cannot open $outF\n";

	while(my $line = <IN>)
	{
		next if $line=~m/^@/;
		$line=~m/NM:i:(\d+)/;
		my $m = $1;
		my $n = 0;
		while($line=~m/(\d+)M/g)
		{
			$n+=$1;
		}
		if($n>=100 and $m/$n<0.05)
		{
			my $chr = (split /\s+/,$line)[2];
			$h{$chr}++;
		}
	}
	close(IN);
}

#---output
foreach my $key(sort{$h{$b}<=>$h{$a}}keys %h)
{
	print "$key\t$h{$key}\n";
}
