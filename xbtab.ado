program define xbtab, rclass
	version 18
	syntax varlist(min=2 max=2)
	
	// Parse input
	local rowvar : word 1 of `varlist'
	local colvar : word 2 of `varlist'
	
	// Create 2x2 cross-tab and store frequencies
	qui tabulate `rowvar' `colvar', matcell(results)
	
	// Display matrix
	matrix list results
	
	// Call the python function
	python: run_2by2_tests()
	
	// Return the calculated p-values (they're already in r() from Python)
	return scalar fisher_pvalue = r(fisher_pvalue)
	return scalar barnard_pvalue = r(barnard_pvalue)
	return scalar boschloo_pvalue = r(boschloo_pvalue)
	
	// Create a matrix table for easier formatting
	matrix pvalues = (r(boschloo_pvalue) \ r(barnard_pvalue) \ r(fisher_pvalue))
	matrix rownames pvalues = "Boschloo" "Barnard" "Fisher"
	matrix colnames pvalues = "P-value"
	
	display ""
	display "P-values Matrix:"
	matrix list pvalues, format(%9.6f) title("Statistical Test P-values")
end

// Python function 
version 18
python:
import sfi
import scipy.stats as stats
import numpy as np

def run_2by2_tests():
    print("Getting matrix...")
    matrix_data = sfi.Matrix.get("results")
    print("Matrix retrieved successfully")
    print("Matrix data:", matrix_data)
    print("Matrix type:", type(matrix_data))
    
    if hasattr(matrix_data, '__len__'):
        print("Matrix shape/length:", len(matrix_data))
    if hasattr(matrix_data, 'shape'):
        print("NumPy shape:", matrix_data.shape)
    
    print("Converting to proper format...")
    if isinstance(matrix_data, np.ndarray):
        if matrix_data.shape == (2, 2):
            table = matrix_data.astype(int)
        else:
            table = matrix_data.reshape(2, 2).astype(int)
    elif isinstance(matrix_data, list):
        if len(matrix_data) == 2 and len(matrix_data[0]) == 2:
            table = [[int(x) for x in row] for row in matrix_data]
        elif len(matrix_data) == 4:
            table = [[int(matrix_data[0]), int(matrix_data[1])], 
                    [int(matrix_data[2]), int(matrix_data[3])]]
        else:
            table = matrix_data
    else:
        table = matrix_data
    
    print("Final table:", table)
    print("Table type:", type(table))
    
    print("Starting Fisher exact test...")
    res2 = stats.fisher_exact(table, alternative="two-sided")
    print(f"Fisher p-value: {res2[1]}")
    sfi.Scalar.setValue("r(fisher_pvalue)", res2[1])
    print("Fisher test completed")
    
    print("Starting Barnard exact test...")
    res1 = stats.barnard_exact(table, alternative="two-sided")
    print(f"Barnard p-value: {res1.pvalue}")
    sfi.Scalar.setValue("r(barnard_pvalue)", res1.pvalue)
    print("Barnard test completed")
    
    print("Starting Boschloo exact test...")
    res = stats.boschloo_exact(table, alternative="two-sided")
    print(f"Boschloo p-value: {res.pvalue}")
    sfi.Scalar.setValue("r(boschloo_pvalue)", res.pvalue)
    print("Boschloo test completed")
    
    print("All tests completed successfully")

end