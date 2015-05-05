#!/usr/bin/perl
#
# script to run multiple cases of Mathematica on the Richmond teaching cluster from 
# Advanced Clustering. it copies input data to a slave node and copies the results back to the
# master.
#                                          - gpg (1/25/12)
#
# usage: submit.pl NetID
#
#
# check for the username and then set it. **************************************

if ($ARGV[0] eq "") { die "You need to include your NetID as an argument to ./submit.pl.\n";}

$user="$ARGV[0]";

#
# do housekeeping on the master to get rid of old files from previous runs.
#
system("rm /home/$user/compPhys/run/results/*");
system("rm /home/$user/compPhys/run/logs/*");
#
# set the number of parallel jobs to run.
#
$number_of_jobs=20;
#
# loop over each case and submit.
#
for ($i=0; $i < $number_of_jobs; $i++) {

# build the name of log file for this case.
    if ($i < 10) {
	$logfile ="/home/$user/compPhys/run/logs/log0$i";
    }
    if ($i > 9) {
	$logfile ="/home/$user/compPhys/run/logs/log$i";
    }
#
# clean out old files and prepare the new one for this case using sed to do in-line editing.
#
    system("rm /home/$user/compPhys/run/runMath.sh /home/$user/compPhys/run/runMath1.sh");
    system("sed -e 16c\CASE=$i /home/$user/compPhys/run/runMath.sh.template > /home/$user/compPhys/run/runMath1.sh");
    system("sed -e 17c\'USER'=$user /home/$user/compPhys/run/runMath1.sh > /home/$user/compPhys/run/runMath.sh");
#
# submit a job to the remote node and then pause to avoid traffic jams.
#
    print "qsub -l nodes=1:ppn=1 -l walltime=10:00:00  -j oe -o $logfile runMath.sh \n";
    system("qsub -l nodes=1:ppn=1 -l walltime=10:00:00  -j oe -o $logfile runMath.sh \n");
    if ($i < ($number_of_jobs-1)) {
	print "Pause for 1.5 seconds.\n";
	sleep 1.5;
    } 
} # end of loop over number_of_jobs.
