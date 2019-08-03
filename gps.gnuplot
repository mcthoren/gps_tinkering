set xtics
set y2tics
set key outside below
set xlabel "Date (UTC)"
set xdata time
set timefmt "%Y%m%d"
set grid
set ylabel "m"
set y2label "m"
set term png size 2000, 512 font ",10"
set grid nomxtics
set xtics 172800
set mxtics 2
set title "Daily Averages of Running Height Averages"
# set xlabel "Daily Average Elevation Measurement" offset 0.0, -1.0
set format x "%F"
set output '/import/home/ghz/projects/gps/plots/avg_el_m.png'
plot ALTF using 1:2 t 'Average Elevation Reading (m)' with boxes linecolor rgb "#ff0000"
set output '/import/home/ghz/projects/gps/plots/avg_el_m_yerr.png'
plot ALTF using 1:2 t 'Average Elevation Reading (m)' with boxes linecolor rgb "#ff0000",\
ALTF u 1:2:4 t "epv" w yerr linecolor rgb "#6000ff"
