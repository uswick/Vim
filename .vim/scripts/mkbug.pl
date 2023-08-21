#! /usr/bin/perl -w

use Getopt::Long;
use File::Basename;


###########################################################################
#
# myexec --
#
#       Executes $cmd and minor error checking 
#
# Results:
#       Errorlevel of the test unless $returnOutput is 1, then the output
#       of the command is returned.  undef on failure to run the command.
#
#
###########################################################################

sub myexec
{
   my $cmd = shift;                # IN: Command to run.
   my $returnOutput = shift;       # IN: If true, return the output.
   my $dontRedirectStdErr = shift; # IN: Ignore stderr, windows can bug out.

   my $startTime = time();

   if (!defined($returnOutput)) {
      $returnOutput = 0;
   }

   my $openArgs = " |";
   unless ($dontRedirectStdErr) {
      $openArgs = "2>&1 |";
   }

   unless (open(CMD, "$cmd $openArgs")) {
      Log(0, "Error: $!\n");
      return undef;
   }
   my $output = "";

   my $outputLine;
   while($outputLine = <CMD>) {
      $output .= $outputLine;
     print($outputLine);
   }

   unless (close(CMD)) {
      if ($!) {
         print("Could not close pipe to $cmd: $!\n");
         return undef;
      }
   }

   my $elTime = time() - $startTime;
   my $timeString = "";
   if ($elTime > 3600) {
      $timeString .= sprintf("%dh ", $elTime / 3600);
   }
   if ($elTime > 60) {
      $timeString .= sprintf("%dm ", ($elTime / 60) % 60);
   }
   $timeString .= sprintf("%ds", $elTime % 60);

   return $returnOutput ? $output : 1;
}

###########################################################################
#
# Usage --
#
#       Returns the usage information for the script as a text string.
#
# Results:
#       Above
#
# Side effects:
#       None
#
###########################################################################

sub Usage
{
   my $scriptName = $0;
   return <<EOM;
Usage Information:

        $scriptName
                [-b|--bug <s>]       [-h|--help] 
                [-l|--label <s>]     [-d|--dereference] 
                [-f|--files <s>]     [-v|--verbose]       
                                     [-s|--footprint] 
        bug           - Bug number
        label         - Will be used to create a folder inside bug directory
        files         - Files to upload to /bugs/b/u/g/label
        dereference   - Always follow symbolic links
        verbose       - Explain files being uploaded
        footprint     - Leave a footprint (bug#_label) in uploaded log directory
EOM
}


###########################################################################
#
# LeaveFootprint --
#
#       Leave a file of 'b/u/g/d/i/r/label' in uploaded log directory
#       as a footprint, which could be used to indicate the association
#       of bug.
#
# Results:
#       Above
#
# Side effects:
#       None
#
###########################################################################

sub LeaveFootprint
{
   my $options = shift;
   my $upfile = shift;
   my $signature = 'bug_' . $options->{bug} .  
                   ($options->{label} ? '_' . $options->{label} : "");
   my ($file, $folder, $suffix) = fileparse($upfile);
   $signature = $folder . '/' . $signature;

   unless (!-d $folder) {
      unless (myexec("touch $signature")) {
         print("*** Failed to leave signature\n");
      }
   }
}


###########################################################################
#
# UploadFiles --
#
#       Upload given files to bug diretory
#
# Results:
#       Above
#
# Side effects:
#       None
#
###########################################################################

sub UploadFiles
{
   my $options = shift;
   my $bugdir  = $options->{bugdir};
   my @files = split(/\s+/,$options->{files});

   my $cpargs = "-R";
   if ($options->{verbose}) {
      $cpargs .= " -v";
   }
   if ($options->{links}) {
      $cpargs .= " -L";
   }

   foreach my $file (@files) {
      print("*** uploading __ $file __\n");
      if (myexec("/bin/cp $cpargs $file $bugdir")) {
         if ($options->{footprint}) {
            LeaveFootprint($options, $file);
         }
      } else {
         print("*** Failed to copy $file: $!\n");
      }
   }

   print("*** Setting all files permission to 777\n");
   unless (myexec("chmod -R -f 777 $bugdir")) {
      print("*** Failed to set permission\n");
   }
}


###########################################################################
#
# main --
#
#
###########################################################################

sub main {

   my $options = {};

   # Default options...
   $options{iters} = 1;
   $options{pause} = 0;
   $options{links} = 0;

   #####################
   ## Process Options ##
   #####################

   GetOptions("help|h|?"                => \$options->{helpflag},
              "bug|b=s"                 => \$options->{bug},
              "files|f=s"               => \$options->{files},
              "label|l=s"               => \$options->{label},
              "verbose|v"               => \$options->{verbose},
              "dereference|d!"          => \$options->{links},
              "footprint|s"             => \$options->{footprint}
              )
      or die Usage();

   if ($options->{helpflag} || !$options->{bug}) {
      die Usage();
   }

   my $bugnum = sprintf("%08d", $options->{bug});
   my $bugdir = '/mts/bugs/files/' . join('/', split(//, $bugnum)) . 
                '/' . ($options->{label} ? $options->{label} : "");
   my $bugmount = `mount | grep /bugs`;

   unless ($bugmount) {
      print("*** Mount /bugs directory\n");
      unless (myexec("sudo mount bugs.eng.vmware.com:/bugs /bugs")) {
         print("*** Failed to mount /bugs directory: $!\n");
      }
   }

   print("*** Create $bugdir\n");
   unless (myexec("mkdir -p $bugdir")) {
      print("*** Failed to make $bugdir: $!\n");
   }

   if ($options->{files}) {
      $options->{bugdir} = $bugdir;
      UploadFiles($options);
   }
   print("*** done -- see http://engweb.vmware.com$bugdir\n");

}

main();

