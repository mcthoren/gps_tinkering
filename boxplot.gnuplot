set term png size 800, 2000 font ",10"

set style fill solid 0.5 border -1
set style boxplot outliers pointtype 1
set style data boxplot
set boxwidth  0.5
set pointsize 0.5
set key outside below

set y2tics
set grid
set mytics 
set grid mytics
set xdata time
set timefmt "%Y%m%d%H%M%S"
set ylabel "Elevation (meters)"
set y2label "Elevation (meters)"
set xtics ("Elevation (m)" 1.0)
set output '/import/home/ghz/projects/gps/plots/total_avg_el_m.png'
plot BOXF using (1):4 t 'Total Average Elevation Measurements (meters)'
