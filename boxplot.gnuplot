set terminal x11 size 600, 800
set style fill solid 0.5 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

set y2tics
set grid
set grid mytics
set mytics 
set xdata time
set timefmt "%Y%m%d%H%M%S"
set ylabel "Elevation (meters)"
set y2label "Elevation (meters)"
set xtics border in scale 0,0 nomirror norotate  autojustify
set xtics  norangelimit 
set xtics   ("Elevation (m)" 1.00000)
plot 'gps_alt.dat.20200116' using (1):4
