
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PCMH

<!-- badges: start -->
<!-- badges: end -->

The goal of pcmh is to automate the PCMH Report QA.

## Initial Setup

If this is your first time setting up the package:
 1. Pull repository to desired location.
 2. Open the pcmh.Rproj file.
 3. In RStudio at the top, click on Build > Install and Restart (Ctrl + Shift + B).
 
You should follow this same process before running the QA process, in case there have been any updates made to the package.

This should theoretically work the same way when the R server is up and running.

## PCMH QA

The package is now installed and ready to use/update. 

Once the package is installed, you only need to call one function to complete the QA process:

```{r pcmh_qa}
## Load package, if necessary.
library(pcmh)

pcmh_qa(.pcmh_report_dir,
   .metric_data_dir,
   .metric_data_regexp,
   .report_type,
   .out_path = NA)
```

You can refer to the function documentation for pcmh_qa on what each input is expecting.

For troubleshooting, you may run each part of the pcmh_qa function individually to identify any problems.

## Edit/Updating Package

If you need to edit a function:

 1. Open the .R file in RStudio (pcmh_qa.R, for instance).
 2. Edit the function and documentation.
 3. Save the .R file.
 4. Install and Restart (Ctrl + Shift + B).
 5. Test the package (Ctrl + Shift + T).
 6. Push the changes to Bitbucket.
 
If you need to add a new function:

 1. Open a new R Script file (Ctrl + Shift + N, in RStudio).
 2. Write the function and documentation (You can copy and existing function to see the documentation syntax).
 3. Save the R Script as function_name.R in the R subdirectory.
 4. Install and Restart (Ctrl + Shift + B).
 5. Test the package (Ctrl + Shift + T).
 6. Push the changes to Birbucket.
 
There will be a couple warnings when you Test the package. These are known and expected. If you see any other warnings or errors, it is recommended to fix those and re-test the package before pushing to Bitbucket.
