# What Makes Us Happy? Unveiling the Impact of Social, Economic, and Personal Factors

## Overview

The factors influencing individual happiness are crucial for understanding overall well-being and developing strategies to improve quality of life. Identifying the key predictors of happiness can provide significant insights into socio-economic and demographic dynamics. This study focuses on self-reported happiness levels, aiming to uncover how variables such as marital status, income, education, and job satisfaction contribute to well-being.

We utilized a Bayesian logistic regression model to analyze the data, which was obtained from the [GSS Data Explorer](https://gssdataexplorer.norc.org/MyGSS), a comprehensive source of General Social Survey (GSS) data.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from [GSS Data Explorer](https://gssdataexplorer.norc.org/MyGSS).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the paper and code were written with the help of ChatGPT 4o and the entire chat history is available in other/llm/usage.txt.
