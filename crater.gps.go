#!/bin/sh

# meant to be called from cron every minute or so

LOCK='/home/ghz/alt/gps.lock'
GPS_DIR='/import/home/ghz/repos/gps'
WT_DIR='/import/home/ghz/repos/weather_tools'
DAT_DIR='/home/ghz/alt/data'
DAY_FLAG='/home/ghz/alt/DAY_FLAG'
GPS_STS="${DAT_DIR}/gps_alt_stats"

[ -e "${LOCK}" ] && {
	echo "$0: lock exists" | logger
		exit 1
}

# lock is also checked for and deleted on boot, in case of a crash
touch "${LOCK}"

"${WT_DIR}/grab_48h" "${DAT_DIR}" alt.dat

cd /home/ghz/alt/plots || exit 1
gnuplot "${GPS_DIR}/crater.gps.gnuplot"

# day flag generated from cron
[ -e "${DAY_FLAG}" ] && {
	GPS_ALT_TMP="$(mktemp /tmp/gps_alt.XXXXXXXXXXXXX)"
	cat ${DAT_DIR}/*/alt.dat.* | tee "${GPS_ALT_TMP}" | ${GPS_DIR}/alt_hist_gen > "${DAT_DIR}/gps.alt.historgram"
	gnuplot -e "ALT_HIST='$DAT_DIR/gps.alt.historgram'; OUT_DIR='/home/ghz/alt/plots'" "$GPS_DIR/alt_hist.gnuplot"
	gnuplot -e "BOX_F='$GPS_ALT_TMP'; OUT_DIR='/home/ghz/alt/plots'" "$GPS_DIR/boxplot.gnuplot" 2> "${GPS_STS}"
	rm "${DAY_FLAG}" "${GPS_ALT_TMP}"
}

sync

/usr/bin/rsync -ur --timeout=50 /home/ghz/alt/ "${GPS_DIR}/crater.gps.gnuplot" \
	"${GPS_DIR}/crater.gps.go" "${GPS_DIR}/alt_hist_gen" "${GPS_DIR}/py_gps_4" "${GPS_DIR}/README" \
	"${GPS_DIR}/alt_hist.gnuplot" "${GPS_DIR}/crater.html" "${GPS_DIR}/LICENSE" \
	wx9_sync:/wx9/ # 2> /dev/null

rm "${LOCK}"
