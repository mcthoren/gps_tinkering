set title "GPS Data over the Last \\~48 Hours"
set xtics 7200 rotate by 30 offset -5.7, -2.2
set ytics
set mytics
set y2tics
set key outside below
set xlabel "Time (UTC)" offset 0.0, -1.6
set xdata time;
set format x "%F\n%TZ"
set timefmt "%Y-%m-%dT%H:%M:%SZ"
set grid xtics
set grid y2tics
set term pngcairo size 2000, 512 font ",10"

set format y "%.0f"
set format y2 "%.0f"

dat_f='/home/ghz/alt/data/alt.dat.2-3_day'
out_d='/home/ghz/alt/plots/'

set ylabel "Altitude (m)"
set y2label "Altitude (m)"
set output out_d.'alt_m.png'
plot dat_f using 1:2 title 'Altitude' with lines lw 2 linecolor rgb "#0000ff"

set format y "%.1f"
set format y2 "%.1f"
set ylabel "Dilution of Prescission"
set y2label "Dilution of Prescission"
set output out_d.'dops.png'
plot dat_f using 1:4 title 'VDOP' with lines lw 1 linecolor rgb "#00dd00", \
dat_f using 1:6 title 'HDOP' with lines lw 1 linecolor rgb "#dd0000", \
dat_f using 1:8 title 'PDOP' with lines lw 1 linecolor rgb "#0000dd"

set ylabel "Avg Satellites locked (count)"
set y2label "Avg Satellites locked (count)"
set output out_d.'sats.png'
plot dat_f using 1:10 title 'Avg Sats Locked.' with lines lw 1 linecolor rgb "#9900ff"
