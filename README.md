# Walmart_Recruiting_Store_Sales_Forecasting
Data Analyst Internship Take Home Assessment

---  

### 1. Dataset overview

#### 1.1 **'stores.csv'**

45 rows, 3 columns;  
45 Walmart stores located in different regions, no missing values

Features:

- [Store] - the store numebr
- [Type] - the type of store
- [Size] - the size of the store

#### 1.2 **'features.csv'**

8190 rows, 12 columns;  
This file contains additional data related to the store, department, and regional activity for the given dates. Has missing values.

Features:

- [Store] - the store number
- [Date] - the week
- [Temperature] - average temperature in the region
- [Fuel_Price] - cost of fuel in the region
- [MarkDown1-5] - anonymized data related to promotional markdowns that Walmart is running. MarkDown data is only available after Nov 2011, and is not available for all stores all the time. Any missing value is marked with an NA.
- [CPI] - the consumer price index
- [Unemployment] - the unemployment rate
- [IsHoliday] - whether the week is a special holiday week

#### 1.3 **'train.csv'**

- 421570 rows, 5 columns;  
This is the historical training data, which covers to 2010-02-05 to 2012-11-01

Features:

- [Store] - the store number
- [Dept] - the department number
- [Date] - the week
- [Weekly_Sales] -  sales for the given department in the given store
- [IsHoliday] - whether the week is a special holiday week

#### 1.4 **'test.csv'**

115064 rows, 4 columns;  
This file is identical to train.csv, except we have withheld the weekly sales. 

Features:

- [Store] - the store number
- [Dept] - the department number
- [Date] - the week
- [IsHoliday] - whether the week is a special holiday week

---  

### 2. Explore Datasets

#### 2.1 **'Explore stores_df'**

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/3e98c758-8776-4881-9c5b-c543428a135b)

Observation on stores   

1. About half of the stores are Type A
2. Type A basically has the biggest size, and Type C has the smallest one
3. There are only a few exceptions (outliers) in observation 2

#### 2.2 **Merge Datasets**

We will left join 'train' and 'test' with 'stores' and 'features' respectively

#### 2.3 **Generate new features 'month' & 'week' form 'Date'**

We extract the month and week from the date to better observe the impact of time on weekly sales from two different time levels.

#### 2.4 **Explore 'train_df'**

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/7352e569-9337-490b-a7af-1a34268da61b)

All missing values exist in 'markdown' features:

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/e776bb26-14da-43d0-8888-950adf91f186)

##### 2.4.1 feature 'Store'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/28236639-c149-4eea-a7e2-39eea2fc5680)

By observing, we notice that top 5 best stores(having highest average weekly sales) are all of type A, so the type of store might be an important feature for prediction.

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/5c729018-b4f6-46cb-8dd5-04e8f687eee9)

##### 2.4.2 feature 'Dept'(Department)

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/9fe5165b-2081-4b3a-b1d6-3ee195be2d2c)

The top 8 best departments (having highest average weekly sales) are 92, 95, 38, 72, 65, 90, 40, 2. Stores have these departments might has higher weekly sales.

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/a37d6af6-6988-4bfa-ba63-8db72b0b6b40)

##### 2.4.3 feature 'IsHoliday'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/84ce03dd-1d91-4bd2-8741-419b256fd830)

In general, the weekly sales during holidays is slightly higher than that of non-holidays. However, the number of weeks of non-holiday periods far exceeds that of holidays. Therefore, whether the current time falls within a holiday might has a significant impact on the weekly sales.

##### 2.4.4 feature 'Type '

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/179689c7-4f24-4e6a-b1dd-6348d85e0752)

Type 'A' has the highest Avg weekly sales, which is consistent with what we found before when we explore feature 'Store'.

##### 2.4.5 feature 'Size'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/6a814b69-4e27-45a3-8595-a6ecb4b2566a)

While weekly sales does increase to some extent with size, there are still many unexpected deviations from this pattern. We will verify the importance of this feature in 'Feature Selection' section.

##### 2.4.6 feature 'Temperature'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/5d18a3ef-80b5-48d7-844f-c590ee1823b9)

It can be observed that extremely cold and extremely hot weather reduces people's desire to shop. The temperature range between approximately 25 degrees and 75 degrees is when people are more inclined to go out.

A big portion of both Type B and Type A stores are located in regions where the temperature is relatively suitable thus sometimes have higher weekly sales.

##### 2.4.7 feature 'Fuel_Price'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/da6e8a59-4569-44f6-addb-73a4930c284c)

Overall, lower fuel prices tend to make people more willing to shop, as many households need to purchase a large amount of goods and use cars to transport them back home. Weekly sales revenue also increases when fuel prices are between 2.75 and 3.75.

##### 2.4.8 features 'MarkDown' 1 - 5

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/dabcf6e1-79ae-453d-bda5-058aff4892de)

Due to the fact that only rows with null values in markdown1-5 were deleted, there are still many retained rows where certain columns have values of null. Therefore, based on the current observations, we can not draw a clear relationship between markdowns and weekly sales at this time. Further investigation regarding these features will be leaved to the feature importance section.

##### 2.4.9 feature 'CPI'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/f73c45d8-8e4c-4226-a795-316305ac9d14)

According to https://www.investopedia.com/terms/c/consumerpriceindex.asp:

"The Consumer Price Index (CPI) measures the monthly change in prices paid by U.S. consumers. The Bureau of Labor Statistics (BLS) calculates the CPI as a weighted average of prices for a basket of goods and services representative of aggregate U.S. consumer spending."

Same as 'Markdown', based on the current observations, we can not draw a clear relationship between markdowns and weekly sales at this time. Further investigation regarding these features will be leaved to the feature importance section.

##### 2.4.10 feature 'Unemployment'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/1ab15b9d-8233-4d3c-b9d3-e27885546bd1)

Low unemployment seems to contribute to the weekly sales, but still, same as 'Markdown', based on the current observations, we can not draw a clear relationship between markdowns and weekly sales at this time. Further investigation regarding these features will be leaved to the feature importance section.

##### 2.4.11 feature 'month'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/e2edba2c-c3e4-4a5d-8ee4-835b50fef8e4)

Holidays are in February, September, November, and December. Based on observations, the average weekly sales is lowest in January and highest towards the end of the year. The drop in sales in September and October may be due to people waiting for the discount events brought by Thanksgiving, Christmas (and possibly Black Friday).

##### 2.4.12 feature 'week'

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/15308f81-fd0f-4d2d-bdb0-134e79861dc9)

Breaking down time into weekly sales allows us to observe in greater detail how sales fluctuate from week to week. Overall, the trend of sales changing weekly roughly follows the trend of sales changing monthly. It can be observed that around weeks 6, 35, 47, and 51, which correspond to holidays, there is a significant increase in weekly sales.

---  

### 3. Feature Selection

##### 3.0.1 Create dummy variables

Convert 'Type' to dummy variables since it might be an important features and we want to use it.

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/040a9eb8-cbcc-4e2c-8287-5a16e8cefc88)

##### 3.0.2 Generate new features 'has_top_departments'

92, 95, 38, 72, 65, 90, 40, 2: top 8 departments, Ture for having those departments and False for not having.

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/c0c7e37d-6a37-47ba-a78e-d9cbfca2bab1)

##### 3.0.4 Fill missing values for markdown 1 - 5

By observing the density plot of features 'markdown' 1 - 5, their distribution is uneven so that we try to use median to filling missing values. Here is one example:

Before:

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/6ce50d88-73ee-4114-9fb4-12d0a85bfeae)

After:

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/3c1ce6f1-2f3d-426a-a589-9c1e5ab245de)

The shape of the distribution does't change too much.

#### 3.1 Filter method

##### 3.1.1 ANOVA(f_regression)

By using SelectKBest with f_regression, this method tells us the top 5 best features are:  
**['Dept' 'Size' 'Type_A' 'Type_B' 'has_top_departments']**

##### 3.1.2 Correlation Matrix

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/f9137b96-ef24-4760-a4da-b7d78c65b122)

By observing,  
**['Dept', 'Size', 'Type A' and 'has_top_departments']** have decent positive correlation with 'Weekly Sales'  
Markdown 1-5 have little correlation on weekly sales, as well as features such as 'Tempreture', 'Fuel_Price', 'CPI' and 'Unemployment'

#### 3.2 Embedded Methods

##### 3.2.1 Feature Importance by LASSO

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/6bd28cd8-674e-4ab4-be52-8e1a497b1b4c)

By using alpha = 25, Lasso thinks **['Store', 'Size', 'CPI', 'Type_C', 'has_top_departments']** are important features.

##### 3.2.3 Feature Importance by RandomForest

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/a0efcb82-4edf-464a-a7c8-6b3d03062db3)

Random Forest(n = 150, d = 10) thinks **['has_top_departments', 'Dept', 'Size', 'Store', 'Type B', 'CPI', 'week']** are important features.

---

### 4. Model Selection

In order to increase training speed, reduce model complexity, I use the subset:  

['has_top_departments' , 'Dept' , 'Size' , 'Store' , 'Type_A' , 'week' , 'Unemployment' , 'IsHoliday']

- 'has_top_departments': most feature selection methods think it's important
- 'Dept': has some correlation with 'has_top_departments', while most feature selection methods think it's important
- 'Size': most feature selection methods think it's important, also intuitively significant
- 'Store': two embedded methods think it's important
- 'Type A': By observation, try to enhance the predictive power by introducing one of these types into the model
- 'week': introducing time into model
- 'Unemployment': randomly choose a feature which is not that important
- 'IsHoliday': although no feature selection methods recommand it, by observing, it should intuitively be an important feature

Moel we use:

0: 'Ridge'  
1: 'Lasso'  
2: 'KNeighborsRegressor'  
3: 'RandomForestRegressor'  
4: 'LGBMRegressor'  
5: 'CatBoostRegressor'  
6: 'GradientBoostingRegressor'  

using cross_val_score with 3-fold, the R^2 of these models are:  
![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/ba58b956-3d56-42c0-9a47-f15cdb2410e4)

Thus I decide to use CatBoostRegressor, by doing Grid Search CV: 
![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/3d36d3fb-fa88-48b3-8e3f-7fcd2b82dda3)

### 5. Submit

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/38742943-0b5e-4430-8090-fc2d0e325630)

### 6. Insights & Suggestions

**Insights:**  

1. Type A stores contributed the most weekly sales  
2. Departments 92, 95, 38, 72, 65, 90, 40, and 2 contributed the most to weekly sales  
3. Sales increase significantly during the holiday season  
4. the larger the store, the more money customers generally spend in it (e.g. because of a larger assortment)  
5. moderate temperatures (25 - 75) may have a positive effect on weekly sales  
6. low fuel prices may have an effect on weekly sales  
7. low unemployment may have a positive effect on weekly sales  
8. people's desire to shop is low at the beginning of the year and peaks at the end of the year  

**Suggestions:**  

1. Consider opening more type A stores  
2. Consider introducing sectors 92, 95, 38, 72, 65, 90, 40, and 2 into each existing store.  
3. proactively survey local residents' purchasing preferences prior to holidays and make promotion plans  
4. Increase the size of the store to include a wider range of products while considering value for money.  
5. Locate stores in areas with favorable temperatures.  
6. reduce the supply of goods that are likely to expire at the beginning of the year and ensure that orders are shipped to stores in a timely manner by November.  

### 7. Further Improments and Limitation of this project

The biggest challenge facing this project is the tight schedule, as next week is the exam week. So I spent only about 1.5 day to complete it.

![image](https://github.com/Magicboy-Zhang/Walmart_Recruiting_Store_Sales_Forecasting/assets/74690677/56c68df7-2bdb-40d0-a0cf-1bcb3e3d26c3)

I believe there is still much untapped potential in the markdown features, such as finding better ways to fill missing values. A detailed investigation of people's purchasing habits during various holidays can also aid in predictions. Most importantly, with enough time, I can add more features to the model and try methods that require longer learning times (such as increasing the number of trees, adjusting the learning rate, etc.), which also applies to the final grid search. Considering changing from 3-fold to 5-fold cross-validation could yield more convincing results. I could try a variety of models, spend more time tuning parameters, and attempt to construct new features from existing ones. Exploring principal component analysis and using wrapper methods like recursive feature elimination with cross-validation could spend more time selecting the optimal feature subset.

