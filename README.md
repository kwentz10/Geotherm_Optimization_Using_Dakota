# Geotherm_Optimization_Using_Dakota

To run the dakota input file navigate to the directory where you downloaded and unzipped teh files onto your computer and type:

dakota -i dakota_matlab_geotherm.in 

into the terminal/command prompt

I used an example to do this optimization in matlab rather than python (because I did not know how to convert's Greg's example to matlab). I navigated to DAKOTA/examples/script_interfaces/Matlab and created my scripts using the rosenbrock examples given. However, it is giving me errors in the "dakota_matlab_geotherm.in" line 12: " tabular_data_file='capte_thompson.dat' ". I do not know how to properly input the observed borehole data into the dakota engine. How does dakota know that my input data is the temperature data with depth? I tried to add a template file, but that seems to coordinate with my estimated parameters rather than my observed data. I am very confused. If you have any insight that would be great!


