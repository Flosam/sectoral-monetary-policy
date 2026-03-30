# Sectoral Trade-Offs: Monetary Policy and Disaggregated Price Dynamics

An econometric analysis of the Phillips Multiplier and impulse response functions for sectoral PCE price and quantity indices using local projection methods.

## Overview

This project analyzes how monetary policy shocks affect price and quantity dynamics across different sectors of the U.S. economy using disaggregated Personal Consumption Expenditure (PCE) data. The analysis employs:

- **Local Projections** (Jordà, 2005) for impulse response functions
- **Phillips Multiplier** estimation using instrumental variables
- **Anderson-Rubin inference** for weak-instrument robust confidence sets
- **Hierarchical disaggregation** across 7 levels (aggregate → 300+ categories)

## Research Question

How do price and quantity responses to monetary policy shocks vary across different sectors and levels of disaggregation?

## Data Sources

- **PCE Data**: Bureau of Economic Analysis (BEA) Tables 2.4.3u and 2.4.4u
  - Price indices and quantity indices
  - Monthly frequency, 1959-present
  - Hierarchical structure with 7 disaggregation levels

- **Monetary Policy Shocks**:
  - Aruoba & Drechsel (2023) shock series
  - Bauer & Swanson (2023) shock series

- **Control Variables**: Federal Reserve Economic Data (FRED)
  - Federal Funds Rate (FEDFUNDS)
  - Trade-Weighted Dollar Index (FXTWBDI)
  - Industrial Production (INDPRO)
  - Producer Price Index (PPIACO)
  - S&P 500 (SP500)
  - Unemployment Rate (UNRATE)

## Installation & Setup

### Requirements
- MATLAB R2020a or later
- Statistics and Machine Learning Toolbox (for timetables)

### Setup Instructions

1. Clone or download this repository
2. Place raw data files in `Data/Raw/`:
   - `PCE Quantity Index.csv`
   - `PCE Price Index.csv`
   - `Index_Level.xlsx`
   - `Aruoba_Drechsel_Data.xlsx`
   - `Bauer_Swanson_Data.xlsx`
   - FRED data files (FEDFUNDS.csv, etc.)

3. Open MATLAB and navigate to the project directory

## Usage

### Basic Analysis

```matlab
% Run the main analysis script
main

% This will:
% 1. Import and process PCE data
% 2. Import monetary policy shocks
% 3. Run local projection analysis across all levels
% 4. Generate and save figures
```

### Custom Analysis

```matlab
% Load processed data
load('Data/Processed/Price_Index_Data.mat');
load('Data/Processed/Quantity_Index_Data.mat');
load('Data/Processed/MP_Shocks_Measures.mat');

% Run Local Projection for specific level
results = get_lp(price_log_lvl{1}, quant_log_lvl{1}, mps_ad, ...
                 '1982-01-01', '2008-01-01');

% Plot results
plot_lp(results, 'Aggregate PCE', true);

% Run Phillips Multiplier estimation
pm_results = get_pm(price_log_lvl{1}, quant_log_lvl{1}, mps_ad, ...
                    '1982-01-01', '2008-01-01');

% Plot Phillips Multiplier results
plot_irfs(pm_results, 'Aggregate PCE', true);
```

### Configuration

Key parameters can be adjusted in `Codes/config/ProjectConfig.m`:
- `HORIZON`: Number of periods for impulse responses (default: 61 months)
- `NUM_LAGS`: Number of lags in VAR specification (default: 12 months)
- `DEFAULT_START_DATE`: Analysis start date (default: '1982-01-01')
- `DEFAULT_END_DATE`: Analysis end date (default: '2008-01-01')

## Project Structure

```
Sectoral_TradeOffs/
├── README.md
├── .gitignore
├── Codes/
│   ├── main.m                      # Main analysis script
│   ├── run_all.m                   # Run analysis across all levels
│   ├── config/
│   │   └── ProjectConfig.m         # Centralized configuration
│   ├── paths/
│   │   └── initialize_paths.m      # Path setup
│   ├── data_import/
│   │   ├── read_pce_raw.m          # PCE data import
│   │   ├── transform_pce.m         # Log transformations
│   │   └── split_by_level.m        # Hierarchical split
│   ├── core/
│   │   ├── get_lp.m                # Local projection estimation
│   │   ├── get_pm.m                # Phillips Multiplier estimation
│   │   ├── project_out_controls.m  # Frisch-Waugh projection
│   │   ├── compute_confidence_intervals.m  # HAC standard errors
│   │   └── compute_ar_bounds.m     # Anderson-Rubin inference
│   ├── plotting/
│   │   ├── plot_lp.m               # Plot local projections
│   │   ├── plot_irfs.m             # Plot Phillips Multiplier
│   │   ├── shadedErrorBar.m        # Shaded CI plots
│   │   ├── create_irf_subplot.m    # IRF subplot helper
│   │   └── rescale_irf.m           # IRF rescaling
│   └── utils/
│       ├── load_data_safe.m        # Safe data loading
│       ├── ensure_dir.m            # Directory creation
│       └── report_missing.m        # Missing data reporting
├── Data/
│   ├── Raw/                        # Raw data files (not included)
│   ├── Processed/                  # Processed .mat files
│   └── Figures/                    # Generated plots
│       ├── Local_Projections/
│       └── Philips_Multiplier/
└── docs/
    └── REFACTORING_PLAN.md         # Detailed refactoring documentation
```

## Output

The analysis generates:

- **Processed Data**: Saved in `Data/Processed/`
  - `Price_Index_Data.mat`: Log levels and growth rates
  - `Quantity_Index_Data.mat`: Log levels and growth rates
  - `MP_Shocks_Measures.mat`: Monetary policy shocks

- **Figures**: Saved in `Data/Figures/`
  - Local projection IRFs (price and quantity responses)
  - Phillips Multiplier estimates with confidence bounds
  - F-statistics for instrument strength

## Methodology

### Local Projections
For each horizon h, estimates:
```
y_{t+h} = β_h * shock_t + γ' * controls_t + ε_t
```
- Uses Newey-West HAC standard errors
- Controls include lags of dependent variable and MPS

### Phillips Multiplier
Estimates the ratio of price to quantity responses:
```
PM_h = IRF_price(h) / IRF_quantity(h)
```
- Uses 2SLS with monetary policy shocks as instrument
- Computes Anderson-Rubin weak-instrument robust bounds
- Reports effective F-statistics (Montiel Olea-Pflueger)

## References

### Methodology
- Jordà, Ò. (2005). "Estimation and Inference of Impulse Responses by Local Projections." *American Economic Review*, 95(1), 161-182.
- Aruoba, S. B., & Drechsel, T. (2023). "The Long and Variable Lags of Monetary Policy: Evidence from Disaggregated Price Indices." Working paper.
- Montiel Olea, J. L., & Pflueger, C. (2013). "A Robust Test for Weak Instruments." *Journal of Business & Economic Statistics*, 31(3), 358-369.

### Data
- Bureau of Economic Analysis: Personal Consumption Expenditures by Type of Product
- Federal Reserve Economic Data (FRED)
- Geert Mesters replication files: https://www.openicpsr.org/openicpsr/project/114114/version/V1/view

## Author

Florent Samson

## License

This project is for academic research purposes.

## Acknowledgments

- Methodology adapted from Aruoba & Drechsel (2023) and Geert Mesters
- Uses monetary policy shock measures from published sources
- Built with clean, modular architecture following software engineering best practices
