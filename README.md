# scExplorer
Interface to produce various plots of single cell IHC data analyzed through Brooks Taylor's MACKtrack

# Curent Features
- Load in MACKtrack output from server
- Separate conditions column into sub-conditions (Cell type, Replicate, Compound, Concentration, Time, etc.)

# Initial Feature Goals
- Choose column with conditions from dropdown menu
- Create histograms using conditions to describe color and x and or y facets

# Secondary Feature Goals
- Make bar plots of mean abundances between replicates with standard deviation error bars
- Make bar plots of % differentiated cells
    - Use a histogram of Pparg levels to choose differentiation cutoff level
    - Choose well/experiment conditions to use for choosing the cutoff level
- Make 2D plots based on user selected dimensions
