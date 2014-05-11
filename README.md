std-Classical-Tempered-Stable-Distribution
==========================================

Stable distributions have become increasingly popular over the years (especially in the field of Finance) for their robustness and flexibility. For example, they describe asset returns much better than traditional distributions, such as the Normal Distribution. Specifically, Stable Distributions can capture the "fat-tailedness" and "skewness" of returns, allowing practitioners to better estimate risk and model expected behavior. 

This application estimates a Standard Classical Tempered Stable Distribution (stdCTS) given a standardized data set. Since a closed form expression is not available for a stdCTS, we instead utilize the stdCTS Characteristic Function (CF), and fit it to an Empirical Characteristic Function (ECF); this method is know as "fitting the ECF." The program was created for demonstration purposes; as a result it generates several graphics and takes synthetic data as input. These parts can easily be modified for application purposes. 

The program is composed of four Matlab files:

1) main.m
2) stdCTS_CF.m
3) meanSqrDiff.m
4) stdCTS_pdf.m

All four files are needed to run the estimation procedures. The main.m file is the primary control file (runs the optimizer, takes input, generates graphics, etc...). The stdCTS_CF.m file holds the stdCTS Characteristic Function. meanSqrDiff.m finds the mean squared error between the CF and ECF given a data and parameter vector. The last file stdCTS_pdf.m converts the fitted CF into a PDF using the discrete inverse Fourier Transform. It applies the Mid-Point Integral Approximation procedure described by Menn and Rachev [1], supplemented with insights provided by Stoyanov and Racheva-Iotova [2].

[1] Christian Menn and Svetlozar T. Rachev. Calibrated FFT-based density approximations for alpha-stable distributions.         Computational Statistics and Data Analysis, 2006.

[2] S. Stoyanov and B. Racheva-Iotova. Univariate stable laws in the field of finance - approximations of density and           distribution functions. Journal of Concrete and Applicable Mathematics, 2005.

Thank you!
