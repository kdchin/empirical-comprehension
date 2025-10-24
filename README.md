# Supplemental Materials for 'Put The "Code" Back In "Code Comprehension Study"'

This repository contains the supplemental materials for our ICPC '26 submission.
See [repos.csv](./data/repos.csv) for a list of repositories examined. This file also contains the approximate SHA and the details of our analysis of their code review and static analysis processes.
The comments we sampled to check for junk comments is in [sampled_comments_per_lang.csv](./data/sampled_comments_per_lang.csv).

## Data
[data/](./data/checkpoint.pkl) contains the full raw data of our dataset in the form of a pandas dataframe

## Analysis
[analysis.ipynb](./analysis.ipynb) contains the code for generating all the figures and statistics used in the paper. We quote specific values from specific projects, but we provide the complete calculations.

## Figures
[figs/](./figs) contains the full-sized figures from the paper to allow closer introspection (and zooming!).

## Queries
[queries/](./queries) contains the queries we used on [GithubArchive](https://www.gharchive.org/) to retrieve the required metadata.
