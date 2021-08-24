## USB GPS receivers are becoming cheap enough to stick on a raspberry pi and screw with just for fun. So that's what this code is about.

### More specifically, for ham radio antenna reasons, i'm interested in a reasonably accurate measure of my elevation. so for a start i'm going to collect those statistics, plot the long term averages, and see if they tell me anything.

#### This code exists in two versions. Details of v1 folow:
this code uses the gpsd tools, and python client libraries, and started from an example here:
	http://ozzmaker.com/using-python-with-a-gps-receiver-on-a-raspberry-pi/

at the moment, this code collects 1024 points of elevation data with a not terrible vdop, and computes a running average over it. once a minute this running average is written out to disk and graphed. once a day those running averages are averaged into two bar graphs, one with and one w.o. average expected vertical precision.

the following should get one off to a good start depends wise:
	apt-get install python-gps gpsd-clients python-numpy python-matplotlib gnuplot

this code can be found in the following places:
	https://github.com/mcthoren/gps_tinkering	<--code
	https://wx6.slackology.net/gps_el.html		<--page
	https://wx6.slackology.net/			<--code, page, plots, data

a description of the fields returned by gpsd can be found here:
	https://gpsd.gitlab.io/gpsd/gpsd_json.html

```shell
# i've added the following entries to my crontab to further lazify my life:
#minute	hour	mday	month	wday	command
59	23	*	*	*	/import/home/ghz/projects/gps/gen_day_avg
01	00	1	*	*	/import/home/ghz/projects/gps/gen_month_avg
02	00	*	*	*	/import/home/ghz/projects/gps/plot_month_avg
```
##### v1 files:
* alt_hist_gen		<--perl script for generating histograms of alt data for both v1 and v4
* alt_hist.gnuplot	<--gnuplot file for graphing histograms of alt data for both v1 and v4
* boxplot.gnuplot	<--gnuplot file for generating a boxplot and stats for both v1 and v4
* gen_day_avg		<--perl script for generating daily average altitude for v1
* gen_month_avg		<--perl script for generating monthly average altitude for v1
* gps_el.html.plate	<--html template webpage for v1
* gps.gnuplot		<--gnuplot file for generating a running altitude graph for v1
* LICENSE		<--software is apparently not free w.o. a lic
* plot_month_avg	<--shell script for tying much of the v1 code together
* py_gpsd		<--python script for grabing RX data for v1
* README.md		<--markdown file: this doc.

#### Details of what is now about v4 follow here:

##### v4 files:
* alt_hist_gen		<--perl script for generating histograms of alt data for both v1 and v4
* alt_hist.gnuplot	<--gnuplot file for graphing histograms of alt data for both v1 and v4
* boxplot.gnuplot	<--gnuplot file for generating a boxplot and stats for both v1 and v4
* crater.gps.gnuplot	<--gnuplot file for generating a running altitude graph for v4
* crater.gps.go		<--shell cron script for running all the v4 code
* crater.html.plate	<--html template webpage for v4
* py_gps_4		<--python script for grabing RX data for v4
* LICENSE		<--software is apparently not free w.o. a lic
* README.md		<--markdown file: this doc.
