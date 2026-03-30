# Sectoral Trade-Offs Project: Deep Refactoring Plan

## Project Overview
This is an econometric analysis project studying the Phillips Multiplier and Local Projections for sectoral price/quantity responses to monetary policy shocks. The codebase is MATLAB-based with ~20 files analyzing BEA PCE data across 7 hierarchical disaggregation levels.

**Goal**: Refactor for GitHub presentation with clean architecture, error handling, and professional documentation while preserving all analytical results.

**Scope**: Deep refactoring (redesign architecture, add tests, modernize approach) while keeping MATLAB-only implementation.

---

## Current State Assessment

### Strengths
- Well-structured top-level workflow (main.m → run_all.m → analysis functions)
- Clear separation of data import, analysis, and visualization
- Results-oriented with saved figures and processed data

### Critical Issues Identified
1. **Code Duplication** (HIGH): ~60% overlap between get_lp.m and get_pm.m
2. **Hard-coded Magic Numbers** (MEDIUM): Horizons, lags, file paths scattered throughout
3. **Poor Naming** (MEDIUM): Cryptic variables (vMPS, mMx, iTc)
4. **Missing Documentation** (HIGH): No function headers, README, or error handling
5. **Monolithic Functions** (HIGH): Functions doing 5+ distinct tasks
6. **Numerical Instability** (MEDIUM): Using inv() instead of backslash operator

---

## Implementation Plan

### Phase 1: Foundation & Configuration
**Goal**: Create infrastructure for maintainable code

#### Todo: setup-config
- Create `config/ProjectConfig.m` class with all parameters:
  - Horizon settings (iH = 61)
  - Lag specifications (numLags = 12)
  - Confidence levels (alpha = 0.05, z_critical = 1.96)
  - File paths (raw data, processed data, figures)
  - AR test grid parameters
- Add `validate()` method to check directory existence
- Update all files to use config instead of hard-coded values
- **Dependency**: None
- **Deliverable**: config/ProjectConfig.m

#### Todo: setup-utilities
- Create `utils/` directory for shared functions
- Extract common functions:
  - `utils/load_data_safe.m`: Validates file existence before loading
  - `utils/validate_inputs.m`: Check dimensions, date ranges, NaN handling
  - `utils/report_missing.m`: Log data cleaning statistics
  - `utils/ensure_dir.m`: Create directory if it doesn't exist
- **Dependency**: None
- **Deliverable**: 4 utility functions

#### Todo: fix-paths
- Create `paths/initialize_paths.m` to set up MATLAB path
- Add path validation and auto-creation for Data/Raw, Data/Processed, Data/Figures
- Update main.m to call initialize_paths() first
- **Dependency**: setup-utilities (uses ensure_dir)
- **Deliverable**: paths/initialize_paths.m

---

### Phase 2: Refactor Core Analysis
**Goal**: Eliminate duplication and improve modularity

#### Todo: extract-control-projection
- Create `core/project_out_controls.m`:
  - Input: mObs (data matrix), mControls
  - Output: Projected data matrix
  - Implements Frisch-Waugh theorem (M_x = I - X(X'X)^{-1}X')
  - Replace inv() with backslash operator for numerical stability
- Update get_lp.m and get_pm.m to use this function
- **Dependency**: setup-utilities
- **Deliverable**: core/project_out_controls.m

#### Todo: extract-confidence-intervals
- Create `core/compute_confidence_intervals.m`:
  - Input: beta, standard errors, confidence level
  - Output: [lower, upper] bounds
  - Uses Newey-West for HAC covariance
- Consolidates duplicated CI logic from get_lp.m and get_pm.m
- **Dependency**: NeweyWest.m (keep as-is)
- **Deliverable**: core/compute_confidence_intervals.m

#### Todo: refactor-get-lp
- Refactor `get_lp.m`:
  - Split calc_lp() inner function into separate file: `core/calc_local_projection.m`
  - Use extracted functions: project_out_controls, compute_confidence_intervals
  - Add comprehensive input validation
  - Add function header documentation (inputs, outputs, methodology)
  - Replace hard-coded values with config
- **Dependency**: extract-control-projection, extract-confidence-intervals, setup-config
- **Deliverable**: Refactored Codes/get_lp.m, new core/calc_local_projection.m

#### Todo: refactor-get-pm
- Refactor `get_pm.m`:
  - Split calc_pm() inner function into: `core/calc_phillips_multiplier.m`
  - Extract AR testing logic into: `core/compute_ar_bounds.m`
  - Use shared functions from Phase 2
  - Add function header documentation
  - Fix inconsistency: call import_controls or document why it's not needed
- **Dependency**: extract-control-projection, extract-confidence-intervals, setup-config
- **Deliverable**: Refactored Codes/get_pm.m, new core/calc_phillips_multiplier.m, core/compute_ar_bounds.m

---

### Phase 3: Refactor Data Import
**Goal**: Modularize data loading and transformation

#### Todo: refactor-import-pce
- Split `import_pce_data.m` into:
  - `data_import/read_pce_raw.m`: File I/O only
  - `data_import/transform_pce.m`: Log and growth rate calculation
  - `data_import/split_by_level.m`: Hierarchical disaggregation
  - Keep `import_pce_data.m` as orchestrator calling these 3
- Auto-detect data dimensions (remove hard-coded row count)
- Add validation for date parsing and column names
- **Dependency**: setup-utilities, setup-config
- **Deliverable**: 3 new functions, refactored import_pce_data.m

#### Todo: refactor-import-mps
- Refactor `import_mps_data.m`:
  - Add error handling for missing Excel files
  - Validate date range alignment with PCE data
  - Add function documentation
- **Dependency**: setup-utilities
- **Deliverable**: Refactored import_mps_data.m

#### Todo: refactor-import-controls
- Refactor `import_controls.m`:
  - Move file paths to ProjectConfig
  - Add validation for each control variable
  - Report missing data statistics
  - Add function documentation
- **Dependency**: setup-config, setup-utilities
- **Deliverable**: Refactored import_controls.m

---

### Phase 4: Refactor Visualization
**Goal**: Clean up plotting code and improve consistency

#### Todo: consolidate-shaded-error
- Decide on single implementation: shadedErrorBar.m or shadedErrorBar_RB.m
- If using modified version (RB), document changes vs original
- Remove unused version
- **Dependency**: None
- **Deliverable**: Single shadedErrorBar implementation with documentation

#### Todo: refactor-plot-lp
- Refactor `plot_lp.m`:
  - Extract subplot creation into helper: `plotting/create_irf_subplot.m`
  - Remove hard-coded figure sizes and positions
  - Add configuration for plot styling (line width, colors, fonts)
  - Add function documentation
- **Dependency**: consolidate-shaded-error, setup-config
- **Deliverable**: Refactored plot_lp.m, new plotting/create_irf_subplot.m

#### Todo: refactor-plot-irfs
- Refactor `plot_irfs.m`:
  - Remove 50+ lines of commented-out code (lines 113-165)
  - Extract rescaling logic into: `plotting/rescale_irf.m`
  - Extract subplot creation into modular functions
  - Use consistent styling with plot_lp.m
  - Add function documentation
- **Dependency**: consolidate-shaded-error, setup-config
- **Deliverable**: Refactored plot_irfs.m, new plotting/rescale_irf.m

---

### Phase 5: Improve Naming & Documentation
**Goal**: Make code self-documenting and professional

#### Todo: rename-variables
- Create variable naming guide in docs/
- Systematically rename cryptic variables across all files:
  - vMPS → monetaryPolicyShock
  - mMx → projectionMatrix
  - iTc → numObservations
  - mXc → controlsMatrix
  - vBeta → irfCoefficients
- Use consistent Hungarian notation: m=matrix, v=vector, i=integer, b=boolean, s=string
- **Dependency**: All Phase 2-4 refactoring (minimize rework)
- **Deliverable**: Updated all .m files with clear variable names

#### Todo: add-function-headers
- Add comprehensive headers to all functions:
  - Purpose description
  - Input parameters (type, dimensions, units)
  - Output parameters
  - Example usage
  - References to methodology (where applicable)
- Use consistent format across all files
- **Dependency**: rename-variables
- **Deliverable**: All .m files have documentation headers

#### Todo: add-inline-comments
- Add strategic inline comments:
  - Complex algorithm steps (e.g., Frisch-Waugh projection)
  - Non-obvious parameter choices
  - Mathematical operations referencing equations
- Keep comments concise (avoid over-commenting)
- **Dependency**: rename-variables
- **Deliverable**: Well-commented codebase

---

### Phase 6: Error Handling & Robustness
**Goal**: Prevent silent failures and improve debugging

#### Todo: add-input-validation
- Add validation to all public functions:
  - Check matrix dimensions match expected
  - Validate date ranges are aligned
  - Check for empty/NaN inputs
  - Ensure positive integers for horizons/lags
- Use MATLAB's validateattributes() or custom validators
- **Dependency**: All core refactoring
- **Deliverable**: Validated inputs in all major functions

#### Todo: add-error-reporting
- Implement informative error messages:
  - File not found → show expected path
  - Dimension mismatch → show actual vs expected
  - Missing data → report percentage removed
- Replace generic errors with specific error IDs
- **Dependency**: add-input-validation
- **Deliverable**: Clear error messages throughout

#### Todo: add-logging
- Create `utils/log_message.m` for optional verbose output:
  - Data loading progress
  - Rows removed due to missing data
  - Analysis phase completion
- Add verbosity flag to main.m and run_all.m
- **Dependency**: setup-utilities
- **Deliverable**: Logging infrastructure

---

### Phase 7: Testing & Validation
**Goal**: Ensure refactored code produces identical results

#### Todo: create-test-data
- Create `tests/` directory
- Generate small synthetic test dataset:
  - 24 months of fake PCE price/quantity data
  - Known MPS values
  - Expected IRF outputs
- Store in tests/fixtures/
- **Dependency**: None
- **Deliverable**: tests/fixtures/ with test data

#### Todo: create-unit-tests
- Write unit tests for core functions:
  - test_project_out_controls.m: Verify orthogonality
  - test_compute_confidence_intervals.m: Check coverage
  - test_calc_local_projection.m: Validate against known result
- Use MATLAB's built-in testing framework or simple scripts
- **Dependency**: create-test-data, all Phase 2-4 refactoring
- **Deliverable**: 3+ unit test files

#### Todo: create-integration-test
- Create `tests/test_full_pipeline.m`:
  - Run main.m on test data
  - Compare outputs to saved baseline results
  - Check all figures are generated
  - Validate .mat file contents
- **Dependency**: create-test-data, all refactoring
- **Deliverable**: Integration test script

#### Todo: validate-results
- Run refactored code on original data
- Compare outputs to saved baseline (from current code):
  - LP results: check vBeta, confidence intervals within tolerance
  - PM results: check vBeta, AR bounds
  - Figures: visual inspection or pixel comparison
- Document any numerical differences (expected due to inv→backslash change)
- **Dependency**: All refactoring complete
- **Deliverable**: Validation report

---

### Phase 8: Documentation & Cleanup
**Goal**: Make project GitHub-ready

#### Todo: create-readme
- Create README.md with:
  - Project title and brief description
  - Research question overview
  - Data sources and requirements
  - Installation/setup instructions
  - Basic usage example (run main.m)
  - Output description (where to find figures/results)
  - Citation/references
  - License information
- Keep it concise (basic README as requested)
- **Dependency**: None
- **Deliverable**: README.md in project root

#### Todo: create-directory-structure-doc
- Create docs/directory_structure.md:
  - Tree view of project organization
  - Brief description of each directory
  - Explanation of Codes/ subdirectories (core/, utils/, plotting/, etc.)
- **Dependency**: All refactoring (final structure known)
- **Deliverable**: docs/directory_structure.md

#### Todo: cleanup-old-files
- Remove all .asv files (MATLAB autosaves)
- Remove commented-out code blocks
- Archive or delete unused test code
- Add .gitignore for MATLAB:
  - *.asv
  - *.m~
  - Data/Processed/*.mat (optional - can commit or exclude)
  - Data/Figures/*.png (optional)
- **Dependency**: All refactoring complete
- **Deliverable**: Clean codebase, .gitignore file

#### Todo: organize-directory-structure
- Final directory structure:
  ```
  Sectoral_TradeOffs/
  ├── README.md
  ├── .gitignore
  ├── Codes/
  │   ├── main.m
  │   ├── run_all.m
  │   ├── config/
  │   │   └── ProjectConfig.m
  │   ├── paths/
  │   │   └── initialize_paths.m
  │   ├── data_import/
  │   │   ├── import_pce_data.m
  │   │   ├── import_mps_data.m
  │   │   ├── import_controls.m
  │   │   ├── read_pce_raw.m
  │   │   ├── transform_pce.m
  │   │   └── split_by_level.m
  │   ├── core/
  │   │   ├── get_lp.m
  │   │   ├── get_pm.m
  │   │   ├── calc_local_projection.m
  │   │   ├── calc_phillips_multiplier.m
  │   │   ├── compute_ar_bounds.m
  │   │   ├── project_out_controls.m
  │   │   └── compute_confidence_intervals.m
  │   ├── utils/
  │   │   ├── load_data_safe.m
  │   │   ├── validate_inputs.m
  │   │   ├── report_missing.m
  │   │   ├── ensure_dir.m
  │   │   ├── log_message.m
  │   │   ├── NeweyWest.m
  │   │   ├── EffectiveFstat.m
  │   │   └── FindUpperLower.m
  │   ├── plotting/
  │   │   ├── plot_lp.m
  │   │   ├── plot_irfs.m
  │   │   ├── create_irf_subplot.m
  │   │   ├── rescale_irf.m
  │   │   └── shadedErrorBar.m (selected version)
  │   └── tests/
  │       ├── fixtures/
  │       ├── test_project_out_controls.m
  │       ├── test_compute_confidence_intervals.m
  │       ├── test_calc_local_projection.m
  │       └── test_full_pipeline.m
  ├── Data/
  │   ├── Raw/
  │   ├── Processed/
  │   └── Figures/
  └── docs/
      ├── directory_structure.md
      └── variable_naming_guide.md
  ```
- Move files to new structure
- Update all path references
- **Dependency**: All refactoring, cleanup-old-files
- **Deliverable**: Organized project structure

---

## Success Criteria

### Code Quality
- [ ] No code duplication >10 lines
- [ ] All functions <100 lines
- [ ] All magic numbers in config
- [ ] Consistent naming throughout
- [ ] All functions documented

### Robustness
- [ ] Input validation on all public functions
- [ ] Informative error messages
- [ ] No inv() usage (use backslash)
- [ ] No hard-coded paths

### Testing
- [ ] Unit tests for core functions pass
- [ ] Integration test passes
- [ ] Results match baseline within tolerance

### Documentation
- [ ] README.md complete
- [ ] All functions have headers
- [ ] Directory structure documented

### GitHub Readiness
- [ ] No .asv files
- [ ] No commented-out code
- [ ] .gitignore configured
- [ ] Professional structure

---

## Risk & Considerations

### Numerical Precision
Replacing inv() with backslash may cause tiny numerical differences. Document these in validation phase.

### Backward Compatibility
Old scripts referencing hard-coded paths will break. This is acceptable for a clean refactor.

### Testing Coverage
Without ground-truth analytical solutions, testing relies on regression tests (comparing to baseline). Changes in numerical methods may require updating baselines.

---

## Estimated Effort
- **Phase 1-2**: Foundation & Core (~40% of work)
- **Phase 3-4**: Data & Visualization (~25%)
- **Phase 5-6**: Naming & Robustness (~20%)
- **Phase 7-8**: Testing & Docs (~15%)

Total: ~30-40 todos across 8 phases
