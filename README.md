# What Makes Us Happy? Examining the Impact of Social, Economic, and Personal Factors

## Overview

Understanding the factors influencing individual happiness is essential for improving well-being and developing effective strategies to enhance quality of life. Identifying predictors of happiness helps clarify socio-economic and demographic patterns that shape people's experiences. This study examines self-reported happiness levels, focusing on how variables such as marital status, income, education, and job satisfaction impact well-being.

We applied a Bayesian logistic regression model to analyze the data, sourced from the [GSS Data Explorer](https://gssdataexplorer.norc.org/MyGSS), which provides a detailed repository of General Social Survey (GSS) data.



## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from [GSS Data Explorer](https://gssdataexplorer.norc.org/MyGSS).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, datasheet, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Some portions of the code were developed with the assistance of ChatGPT-4o. Additionally, the abstract, introduction, descriptions of tables and results, as well as the survey design, were created with support from ChatGPT-4o. The complete chat history documenting this assistance is stored in other/llm_usage/usage.txt.

