#### USB GPS receivers are becoming cheap enough to stick on a raspberry pi and screw with just for fun. So that's what this code is about.

More specifically, for ham radio antenna reasons, I'm interested in a reasonably accurate measure of my elevation. So for a start I'm going to collect those statistics, plot the long term averages, and see if they tell me anything. v1 and v4 use different receivers, different libraries, different code, and different methods of collecting what should be the same data. The v1 RX is a GPS only RX, and the v4 RX receives GPS and GLONASS data. Both receivers are within ~20cm of each other vertically. In theory, after a million points or so, if the data is normal, we would expect to see means that are somewhat near each other.

#### This code exists in two versions. Details of v1 follow:
This code uses the gpsd tools, and python client libraries, and started from an example here:
* http://ozzmaker.com/using-python-with-a-gps-receiver-on-a-raspberry-pi/

At the moment, this code collects 1024 points of elevation data with a not terrible VDOP, and computes a running average over it. Once a minute this running average is written out to disk and graphed. Once a day those running averages are averaged into two bar graphs, one with and one w.o. average expected vertical precision.

* The following should get one off to a good start depends wise:
  * apt-get install python-gps gpsd-clients python-numpy python-matplotlib gnuplot

* This code can be found in the following places:
  * https://github.com/mcthoren/gps_tinkering	<--code
  * https://wx6.slackology.net/gps_el.html	<--page
  * https://wx6.slackology.net/			<--code, page, plots, data

* A description of the fields returned by gpsd can be found here:
  * https://gpsd.gitlab.io/gpsd/gpsd_json.html

##### v1 files:
* alt_hist_gen		<--perl script for generating histograms of alt data for both v1 and v4
* alt_hist.gnuplot	<--gnuplot file for graphing histograms of alt data for both v1 and v4
* boxplot.gnuplot	<--gnuplot file for generating a boxplot and stats for both v1 and v4
* gen_day_avg		<--perl script for generating daily average altitude for v1
* gen_month_avg		<--perl script for generating monthly average altitude for v1
* gps_el.html.plate	<--html template web page for v1
* gps.gnuplot		<--gnuplot file for generating a running altitude graph for v1
* LICENSE		<--software is apparently not free w.o. a lic
* plot_month_avg	<--shell script for tying much of the v1 code together
* py_gpsd		<--python script for grabbing RX data for v1
* README.md		<--markdown file: this doc.

```shell
# i've added the following entries to my crontab to further lazify my life:
#minute	hour	mday	month	wday	command
59	23	*	*	*	/import/home/ghz/projects/gps/gen_day_avg
01	00	1	*	*	/import/home/ghz/projects/gps/gen_month_avg
02	00	*	*	*	/import/home/ghz/projects/gps/plot_month_avg
```

#### Details of what is now about v4 follow here:

This version is based around the GPS PA1010D Module and code from Adafruit. It does a lot less averaging than v1, runs at 10Hz, and only averages 60 samples of not terrible [PHV]OP data per output line. It is meant to be simpler, more portable, and easier to use.

* To install the prerequisites one needs sth like the following:
  * apt install python3-pip
  * pip3 install adafruit-circuitpython-gps

##### Many thanks to Adafruit for all the wonderful docs, boards, and examples.
* Docs can be found here:
  * https://learn.adafruit.com/adafruit-mini-gps-pa1010d-module?view=all
  * https://cdn-learn.adafruit.com/assets/assets/000/084/295/original/CD_PA1010D_Datasheet_v.03.pdf?1573833002

* This code can be found in the following places:
  * https://github.com/mcthoren/gps_tinkering	<--code
  * https://wx9.slackology.net/crater.html	<--page
  * https://wx9.slackology.net/			<--code, page, plots, data

##### v4 files:
* alt_hist_gen		<--perl script for generating histograms of alt data for both v1 and v4
* alt_hist.gnuplot	<--gnuplot file for graphing histograms of alt data for both v1 and v4
* boxplot.gnuplot	<--gnuplot file for generating a boxplot and stats for both v1 and v4
* crater.gps.gnuplot	<--gnuplot file for generating a running altitude graph for v4
* crater.gps.go		<--shell cron script for running all the v4 code
* crater.html.plate	<--html template web page for v4
* py_gps_4		<--python script for grabbing RX data for v4
* LICENSE		<--software is apparently not free w.o. a lic
* README.md		<--markdown file: this doc.

```shell
# i've added the following entries to my crontab to further lazify my life:
DAY_FLAG=/home/ghz/alt/DAY_FLAG
#
#minute hour    mday    month   wday    command
*       *       *       *       *       /import/home/ghz/repos/gps/crater.gps.go
00      00      *       *       *       touch "${DAY_FLAG}"
```
