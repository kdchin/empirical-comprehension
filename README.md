# Supplemental Materials for Code Comprehension: Where Did We Go Wrong?

This repository contains the supplemental materials for our ASE '25 submission.
See [repos.txt](./repos.txt) for a list of repositories examined and [comment_data.txt](./comment_data.txt) for a breakdown of comment usage by repository and language.

## Data
[data/](./data/) contains the full metrics and statistics calculations for methods examined, including the complexity and readability metrics, Cliff's Delta, and p-values. The actual parsed comments are too large to include. See [this file](./data/repo_decision_points.csv) to see what a Length-limit threshold would be for different %NonCommentMethods (30-70%) for each repository.

## Analysis
[sample.ipynb](./sample.ipynb) contains example python code for loading and using the data in the [data/](./data) folder.

## Figures
[fis/](./figs) contains the full-sized figures from the paper to allow closer introspection (and zooming!). Also included is a breakdown of 50 graphs showing the % of non-comment methods by method length for each repository examined in this study.
