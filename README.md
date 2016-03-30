# Geotherm_Optimization_Using_Dakota
I use Dakota to find a change in temperature over my modeled set time period to minimize the difference between observed and modeled temperature data with depth

I used a different example to do this optimization in matlab rather than python. However, it is giving me errors in the "dakota_matlab_geotherm.in" line 12:
" tabular_data_file='capte_thompson.dat' ". I do not know how to properly input the observed borehole data into the dakota engine. How does dakota know that 
my input data is the temperature data with depth? I tried to add a template file, but that seems to coordinate with my estimated parameters rather than
my observed data. I am very confused. If you have any insight that would be great!
