set y2tics
set mytics
set key outside below
set grid
set ylabel "Frequency (count)"
set y2label "Frequency (count)"
set term png size 2000, 512 font ",10"
set xtics auto
set mxtics 
set grid mxtics

set title "Elevation Frequency Histogram for All Measurements > 300m < 700m"
set output OUT_DIR.'/el_hist.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set xrange ["450":"600"]
set title "Elevation Frequency Histogram for All Measurements ≥ 450m < 600m"
set output OUT_DIR.'/el_hist.450-600.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set xrange ["500":"550"]
set title "Elevation Frequency Histogram for All Measurements ≥ 500m < 550m"
set output OUT_DIR.'/el_hist.500-550.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set xrange ["510":"530"]
set title "Elevation Frequency Histogram for All Measurements ≥ 510m < 530m"
set output OUT_DIR.'/el_hist.510-530.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"

set xrange ["490":"510"]
set title "Elevation Frequency Histogram for All Measurements ≥ 490m < 510m"
set output OUT_DIR.'/el_hist.490-510.png'
plot ALT_HIST using 1:3 t 'Elevation (meters)' with boxes linecolor rgb "#ff0000"
