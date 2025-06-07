# xbtab: Extended 2×2 Contingency Table Analysis for Stata

A Stata command that performs comprehensive exact statistical tests for 2×2 contingency tables, including Fisher's, Barnard's, and Boschloo's exact tests.

## Overview

`xbtab` extends Stata's built-in contingency table analysis by providing three exact statistical tests that are useful for small sample sizes or when the assumptions of chi-square tests are violated. The command integrates Python's SciPy library to perform advanced exact tests not available in vanilla Stata.

## Features

- **Fisher's Exact Test**: Classical conditional exact test
- **Barnard's Exact Test**: Unconditional exact test (more powerful than Fisher's)
- **Boschloo's Exact Test**: Hybrid approach combining Fisher's and Barnard's methods
- Clean, formatted output with p-values matrix
- Full integration with Stata's return system
- Comprehensive help documentation

## Requirements

- Stata 18 or later
- Python integration enabled in Stata
- SciPy library installed in Python environment

### Setting up Python Integration

1. Install Python with SciPy:
   ```bash
   pip install scipy numpy
   ```

2. Configure Stata to use Python:
   ```stata
   python query
   python set exec "path/to/python"  // if needed
   ```

## Installation

1. Download the files:
   - `xbtab.ado` - Main command file
   - `xbtab.sthlp` - Help documentation
   - `xtab_eg.do` - Example do file that performs the test on a subset of NHANES data

2. Place files in your Stata ado directory:
   ```stata
   adopath
   ```
   Copy files to the displayed PERSONAL or PLUS directory.

3. Alternatively, place files in your current working directory.

## Syntax

```stata
xbtab rowvar colvar [if] [in]
```

### Parameters
- `rowvar`: First categorical variable (row variable)
- `colvar`: Second categorical variable (column variable)

Both variables must result in exactly 2 categories after applying any `if` or `in` conditions.

## Examples

### Basic Usage
```stata
. xbtab treatment outcome
```

### With Conditions
```stata
. xbtab gender response if age > 30
```

### Creating Binary Variables
```stata
. generate high_score = (score > median_score)
. generate treated = (group == "treatment")
. xbtab high_score treated
```

## Output

The command displays:
1. Cross-tabulation matrix
2. Formatted p-values table with all three exact tests

Example output:
```
Statistical Test P-values

           P-value
Boschloo  .045231
Barnard   .048392
Fisher    .052847
```

## Returned Results

The command stores the following scalars in `r()`:

- `r(fisher_pvalue)`: Fisher's exact test p-value
- `r(barnard_pvalue)`: Barnard's exact test p-value  
- `r(boschloo_pvalue)`: Boschloo's exact test p-value

### Using Returned Results
```stata
. xbtab treatment outcome
. display "Fisher p-value: " r(fisher_pvalue)
. display "Most powerful test p-value: " r(boschloo_pvalue)
```

## Statistical Background

### Fisher's Exact Test
- Conditions on both row and column marginal totals
- Conservative approach, widely used and accepted
- Appropriate when marginal totals are considered fixed

### Barnard's Exact Test  
- Conditions only on total sample size
- Generally more powerful than Fisher's test
- Appropriate when only total sample size is fixed

### Boschloo's Exact Test
- Hybrid approach maximizing power while maintaining exact Type I error control
- Often provides the most powerful exact test
- Recommended when maximum power is desired

## Troubleshooting

### Common Issues

1. **Python not found**: Ensure Python is installed and configured in Stata
   ```stata
   python query
   ```

2. **SciPy not available**: Install SciPy in your Python environment
   ```bash
   pip install scipy
   ```

3. **Non-2×2 table**: Ensure both variables have exactly 2 categories
   ```stata
   tab rowvar colvar  // Check dimensions first
   ```

4. **Empty cells**: The command handles zero cells, but very sparse tables may cause issues

## Version History

- **v1.0.0** (June 2025): Initial release
  - Fisher's, Barnard's, and Boschloo's exact tests
  - Python integration via SciPy
  - Comprehensive help documentation

## Author

**Alun Hughes**  
University College London  
Department of Population Science & Experimental Medicine  
London, UK  
📧 [alun.hughes@ucl.ac.uk](mailto:alun.hughes@ucl.ac.uk)

## License

This software is provided "as is" without warranty. Users are free to modify and distribute with appropriate attribution.

## References

- Barnard, G. A. (1947). Significance tests for 2×2 tables. *Biometrika*, 34, 123-138.
- Boschloo, R. D. (1970). Raised conditional level of significance for the 2×2-table when testing the equality of two probabilities. *Statistica Neerlandica*, 24, 1-9.
- Fisher, R. A. (1922). On the interpretation of χ² from contingency tables, and the calculation of P. *Journal of the Royal Statistical Society*, 85, 87-94.

## Contributing

Bug reports and feature requests are welcome. Please include:
- Stata version
- Python version
- SciPy version
- Minimal reproducible example

---

For detailed documentation, use `help xbtab` within Stata after installation.
