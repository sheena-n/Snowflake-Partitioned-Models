# Snowflake Partitioned Models
The Snowflake Model Registry supports distributed processing of training and inference of partitioned data.
[Documentation](https://docs.snowflake.com/en/developer-guide/snowflake-ml/model-registry/partitioned-custom-models)

### How to run this code?
##### Step 1 : Run SQL script synthetic_data_generation.sql in Snowflake
- Create a SQL worksheet or notebook to run this code.
##### Step 2: Run python script MULTI_TIMESRIES_CLTV_PREDICTION/notebook_app.ipynb
- Download notebook_app.ipynb and environment.yml files
- Create a Snowflake notebook by importing the notebook_app.ipynb file
  [Documentation](https://docs.snowflake.com/en/user-guide/ui-snowsight/notebooks-setup)
  
 ![Importing notebook files into Snowfale notebook](notebook_import.gif)

