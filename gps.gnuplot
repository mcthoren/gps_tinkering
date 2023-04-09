set y2tics
set link y2
set mytics
set key outside below
set xlabel "Date (UTC)"
set xdata time
set timefmt "%Y%m%d"
set grid
set ylabel "Elevation (meters)"
set y2label "Elevation (meters)"
set term png size 2000, 512 font ",10"
set grid nomxtics
set xtics auto
set mxtics 2
# set xrange ["20190728":]

set format x "%F"
set title "Daily Averages of Running Averages of GPS Elevation Measurments"
set output '/import/home/ghz/projects/gps/plots/avg_el_m.png'
plot ALTF using 1:2 t 'Average Elevation Measurements (meters)' with boxes linecolor rgb "#ff0000"
set output '/import/home/ghz/projects/gps/plots/avg_el_m_yerr.png'
plot ALTF using 1:2 t 'Average Elevation Measurements (meters)' with boxes linecolor rgb "#ff0000",\
ALTF u 1:2:4 t "Averaged Vertical Position Error (as Reported by Receiver) (meters)" w yerr linecolor rgb "#6000ff"

set timefmt "%Y%m"
# set xrange ["201907":]
set title "Monthly Averages of Daily Averages of Running Averages of GPS Elevation Measurments"
set output '/import/home/ghz/projects/gps/plots/avg_m_el_m.png'
plot ALTF_MA using 1:2 t 'Average Elevation Measurements (meters)' with boxes linecolor rgb "#ff0000"
set output '/import/home/ghz/projects/gps/plots/avg_m_el_m_yerr.png'
plot ALTF_MA using 1:2 t 'Average Elevation Measurements (meters)' with boxes linecolor rgb "#ff0000",\
ALTF_MA u 1:2:4 t "Averaged Vertical Position Error (as Reported by Receiver) (meters)" w yerr linecolor rgb "#6000ff"
