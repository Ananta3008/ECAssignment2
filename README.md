# ECAssignment2

This MATLAB script implements a Heuristic Approximation Algorithm for solving instances of the Generalized Assignment Problem (GAP). It processes GAP benchmark files (gap1.txt to gap12.txt), applies a greedy resource-aware assignment strategy, and saves the approximate results in a file called gap_approx_result.txt.

You’ve also run a separate script using intlinprog (ILP) to get the optimal values

Results are saved in gap_ilp_result.txt.
This repository implements and compares two approaches for solving the Generalized Assignment Problem (GAP):

ILP Solver: Computes optimal solutions using MATLAB's intlinprog

Approximation Algorithm: Greedy heuristic that assigns each user to the lowest-cost feasible server

Both methods are applied across 12 standard GAP benchmark files. The result for the 5th instance of each GAP file is extracted and plotted in a comparative graph.

gap_ilp_result.txt — Optimal ILP results

gap_approx_result.txt — Heuristic approximation results

comparison_ilp_vs_approx.png — Line plot showing both series side-by-side
