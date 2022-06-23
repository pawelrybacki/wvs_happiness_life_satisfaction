## Predicting Happiness and Life Satisfaction Globally

This is my Harvard Stat 109 final project studying the main predictors
of happiness and life satisfaction globally.

**Research Question**

What are the statistically significant predictors of 1) the feeling of
happiness, and 2) life satisfaction?

**Motivation**

Although not all of us have a well-defined purpose of life, we all can
feel different forms and degrees of happiness and of life satisfaction.
When growing up, we shape our beliefs and set ourselves goals based on
them. However, while education systems help us form our opinions and
realize many of these goals, we often end up ignorant about what
ultimately matters in life. The purpose of this paper is to establish
what factors are associated with the feelings of happiness and life
satisfaction. Since establishing casual relationships is beyond the
scope of this paper, since one size does not always fit all, and since
the project has many limitations, none of the results is a recipe for
happiness. However, the surprising little discoveries my analysis
uncovers are a good starting point to reflect again on what brings us
happiness and life satisfaction.

**About the Files in this Repository**

The main file `02_full_markdown.Rmd` is the markdown that conducts an
analysis (using both code and text) of happiness and life satisfaction
based on the longitudinal 1981-2014 [World Values
Survey](www.worldvaluessurvey.org) data.

Using the original WVS data, the Stata script `01_prepare_dataset.do`
prepares and cleans the final dataset (`wvs_happiness.dta`) used by
`02_full_markdown.Rmd` in the analysis.
