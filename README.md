# MATLAB Code for Core-shell-spherical-DEP-polarization-model
# Overview
This MATLAB code repository presents an implementation of the core-shell spherical dielectrophoresis (DEP) polarization model for analyzing the electrical properties of biological cells. The primary focus is highlighting the role of the linear scalar (equivalent to the Clausius-Mossotti factor). The code utilizes the fminsearchbnd function in MATLAB for nonlinear fitting, adjusting parameters (ε_mem, σ_cyto, ε_cyto, and the linear scalar) to maximize the R-value and enhance the agreement between the model and experimental data.

# Instructions for Running Fit_DEP_Spectrum_Multi_for_model:
1. Download the following files (five total) into a single folder.

   depf.m

   Core_Shell_DEP_Polarization_Model.m

   fminsearchbnd.m

   residual.m

   3DEP Sample Data_BM hMSCs.csv (see a few more details below)

3. In MATLAB, open the folder containing the five downloaded files.
4. Open the Fit_DEP_Spectrum_Multi_for_model in the MATLAB editor.
5. Run the Fit_DEP_Spectrum_Multi_for_model in the MATLAB editor. When the "Select File to Open" window appears, select the Sample data file provided. Note: The sample date file must stay in the Microsoft Excel Comma Separated Values File format. You will see the "Optimization Plot Function" window working.

# Comments on Outputs of the MATLAB Code
Outputs from "Optimization Plot Function" include the DEP spectrum plot discrete data points (open blue circles), the core-shell spherical DEP polarization model fit to the discrete data points (red curve), and the transient slope fit to the discrete data points (green line).

Additionally, the "Command Window" contains tables of data, which tabulated defined parameters, fitting parameters, converged values, and calculated values. The defined parameters are constants such as permittivity of the vacuum, permittivity of the medium, cell radius, and membrane thickness. For permittivity of the vacuum and permittivity of the medium two values are reported,the second of which is divided by the permittivity of the vacuum (8.85x10^-12 F/m); the respective units appear in brackets. Two values are also reported for medium conductivity, cell radius, and membrane thicknes for readability and the respective units appear in brackets. The fitted parameters are the permittivity of the cytoplasm, permittivity of the membrane, conductivity of the cytoplasm, conductivity of the membrane, and the linear scalar. Two values are reported for permittivity of the cytoplasm and permittivity of the membrane, the second value in the table represents the first value divided by the permittivity of the vacuum (8.85x10^-12 F/m); the respective units appear in brackets. The experimental data collected with the 3DEP analyzer (i.e., light intensity values vs frequency) is divided by the linear scalar. The converged values are those reported in the manuscript figures, which include permittivity of the cytoplasm, permittivity of the membrane, conductivity of the cytoplasm, conductivity of the membrane, and an R^2. Two values are reported for permittivity of the cytoplasm and permittivity of the membrane, the second value in the table represents the first value divided by the permittivity of the vacuum (8.85x10^-12 F/m); the respective units appear in brackets. Lastly, the calculated values include the crossover frequency, membrane capacitance estimated with the crossover frequency, membrane capacitance estimated with permittivity, and the transient slope estimated from linear trendline. The values reported in the manuscript are the membrane capacitance estimated with permittivity and the transient slope. If you decide to run Fit_DEP_Spectrum_Multi_for_model on your own data make sure to update the cell radius.

# Formatting Details for the 3DEP Sample Data_BM hMSCs.csv File
This file is 3DEP analyzer experimental data for bone marrow (BM) derived human mesenchymal stem cells (hMSCs). The following are details on how the data set is organized on the .csv file. Do not alter the format.

A1	Average cell radius (mm)			

A2	Conductivity of DEP buffer solution (mS/cm)			

A3	placeholder			

A4	placeholder			

A5 to A24	Frequency (Hz)			

B5 to B24	Light Intensity (a.u., output from 3DEP analyzer)
