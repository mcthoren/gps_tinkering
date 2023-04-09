set title "GPS Data over the Last \\~48 Hours"
set xtics 7200 rotate by 30 offset -5.7, -2.2
set ytics
set mytics
set y2tics
set link y2
set key outside below
set xlabel "Time (UTC)" offset 0.0, -1.6
set xdata time;
set format x "%F\n%TZ"
set timefmt "%Y%m%d%H%M%S"
set grid xtics
set grid y2tics
set term pngcairo size 2000, 512 font ",10"

set format y "%.0f"
set format y2 "%.0f"

dat_f='/import/home/ghz/repos/gps/data/gps_alt.dat.2-3_day'
out_d='/import/home/ghz/repos/gps/plots/'

set ylabel "Altitude (m)"
set y2label "Altitude (m)"
set output out_d.'avg_alt.png'
plot dat_f using 1:4 title 'Altitude' with lines lw 2 linecolor rgb "#0000ff"
