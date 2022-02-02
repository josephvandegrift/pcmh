
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
 
The package is now installed and ready to use/update. This should theoretically work the same way when the R server is up and running.

## PCMH QA

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

##
