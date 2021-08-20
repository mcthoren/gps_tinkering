#!/bin/sh

# meant to be called from cron every minute or so

LOCK="/home/ghz/alt/gps.lock"

[ -e "${LOCK}" ] && {
	echo "$0: lock exists" | logger
		exit 1
}

# lock is also checked for and deleted on boot, in case of a crash
touch "${LOCK}"

WT_DIR='/import/home/ghz/repos/weather_tools/'
DAT_DIR='/home/ghz/alt/data/'

"${WT_DIR}/grab_48h" "${DAT_DIR}" alt.dat

cd /home/ghz/alt/plots || exit 1
# gnuplot "$WT_DIR/keen.wx.gnuplot"

sync

# /usr/bin/rsync -ur --timeout=50 /home/ghz/wx /import/home/ghz/repos/dust_wx wx0_sync:/wx0/ 2> /dev/null

rm "${LOCK}"
