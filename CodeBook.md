# CookBook for Getting and Cleaning Data Course Project

The script `run_analysis.R` performs roughly step-by-step from 1-5 as detailed in the Project Requirements:

1. Loads individually the files into `data.frames` and merges the training, test sets into 3 separate data.frames of `x_all`, `y_all` and `subject_all` with additional labels. This is done so that extracting the mean and std columns is easier.

2. `features.txt` is loaded used to labeled to the `x_all` dataset. Additionally, using the features descriptive vector to GREP the mean and standard deviation descriptive indices which is later used to subset `x_all` dataset for the required columns only.

3. Using the descriptive activity labels loaded from `activity_labels.txt`, the `y_all` dataset is updated such that the numeric list is replaced with the 6 activity word labels instead (eg. RUNNING).

4. This is used instead to bind `x_all`,`y_all` and `subject_all` into a single large dataframe.

5. Using the pply packages's `ddply` function, the data is reshaped to the average(mean) of the first numeric 1:66 columns. Based on every DIFFERENT instance of the Activity and Subject column values, it produces a dataset of 180 rows (6 * 30) which is written out into a .txt file `activity_final_data.txt`.

## Variables

* 