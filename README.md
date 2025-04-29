# Student Management System

## Project Overview

This project is a student management system, as evidenced by the presence of  `students.db`, various report files (`reports/`), and templates related to student management (`tpl/new_student.tpl`, `tpl/update_student.tpl`, etc.).  It appears to be a web application built using Flask, leveraging Jinja2 for templating and MySQL for database interaction.  The system likely allows for adding, updating, searching, and reporting on student data.

## Features

* **Student Management:** Add, update, and delete student records.
* **Employee Management:** Add, update, and delete employee records (inferred from `new_emp.tpl` and `search_emp.tpl`).
* **Event Management:** Add and manage events (inferred from `event.tpl` and `event_s.tpl`).
* **Complaint Management:** Log and manage student complaints (inferred from `complaint.tpl` and `complaint_s.tpl`).
* **Reporting:** Generate various reports, including student, employee, event, and complaint reports.
* **Search Functionality:** Search for students and employees by name.
* **Database Integration:** Uses a MySQL database (`Dump.sql`, `libmysql.dll`).


## Installation

This project uses `pip` and `virtualenv` (detected via `myenv/` and `myvenv1/`).  Two virtual environments are present, suggesting potential separate development environments or deployments.

**Prerequisites:**

* Python 3.x
* MySQL Server

**Installation Steps:**

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   ```

2. **Create and activate the virtual environment (choose either `myenv` or `myvenv1` based on your needs):**

   For `myenv`:
   ```bash
   cd myenv
   source myenv/bin/activate  # Linux/macOS
   myenv\Scripts\activate  # Windows
   ```

   For `myvenv1`:
   ```bash
   cd myvenv1
   source myvenv1/bin/activate  # Linux/macOS
   myvenv1\Scripts\activate  # Windows
   ```

3. **Install dependencies:**  The exact dependencies will need to be determined based on the `requirements.txt` if it exists.  Otherwise, manual installation of the packages listed in the `Lib/site-packages` directory will be necessary. This will require installing `flask`, `mysql-connector-python`, `bottle`, `chardet`, `click`, `colorama`, `itsdangerous`, `jinja2`, `MarkupSafe`, `more_itertools`, `Pillow`, and `werkzeug`, at minimum.  This step may require resolving package dependencies.


## Usage

Detailed usage instructions are not provided within the directory structure.  To run the application, further investigation of the `main.py` file and associated Flask application code is necessary.  Once the dependencies are installed and the virtual environment is activated, it's likely that the application can be started with a command similar to:

```bash
python main.py
```

Further instructions will depend on the specifics of the `main.py` file.  The presence of `.tpl` files suggests that Jinja2 templating is used, and the application would likely serve web pages based on these templates.
