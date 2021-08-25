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
	gnuplot -e "BOXF='$GPS_ALT_TMP'; OUT_DIR='/home/ghz/alt/plots'; COL=2;" "$GPS_DIR/boxplot.gnuplot" 2> "${GPS_STS}"

	REC="$(grep 'Records:' $GPS_STS | awk '{print $2}')"
	MEAN="$(grep 'Mean:' $GPS_STS | awk '{printf("%.2f\n",$2)}')"
	MED="$(grep 'Median:' $GPS_STS | awk '{printf("%.2f\n",$2)}')"
	TS="$(date -u "+%F %T%Z")"

	sed "s/AAAAA/${REC}/; s/MMMMM/${MEAN}/; s/DDDDD/${MED}/; s/TTTTT/${TS}/" "${GPS_DIR}/crater.html.plate" > "${GPS_DIR}/crater.html"

	rm "${DAY_FLAG}" "${GPS_ALT_TMP}"
}

sync

/usr/bin/rsync -ur --timeout=50 /home/ghz/alt/ "${GPS_DIR}/crater.gps.gnuplot" \
	"${GPS_DIR}/crater.gps.go" "${GPS_DIR}/alt_hist_gen" "${GPS_DIR}/py_gps_4" "${GPS_DIR}/README.md" \
	"${GPS_DIR}/alt_hist.gnuplot" "${GPS_DIR}/crater.html" "${GPS_DIR}/LICENSE" \
	wx9_sync:/wx9/ # 2> /dev/null

rm "${LOCK}"
