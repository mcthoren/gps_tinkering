set y2tics
set key outside below
set grid
set ylabel "Frequency (count)"
set y2label "Frequency (count)"
set term png size 2000, 512 font ",10"
set xtics auto
set mxtics 
set grid mxtics

set title "Elevation Frequency Histogram for All Measurements"
set output '/import/home/ghz/projects/gps/plots/el_hist.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set output '/import/home/ghz/projects/gps/plots/el_hist.450-600.png'
plot AH_456 using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set output '/import/home/ghz/projects/gps/plots/el_hist.500-550.png'
plot AH_550 using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set output '/import/home/ghz/projects/gps/plots/el_hist.520-530.png'
plot AH_523 using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"
