# stress-strain-modeling-matlab
## Project Overview
An automated material engineering analysis tool built in MATLAB to process raw experimental tensile testing data, calculate fundamental mechanical properties, and mathematically model material deformation zones.

## Key Features
- **Piecewise Regression Modeling:** Configured a continuous multi-region fit combining linear, power-law, and exponential curves to map elastic and plastic deformation boundaries.
- **Yield Strength Isolation:** Compiled a 0.2% offset numerical solver algorithm to precisely isolate the material yield point and ultimate tensile strength.
- **Automated Data Processing:** Converts raw force and displacement vectors into true stress and strain matrix values with built-in data validation.

## File Structure
- `Ma7.m` - The primary execution script that imports experimental data, executes the 0.2% offset solver, and runs the piecewise regression modeling loops.
- `Force.csv` - Raw experimental data file containing the measured force vectors from the tensile test.
- `Elongation.csv` - Raw experimental data file containing the corresponding displacement and extension vectors.
