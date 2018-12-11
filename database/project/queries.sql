--1.  Write a query to display the current salary for each employee in department 300. Assume that only current employees are kept in the system, 
--    and therefore the most current salary for each employee is the entry in the salary history with a NULL end date. Sort the output in descending
--    order by salary amount.

select * from
(
    select
    a.dept_num as department_number,
    a.emp_num as employee_number,
    a.emp_fname as employee_first_name,
    a.emp_lname as employee_last_name,
    b.sal_amount as latest_salary
    from employee as a
    left join salary_history as b
    on a.emp_num = b.emp_num
    where a.dept_num = 300
    and b.sal_end is null
) x
group by x.department_number, x.employee_number, x.employee_first_name, x.employee_last_name, x.latest_salary;

--2.  Write a query to display the starting salary for each employee. The starting salary would be the entry in the salary history with
--    the oldest salary start date for each employee. Sort the output by employee number.

select
    b.emp_num as employee_number,
    b.emp_fname as employee_first_name,
    b.emp_lname as employee_last_name,
    x.sal_amount as first_salary
from 
(   select b.*,
    (
        select count(*)
        from salary_history a
        where a.emp_num = b.emp_num 
        and a.sal_from <= b.sal_from 
        order by a.emp_num,a.sal_from
    ) as ranked
    from salary_history b 
    order by b.emp_num,b.sal_from
)x
left join employee as b
on x.emp_num = b.emp_num
where x.ranked = 1;

--3.  Write a query to display the invoice number, line numbers, product SKUs, product descriptions, and brand ID for sales of sealer
--    and top coat products of the same brand on the same invoice. 



--4.  The Binder Prime Company wants to recognize the employee who sold the most of their products during a specified period. 
--    Write a query to display the employee number, employee first name, employee last name, e-mail address, 
--    and total units sold for the employee who sold the most Binder Prime brand products between November 1, 2015, and December 5, 2015. If there is a tie for most units sold, sort the output by employee last name. 

--5.  Write a query to display the customer code, first name, and last name of all customers who have had at 
--    least one invoice completed by employee 83649 and at least one invoice completed by employee 83677. 
--    Sort the output by customer last name and then first name. 

--6.  LargeCo is planning a new promotion in Alabama (AL) and wants to know about the largest purchases made by customers in that state. 
--    Write a query to display the customer code, customer first name, last name, full address, invoice date, and invoice total of the largest
--    purchase made by each customer in Alabama. Be certain to include any customers in Alabama who have never made a purchase 
--    (their invoice dates should be NULL and the invoice totals should display as 0). 

--7.  One of the purchasing managers is interested in the impact of product prices on the sale of products of each brand.
--    Write a query to display the brand name, brand type, average price of products of each brand, and total units sold of products of each brand.
--    Even if a product has been sold more than once, its price should only be included once in the calculation of the average price.
--    However, you must be careful because multiple products of the same brand can have the same price, and each of those products must be included in the calculation of the brand’s average price.

--8.  The purchasing manager is still concerned about the impact of price on sales. 
--    Write a query to display the brand name, brand type, product SKU, product description, 
--    and price of any products that are not a premium brand, but that cost more than the most expensive premium brand products.

--9.  Using SQL descriptive statistics functions calculate the value of the following items: 
--    a. What are the products that have a price greater than $50?
--    b. What is total value of our entire inventory on hand?
--    c. How many customers do we presently have and what is the total of all customer balances?
--    d. What are to top three states that buy the most product in dollars from the company?
