# ihcExplorer
Interface to produce various plots of single cell IHC data analyzed through Brooks Taylor's MACKtrack

# Initial Feature Goals
- Load in MACKtrack output from server
- Choose column with conditions from dropdown menu
- Separate conditions column into sub-conditions (Cell type, Replicate, Compound, Concentration, Time, etc.)
- Create histograms using conditions to describe color and x and or y facets

# Secondary Feature Goals
- Make bar plots of mean abundances between replicates with standard deviation error bars
- Make bar plots of % differentiated cells
    - Use a histogram of Pparg levels to choose differentiation cutoff level
    - Choose well/experiment conditions to use for choosing the cutoff level
- Make 2D plots based on user selected dimensions
