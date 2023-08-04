# Nashville Housing Data Cleaning With SQL
![](intro.jpg)
## Introduction
This project highlights and demonstrates the power and capabilities of SQL in performing data-cleaning tasks. SQL is specifically designed for working with databases and bulky datasets. It provides efficient query processing, making it well-suited for handling substantial amounts of data during the cleaning process. SQL queries are also explicit and reproducible. By saving and documenting the cleaning steps as SQL scripts, one can easily repeat the process on new data or share the cleaning workflow with others.

## About the data set
The data set used was obtained from [Kaggle](https://www.kaggle.com/datasets/yohan313/nashville-housing-data). It contains addresses, building value, names of owners, prices and various other details of properties for the Nashville housing market. The data set consists of 56,474 rows and 19 columns of data.

## The purpose of data cleaning
The purpose of data cleaning, also known as data cleansing or data scrubbing, is for improving data quality and reliability by identifying and correcting or removing inaccuracies, errors and inconsistencies. Data cleaning is a very important step in the data preparation process and plays a crucial role in ensuring the accuracy and integrity of data for analysis, reporting, and decision-making purposes.

## The data cleaning process
### Importing the data set
The Excel file was carefully imported into Microsoft SQL Server Management Studio using the SQL Server Import and Export Wizard.
### Retrieving the table information
The stored procedure 'sp_help' was used to get a summary of the data set. This provided details such as the columns in the table, their data types, any indexes or constraints defined on the table, and other relevant information about the structure of the table.
## Query:
![Screenshot (29)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/1200f729-306a-42ec-9fed-d5f6a5ef65e7)
## Output:
![Screenshot (28)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/f3676d34-993a-4182-891e-47a1ebb2b161)

## Standardizing the Date Format
The dataset contained a date column which was converted from a datetime format to a standardized date format.
### DateTime:
![Screenshot (30)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/2a43a281-2819-4807-9eaf-88b6f6479627)

### Standardized Date: The resulting outcome can be observed in the 'SaleDateConverted' column below:
![Screenshot (31)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/3fd97aae-41c0-475e-bcf0-44193920ccfe)


## Populating property address data using a self-join of the NashvilleHousing table
### It was observed that although some records contained the same ParcelIDs which indicated that the ParcelIDs linked to the same address, not all property address were populated. To solve this issue a self join was used. One example is that of records no 3036 and 3037:
![Screenshot (33)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/42a005c7-3855-4441-bd5c-504a9e9d5593)

###The difference when the address has been populated can be seen below:
![Screenshot (36)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/6f906e7a-04c7-4008-92b3-968487d0aaf8)


## Separating Property addresses into individual columns (Address, City, State)- Using Substring
### The property address column was split from a single address column containing the address and city as seen below:
![Screenshot (37)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/83af88c0-cdb5-4fbe-981f-c51dc24504f4)

## Into two indivividual columns named 'PropertySplitAddress' and 'PropertySplitCity':
![Screenshot (38)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/515673eb-79f3-4736-bd0e-734f327ca927)

## Separating Owner addresses into individual columns (Address, City, State)- Using ParseName and Replace
### The Owner address column was split from a single address column containing the address, city and state as seen below:
![Screenshot (39)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/c96c4e62-4eaa-47fd-836c-6cbb41783400)

### Into three indivividual columns named 'PropertySplitAddress','PropertySplitCity' and 'PropertyState':
![Screenshot (40)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/487374fa-eacd-4aba-99ef-ed532ccd94a4)

### Changing Y and N to Yes and No in "Sold as Vacant" field
![Screenshot (42)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/7bad11f7-49ec-4390-a29a-d2fcb56cfd13)

### Removing Duplicates using CTE
A major aspect of the data cleaning process is the removal of duplicate records in the data set to maintain data integrity and accuracy. However, one must always make sure that there is indeed a duplicate record before proceeding to delete it.

In this table, the duplicate check revealed that there were multiple ParcelIDs, Sale dates, address, price and legal reference records that were supposed to be unique to each row but were the exact same therefore indicating there were duplicates of the same record in the dataset. 
### The query below was used to remove all duplicates:
![Screenshot (44)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/711a782a-d5cc-4f2a-a10d-331a69d32902)

### The Output:
![Screenshot (45)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/8097085e-d3f7-4864-9610-c5efac82587a)

## Dropping Irrelevant Columns
Another aspect of the data cleaning process is the dropping of irrelevant columns. To improve the data analysis process and enhance model performance, it is important to drop irrelevant columns. This helps reduce noise and clutter in the data set and as a result, the computational efficiency is improved. However, one must be sure a column is truly irrelevant before performing a permanent drop.

In this table the SaleDate, OwnerAddress, PropertyAddress and TaxDistrict columns can be considered irrelevant since a new standardized date column has replaced SaleDate, new individual colums containing address, city and state have replaced the Owner and Pzroperty address columns, finally the TaxDistrict column is irrelevant to the analysis.

### Query:
![Screenshot (46)](https://github.com/Ikumoluyi-Taiwo/SQL-Queries/assets/139241043/9bb274b4-fcb9-409e-b18c-531bee8cf394) 

NB: The full SQL script used for cleaning the data is available in my Nashville Data Cleaning [repository](https://github.com/emmywritescode/SQL-Queries/blob/main/CLEANING%20FIFA%2021%20DATA%20SET.sql) for examination or reuse.

## Conclusion
Completing this data cleaning project has greatly improved my SQL skills. I was afforded the opportunity to leverage the power and flexibility of SQL for data cleaning and manipulation. 

The experience of cleaning this data with SQL has not only expanded my technical skills but also provided me with a valuable skill set that can be applied to various data-related tasks. The ability to work with SQL gives me the confidence to tackle more complex data cleaning and manipulation projects in the future, enabling me to be more effective and efficient in my data analysis endeavors.
