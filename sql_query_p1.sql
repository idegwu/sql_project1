drop table if  exists retail_sales;
create table retail_sales(

			transactions_id int primary key,
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(15),
			age int,
			category varchar(15),
			quantiy int,
			price_per_unit float,
			cogs float,
			total_sale float
);

select * from retail_Sales
where
	transactions_id is null 
	or 
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null 
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null 
	;

delete
from retail_sales
where
	transactions_id is null 
	or 
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null 
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null 


select *
from retail_sales;

-- data exploration 

select count(distinct(customer_id)) as total_sales from retail_sales;

select count(distinct(category)) as cat_num from retail_sales;

select * from retail_sales
order by category;

-- data analysis/business problems or answers
-- write a sql query to retrieve all columns on sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05'; 

-- write a sql query to retrieve all transactions where the category is clothing and the quantity sold is > 4 and on nov-2022
select * from retail_sales
where category = 'Clothing' and quantiy >=4 and to_char(sale_date,'yyyy-mm') ='2022-11'; 

-- write sql query to solve the total sales for each category

select category, sum(total_sale)
from retail_sales
group by category;

-- write a sql query to find the average age of customers who purchased items from the beauty category 

select * from retail_sales;

select avg(age) as avg_age
from retail_sales
where category = 'Beauty'
;

-- write a sql query to find all transactions where the total sale is greater than 1000
 select * from retail_sales 
 where total_sale > 1000;

 -- write sql query to find the total number of transactions made by each gender in each category
  select sum(transactions_id), gender ,category as dis_cat
  from retail_sales
  group by category,gender;

  select distinct(gender),category,sum(transactions_id)
  from retail_sales
  group by gender,category;

  -- write a sql query to calculate the average sale for each month, find out the best selling month in each year
select * from 
( 
select 
		extract(year from sale_date) as sale_year,
		extract(month from sale_date) as sale_month,
		avg(total_sale) as avg_sale,
		rank () over(partition by extract(year from sale_date) order by avg(total_sale) desc )
	from retail_sales
	group by sale_year,sale_month
) as t1
where rank = 1;

select distinct(extract(year from sale_date)) from retail_sales;

-- write sql query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) as sum_total
from retail_sales
group by customer_id
order by sum_total desc
limit 5;
-- order by total_sale desc

-- write sql query to find the number of unique customers who purchased items from each category
select count(distinct(customer_id )) as unique customers,category
from retail_sales
group by category;

-- write a sql query to create each shift and number of orders (example morning <=12,aftternoon between 12 and 17, evening> 17)

with hourly_sale as
( 
SELECT 
    *,
    CASE
        WHEN extract(hour from sale_time) < 12 THEN 'morning'
		WHEN extract(hour from sale_time) between 12 and 17 then 'afternoon'
		WHEN extract(hour from sale_time) > 17 THEN 'evening'
    END AS shift
FROM retail_sales)
select shift, count(transactions_id) as order_num from hourly_sale
group by shift
order by shift;


