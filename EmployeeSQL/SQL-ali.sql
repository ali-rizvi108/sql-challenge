create table employees(
emp_no int not null,
birth_date date not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(1) not null,
hire_date date not null,
	primary key (emp_no)
);


create table departments(
dept_no varchar not null,
dept_name varchar not null,
	primary key (dept_no)
);


create table dept_emp(
	emp_no int not null,
	dept_no varchar not null,
	from_date date not null,
	to_date date not null,
	foreign key(emp_no) references employees(emp_no),
	foreign key(dept_no) references departments(dept_no),
	primary key (emp_no,dept_no)
	);
	
create table dept_manager(
	dept_no varchar not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key(emp_no) references employees(emp_no),
	foreign key(dept_no) references departments(dept_no),
	primary key (emp_no,dept_no)
	);
create table salaries
(
emp_no int not null,
salary int not null,
from_date date not null,
to_date date not null,
primary key (emp_no, from_date),
foreign key (emp_no) references employees(emp_no)
);

select* from salaries;	

create table titles(
emp_no int not null,
title varchar not null,
from_date date not null,
to_date date not null,
	
-----primary key (emp_no, from_date),
---foreign key (emp_no) references employees(emp_no)	
primary key (emp_no, title),
foreign key (emp_no) references employees(emp_no)
);	
	
select* from titles;
	
---List and details of each employee: employee number, last name, first name, gender, and salary.	
	
select employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
	
from employees
left join salaries on
employees.emp_no = salaries.emp_no;

---List employees who were hired in 1986.

SELECT last_name,
	first_name
FROM employees WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


----List the manager of each department with the following information: department number, department name,
---the manager's employee number, last name, first name, and start and end employment dates.
select 
departments.dept_no,
departments.dept_name,
dept_manager.emp_no,
dept_manager.from_date,
dept_manager.to_date,
employees.last_name,
employees.first_name

from departments
inner join dept_manager on
dept_manager.dept_no = departments.dept_no
inner join employees on
dept_manager.emp_no = employees.emp_no;

----List the department of each employee with the following information: employee number, last name, first name, 
----and department name.

select 
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
from departments
inner join dept_emp on
dept_emp.dept_no = departments.dept_no
inner join employees on
dept_emp.emp_no = employees.emp_no;

----List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name = 'Hercules' and last_name like 'B%';

---List all employees in the Sales department, including their employee number, last name, first name, and department name.
select departments.dept_name,
employees.emp_no,
employees.last_name,
employees.first_name
from employees 
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales';

----List all employees in the Sales and Development departments, including their employee number, 
----last name, first name, and department name.#########

select departments.dept_name,
employees.emp_no,
employees.last_name,
employees.first_name
from employees 
inner join dept_emp on employees.emp_no = dept_emp.emp_no
inner join departments on dept_emp.dept_no = departments.dept_no
where departments.dept_name = ('Sales,Developments');

-----In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "employee count"
from employees
group by last_name
order by "employee count" DESC;








