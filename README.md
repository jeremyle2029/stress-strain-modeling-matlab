# stress-strain-modeling-matlab
## Project Overview
An automated material engineering analysis tool built in MATLAB to process raw experimental tensile testing data, calculate fundamental mechanical properties, and mathematically model material deformation zones.

## Key Features
- **Piecewise Regression Modeling:** Configured a continuous multi-region fit combining linear, power-law, and exponential curves to map elastic and plastic deformation boundaries.
- **Yield Strength Isolation:** Compiled a 0.2% offset numerical solver algorithm to precisely isolate the material yield point and ultimate tensile strength.
- **Automated Data Processing:** Converts raw force and displacement vectors into true stress and strain matrix values with built-in data validation.

## File Structure
- `main_analysis.m` - The primary execution script that handles the data import, offsets, and numerical solving loops.
- `piecewise_fit.m` - Contains the custom regression algorithms for the shifting deformation regions.
