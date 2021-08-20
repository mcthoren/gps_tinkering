#!/bin/sh

# meant to be called from cron every minute or so

LOCK="/home/ghz/alt/gps.lock"

[ -e "${LOCK}" ] && {
	echo "$0: lock exists" | logger
		exit 1
}

# lock is also checked for and deleted on boot, in case of a crash
touch "${LOCK}"

GPS_DIR='/import/home/ghz/repos/gps'
WT_DIR='/import/home/ghz/repos/weather_tools'
DAT_DIR='/home/ghz/alt/data'

"${WT_DIR}/grab_48h" "${DAT_DIR}" alt.dat

# this could be done once a day
cat ${DAT_DIR}/*/alt.dat.* | ${GPS_DIR}/alt_hist_gen > "${DAT_DIR}/gps.alt.historgram"
gnuplot -e "ALT_HIST='$DAT_DIR/gps.alt.historgram'; OUT_DIR='/home/ghz/alt/plots'" "$GPS_DIR/alt_hist.gnuplot"

cd /home/ghz/alt/plots || exit 1
gnuplot "${GPS_DIR}/crater.gps.gnuplot"

sync

/usr/bin/rsync -ur --timeout=50 /home/ghz/alt/ /import/home/ghz/repos/gps/crater.gps.gnuplot \
	/import/home/ghz/repos/gps/crater.gps.go /import/home/ghz/repos/gps/alt_hist_gen \
	/import/home/ghz/repos/gps/py_gps_4 /import/home/ghz/repos/gps/README \
	wx9_sync:/wx9/ # 2> /dev/null

rm "${LOCK}"
