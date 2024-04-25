# MATLAB Code for Core-shell-spherical-DEP-polarization-model
Overview
This MATLAB code repository presents an implementation of the core-shell spherical dielectrophoresis (DEP) polarization model for analyzing the electrical properties of biological cells. The oprimary focus is highlighting the role of the linear scalar (equivalent to the Clausius-Mossotti factor). The code utilizes the fminsearchbnd function in MATLAB for nonlinear fitting, adjusting parameters (ε_mem, σ_cyto, ε_cyto, and the linear scalar) to maximize the R-value and enhance the agreement between the model and experimental data.

Below are instructions for running the Fit_DEP_Spectrum_Multi_for_model:
1. Download files numbered 1 - 5 (descriptive titles below) into a single folder.
2. In MATLAB open the folder containing the five downloaded files.
3. Open the Fit_DEP_Spectrum_Multi_for_model in the MATLAB editor.
4. Run the Fit_DEP_Spectrum_Multi_for_model in the MATLAB editor. When the "Select File to Open" window appears select the Sample data file provided. Note the sample date file must stay in the Microsoft Excel Comma Separated Values File format. You will see the "Optimization Plot Function" window working.

Comments on outputs of the MATLAB Code
Outputs from "Optimization Plot Function" include the DEP spectrum plot discrete data points (open blue circles), the core-shell spherical DEP polarization model fit to the discrete data points (red curve), and the transient slope fit to the discrete data points (green line).

Additionally, the 

Descriptive file names for download in Step 1.

We are including sample data to play around with the code.
