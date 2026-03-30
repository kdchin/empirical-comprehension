# Supplemental Materials for 'Put The "Code" Back In "Code Comprehension Study"'

This repository contains the supplemental materials for our [ICPC '26 paper](https://conf.researchr.org/details/icpc-2026/icpc-2026-research/13/Put-The-Code-Back-in-Code-Comprehension-Study-).
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


### Reference Format
```
Kyle D. Chin and Reid Holmes. 2026. Put The “Code” Back In “Code Comprehension Study”. In 34th IEEE/ACM International Conference on Program
Comprehension (ICPC ’26), April 12–13, 2026, Rio de Janeiro, Brazil. ACM,
New York, NY, USA, 13 pages. https://doi.org/10.1145/3794763.3794806
```
