#python -m http.server 8000 --bind 127.0.0.1
from bottle import route, run, debug, template, request, static_file, error ,get,post,response,redirect
from bottle import request, redirect, response
import mysql.connector


# only needed when you run Bottle on mod_wsgi
from bottle import default_app
import datetime
import mysql.connector
import collections
from mysql.connector import errorcode
from  more_itertools import unique_everseen
#current_students

config = {
  'user': 'root',
  'password': 'Ethindhar#04',
  'host': 'localhost',
  'database': 'hms',
  'raise_on_warnings': True,
}
cnx = mysql.connector.connect(**config)


from bottle import static_file
@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static') # use static or ./static, / implies absolute path



@route('/ajax_student_added')
def ajax_student_added():
    return 'The new student was inserted into the database'


@get('/')
def just_get():
    return template('tpl/home')  # Serve the home page template when the user visits the root


@get('/index')
def index_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    

    
    

    return template('tpl/index',lolcat=request.get_cookie("user"),str="Successfully logged in as {}".format(request.get_cookie("user")))
    


@post('/register_student')
def register_student_post():
    roll_no = request.forms.get('roll_no')
    name = request.forms.get('name')
    email = request.forms.get('email')
    password = request.forms.get('password')
    year = request.forms.get('year')
    department = request.forms.get('department')

    # Hash the password
    import bcrypt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    c = cnx.cursor()
    try:
        query = """INSERT INTO registered_students 
                   (roll_no, name, email, password, year, department) 
                   VALUES (%s, %s, %s, %s, %s, %s)"""
        c.execute(query, (roll_no, name, email, hashed_password, year, department))
        cnx.commit()
    except mysql.connector.Error as err:
        return f"Error: {err}"
    finally:
        c.close()

    return "Student registered successfully!"



@post('/register_warden')
def register_warden_post():
    warden_id = request.forms.get('warden_id')
    name = request.forms.get('name')
    email = request.forms.get('email')
    password = request.forms.get('password')
    phone_number = request.forms.get('warden_phone')
    hostel_id = request.forms.get('hostel_id')

    # Hash the password
    import bcrypt
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    c = cnx.cursor()
    try:
        query = """INSERT INTO warden 
                   (warden_id, name, email, phone_number, hostel_id, password ) 
                   VALUES (%s, %s, %s, %s, %s, %s)"""
        c.execute(query, (warden_id, name, email, phone_number, hostel_id,  hashed_password))
        cnx.commit()
    except mysql.connector.Error as err:
        return f"Error: {err}"
    finally:
        c.close()

    return "Warden registered successfully!" 









@get('/logout')
def logout_get():
    response.set_cookie("user","",expires=0)
    redirect('/login')


@get('/login')
def login_get():
    return template('tpl/login')


@get('/register')
def register_get():
    return template('tpl/register')  # Make sure you have the register.tpl template file created


@post('/login')
def login_post():
    c = cnx.cursor()
    
    # Check if the roll number exists
    c.execute("SELECT 1 FROM student WHERE roll_no={} AND year!='0'".format(request.POST.get('1')))
    result = c.fetchone()
    
    c.close()
    
    # Handle cases where the roll number doesn't exist or password is incorrect
    if (result is None) and request.POST.get('1') != '0':
        return {'text': "Roll no. doesn't exist"}
    
    if request.POST.get('1') != request.POST.get('2'):
        return {'text': "Incorrect Password"}
    
    # Set the user cookie and redirect on successful login
    response.set_cookie("user", request.POST.get('1'))
    redirect('/index')





@get('/next_year')
def next_year_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    

    return template('tpl/next_year')


@post('/next_year')
def next_year_post():
    """Check to see if an uploaded file contains
    a target string 'Bobalooba'"""

    upload = request.files.get('newfile')

    # only allow upload of text files
    if upload.content_type != 'text/plain':
        return "Only text files allowed"



    output="Done ."


    c=cnx.cursor()

    for line in upload.file.readlines():
        

        query="""call fail({});""".format(line.decode())
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            output= "Failed failing  student {} in database: {} <br/>".format(line.decode(),err) + output
    

    cnx.commit()
    c.close()



    c=cnx.cursor()

    query="""call forward()"""
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed forward student in database: {}".format(err))
    cnx.commit()
    c.close()


    return output







@get('/show_students')
def show_students():
    if request.get_cookie("user") is None:
        redirect('/login')
    if request.get_cookie("user") != '0':
        return "Access denied."

    c = cnx.cursor()

    # Fetch rows
    c.execute("SELECT * FROM student")
    result = c.fetchall()

    # Get column names from cursor description
    column_names = [desc[0] for desc in c.description]

    c.close()

    # Render the template
    output = template('tpl/make_table', rows=result, columns=column_names, lolcat=request.get_cookie("user"))
    return output


@get('/show_hostel')
def show_hostel():
    # Define column names in the correct order
    column_names = ['name', 'hostel_id', 'capacity', 'no_students', 'no_rooms_available']

    c = cnx.cursor()
    
    try:
        query = """SELECT name, hostel_id, capacity, no_students, no_rooms_available 
                  FROM hostel"""
        c.execute(query)
        result = c.fetchall()
    except mysql.connector.Error as err:
        return "Failed fetching from table hostel: {}".format(err)
    finally:
        c.close()

    output = template('tpl/make_table', rows=result, columns=column_names, lolcat=request.get_cookie("user"))
    return output




@get('/update_gate_record')
def update_gate_record_get():
    if request.get_cookie("user") is None:
        redirect('/login')
    if request.get_cookie("user") != '0':
        return "Access denied."

    c = cnx.cursor()

    # Define the exact column names in the correct order
    column_names = [
        'roll_no',
        'Name',
        'dob',
        'address',
        'contact_no',
        'hostel_id',
        'branch',
        'year',
        'flat',
        'room',
        'purpose',
        'entry_time',
        'exit_time'
    ]
    c.close()

    return template('tpl/update_get_record', lolcat=request.get_cookie("user"))

@post('/update_gate_record')
def update_gate_record_post():
    # Define column names in the correct order
    column_names = [
        'roll_no',
        'Name',
        'dob',
        'address',
        'contact_no',
        'hostel_id',
        'branch',
        'year',
        'flat',
        'room',
        'purpose',
        'entry_time',
        'exit_time'
    ]

    if request.POST.get('10') == '1':
        c = cnx.cursor()

        query = """CALL gate_record_in(%s)"""
        try:
            c.execute(query, (request.POST.get('1'),))
            cnx.commit()
            
            query = """INSERT INTO gate_record(roll_no, purpose) VALUES (%s, %s)"""
            c.execute(query, (request.POST.get('1'), request.POST.get('2')))
            cnx.commit()
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return "Student doesn't exist"
            return "Failed adding gate_record in database: {}".format(err)

        # Get the latest record
        query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                  s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                  FROM student s NATURAL JOIN gate_record g 
                  WHERE s.roll_no=%s ORDER BY g.exit_time DESC LIMIT 1"""
        try:
            c.execute(query, (request.POST.get('1'),))
            result = c.fetchall()
        except mysql.connector.Error as err:
            return "Failed fetching data: {}".format(err)
        finally:
            c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif request.POST.get('10') == '2':
        c = cnx.cursor()

        query = """CALL gate_record_in(%s)"""
        try:
            c.execute(query, (request.POST.get('1'),))
            cnx.commit()
        except mysql.connector.Error as err:
            return "Failed updating entry time for gate_record in database: {}".format(err)

        # Get the latest record
        query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                  s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                  FROM student s NATURAL JOIN gate_record g 
                  WHERE s.roll_no=%s ORDER BY g.entry_time DESC, g.exit_time DESC LIMIT 1"""
        try:
            c.execute(query, (request.POST.get('1'),))
            result = c.fetchall()
        except mysql.connector.Error as err:
            return "Failed fetching data: {}".format(err)
        finally:
            c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif request.POST.get('10') == '3':
        c = cnx.cursor()

        # Prepare the query based on filters
        if request.POST.get('5') == '0' and request.POST.get('9') == '0':
            query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                      s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                      FROM current_students s NATURAL JOIN gate_record g 
                      ORDER BY s.roll_no ASC, ISNULL(g.entry_time) DESC, g.entry_time DESC"""
            params = None
        elif request.POST.get('5') == '0' and request.POST.get('9') == '1':
            query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                      s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                      FROM current_students s NATURAL JOIN gate_record g 
                      WHERE ISNULL(g.entry_time) ORDER BY s.roll_no ASC"""
            params = None
        elif request.POST.get('5') == '1' and request.POST.get('9') == '0':
            query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                      s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                      FROM student s NATURAL JOIN gate_record g 
                      WHERE s.roll_no=%s ORDER BY ISNULL(g.entry_time) DESC, g.entry_time DESC"""
            params = (request.POST.get('7'),)
        elif request.POST.get('5') == '1' and request.POST.get('9') == '1':
            query = """SELECT s.roll_no, s.Name, s.dob, s.address, s.contact_no, s.hostel_id, 
                      s.branch, s.year, s.flat, s.room, g.purpose, g.entry_time, g.exit_time 
                      FROM student s NATURAL JOIN gate_record g 
                      WHERE s.roll_no=%s AND ISNULL(g.entry_time) ORDER BY g.entry_time DESC"""
            params = (request.POST.get('7'),)

        try:
            # Execute the main query
            if params:
                c.execute(query, params)
            else:
                c.execute(query)
            result = c.fetchall()
        except mysql.connector.Error as err:
            return "Failed fetching data: {}".format(err)
        finally:
            c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output


@get('/event')
def event_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        c=cnx.cursor()
        query="""SELECT hostel_id from student where roll_no={}""".format(request.get_cookie("user"))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting hostel id  from  user: {}".format(err))

        result=c.fetchone();
        c.close()



        
        c=cnx.cursor()

        query="""SELECT * from event where start_time>now() order by field(hostel_id,{},{} ,{} ) asc ,start_time desc""".format(result[0] if result[0] else 3 ,(result[0]+1)%3 if (result[0]+1)%3 else 3,(result[0]+2)%3 if (result[0]+2)%3 else 3)
        
        



        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting custom (user) event from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='event' and table_schema='hms' ")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
        return output
        

    
    

    return template('tpl/event',lolcat=request.get_cookie("user"))




@post('/event')
def event_post():
    column_names = [
        'event_id',
        'description',
        'start_time',
        'expenditure',
        'hostel_id'
    ]

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        date_in = request.POST.get('2')  #u'2015-01-02T00:00' 
        date_out = datetime.datetime(*[int(v) for v in date_in.replace('T', '-').replace(':', '-').split('-')])



        query=""" INSERT into event(description,start_time,expenditure,hostel_id) values ('{}','{}',{},{} ) """.format(request.POST.get('1'),str(date_out),request.POST.get('3'),request.POST.get('4'))
      
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Hostel doesn't exist")
            return ("Failed adding to event in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT event_id,description,start_time,expenditure,hostel_id from event  order by event_id desc limit 1"""
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  event 1 from database: {}".format(err))
        result = c.fetchall()
       
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output



    elif(request.POST.get('10')=='2'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
         query="""Select event_id,description,start_time,expenditure,hostel_id from event order by event_id desc"""
        
        elif(request.POST.get('5')=='0'  and request.POST.get('9')=='1'):
            query="""Select event_id,description,start_time,expenditure,hostel_id from event where start_time>now() order by event_id desc"""
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='2'):
            query="""select event_id,description,start_time,expenditure,hostel_id from event where start_time<now() order by event_id desc"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""Select event_id,description,start_time,expenditure,hostel_id from event where description like '%{}%' order by event_id desc""".format(request.POST.get('1'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""Select event_id,description,start_time,expenditure,hostel_id from event WHERE description LIKE '%{}%' AND start_time>now() ORDER BY start_time DESC""".format(request.POST.get('1'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='2'):
             query="""SELECT event_id, description, start_time, expenditure, hostel_id 
                    FROM event WHERE description LIKE '%{}%' AND start_time<now() ORDER BY start_time DESC""".format(request.POST.get('1'))
        





        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed show_it from  event from database: {}".format(err))
        result = c.fetchall()
       
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output



















@get('/courier')
def courier_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):




        
        c=cnx.cursor()

        query="""SELECT * from courier where roll_no={} order by isnull(collected_date) desc,received_date desc""".format(request.get_cookie("user"))



        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting custom (user) courier from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='courier' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
        return output

    
    

    return template('tpl/courier',lolcat=request.get_cookie("user"))

@post('/courier')
def courier_post():
    # Define column names in the correct order
    column_names = [
        'courier_id',
        'roll_no',
        'description',
        'received_date',
        'collected_date'
    ]

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        query=""" INSERT into courier(roll_no,description) values ({},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Student doesn't exist")
            return ("Failed adding to courier in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                FROM courier WHERE roll_no={} ORDER BY courier_id DESC LIMIT 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from courier from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='2'):
        c=cnx.cursor()

        query=""" call courier_col({},{}) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating collected date for courier in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                FROM courier WHERE roll_no={} AND courier_id={} """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching courier from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                    FROM courier ORDER BY roll_no ASC, courier_id ASC"""
        
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='1'):
            query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                    FROM courier WHERE isnull(collected_date) ORDER BY roll_no ASC, courier_id ASC"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                    FROM courier WHERE roll_no={} ORDER BY isnull(collected_date) DESC, courier_id DESC""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""SELECT courier_id, roll_no, description, received_date, collected_date 
                    FROM courier WHERE roll_no={} AND isnull(collected_date) ORDER BY courier_id DESC""".format(request.POST.get('7'))

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from courier from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output













        
@get('/complaint')
def complaint_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        output = template('tpl/complaint_s', rolling=request.get_cookie("user"))
        return output

    return template('tpl/complaint',lolcat=request.get_cookie("user"))


@post('/complaint')
def complaint_post():
    # Define column names in the correct order
    column_names = [
        'complaint_id',
        'roll_no',
        'description',
        'registered_date',
        'resolved_date'
    ]

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        query=""" INSERT into complaint(roll_no,description) values ({},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Student doesn't exist")
            return ("Failed adding to complaint in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                FROM complaint WHERE roll_no={} ORDER BY complaint_id DESC LIMIT 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from complaint from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='2'):
        c=cnx.cursor()

        query=""" call complaint_res({},{},'{}') """.format(request.POST.get('1'),request.POST.get('2'),request.POST.get('3'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating resolved date for complaint in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                FROM complaint WHERE roll_no={} AND complaint_id={} """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching complaint from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint ORDER BY roll_no ASC, complaint_id ASC"""
        
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='1'):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint WHERE isnull(resolved_date) ORDER BY roll_no ASC, complaint_id ASC"""
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='2'):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint WHERE not isnull(resolved_date) ORDER BY roll_no ASC, complaint_id ASC"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint WHERE roll_no={} ORDER BY isnull(resolved_date) DESC, complaint_id DESC""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint WHERE roll_no={} AND isnull(resolved_date) ORDER BY complaint_id DESC""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='2'):
            query="""SELECT complaint_id, roll_no, description, registered_date, resolved_date 
                    FROM complaint WHERE roll_no={} AND not isnull(resolved_date) ORDER BY complaint_id DESC""".format(request.POST.get('7'))

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed show_it from complaint from database: {}".format(err))
        result = c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output






@get('/update_visitor')
def update_visitor_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    

    return template('tpl/update_visitor',lolcat=request.get_cookie("user"))






@post('/update_visitor')
def update_visitor_post():
    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        # Modified query to specify column order explicitly
        query="""INSERT INTO visitor(name, visitor_id, contact_no, roll_no, purpose) 
                VALUES (%s, NULL, %s, %s, %s)"""  # visitor_id is auto-increment, so we pass NULL
        
        try:
            # Pass values as tuple to prevent SQL injection and handle data type conversion
            c.execute(query, (
                request.POST.get('1'),  # name
                request.POST.get('3'),  # contact_no
                request.POST.get('2'),  # roll_no
                request.POST.get('4')   # purpose
            ))
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return "Student doesn't exist"
            return "Failed adding to visitor in database: {}".format(err)
        cnx.commit()
        c.close()

        c=cnx.cursor()

        # Modified query to specify column order
        query="""SELECT name, visitor_id, contact_no, roll_no, purpose, entry_time, exit_time 
                FROM visitor 
                WHERE roll_no=%s 
                ORDER BY entry_time DESC 
                LIMIT 1"""
        try:
            c.execute(query, (request.POST.get('2'),))
            result = c.fetchall()
            
            # Define column names in desired order
            column_names = [
                'name', 'visitor_id', 'contact_no', 'roll_no', 
                'purpose', 'entry_time', 'exit_time'
            ]
        except mysql.connector.Error as err:
            return "Failed fetching from visitor from database: {}".format(err)
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='2'):
        c=cnx.cursor()

        query=""" call visitor_out(%s, %s) """
        try:
            c.execute(query, (request.POST.get('1'), request.POST.get('2')))
        except mysql.connector.Error as err:
            return "Failed updating exit time for visitor in database: {}".format(err)
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT name, visitor_id, contact_no, roll_no, purpose, entry_time, exit_time 
                FROM visitor 
                WHERE roll_no=%s AND visitor_id=%s"""
        try:
            c.execute(query, (request.POST.get('1'), request.POST.get('2')))
            result = c.fetchall()
            column_names = [
                'name', 'visitor_id', 'contact_no', 'roll_no', 
                'purpose', 'entry_time', 'exit_time'
            ]
        except mysql.connector.Error as err:
            return "Failed fetching visitor from database: {}".format(err)
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output

    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        # Base query with desired column order
        base_query = """SELECT name, visitor_id, contact_no, roll_no, purpose, entry_time, exit_time 
                       FROM visitor"""

        if(request.POST.get('5')=='0' and request.POST.get('6')=='0' and request.POST.get('9')=='0'):
            query = base_query + " ORDER BY roll_no ASC, visitor_id ASC"
            params = None
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='0' and request.POST.get('9')=='1'):
            query = base_query + " WHERE isnull(exit_time) ORDER BY roll_no ASC, visitor_id ASC"
            params = None
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='1' and request.POST.get('9')=='0'):
            query = base_query + " WHERE name LIKE %s ORDER BY roll_no ASC, isnull(exit_time) DESC, entry_time DESC"
            params = ('%' + request.POST.get('8') + '%',)
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='1' and request.POST.get('9')=='1'):
            query = base_query + " WHERE name LIKE %s AND isnull(exit_time) ORDER BY roll_no ASC, entry_time DESC"
            params = ('%' + request.POST.get('8') + '%',)
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='0' and request.POST.get('9')=='0'):
            query = base_query + " WHERE roll_no=%s ORDER BY isnull(exit_time) DESC, entry_time DESC"
            params = (request.POST.get('7'),)
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='0' and request.POST.get('9')=='1'):
            query = base_query + " WHERE roll_no=%s AND isnull(exit_time) ORDER BY entry_time DESC"
            params = (request.POST.get('7'),)
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='1' and request.POST.get('9')=='0'):
            query = base_query + " WHERE roll_no=%s AND name LIKE %s ORDER BY isnull(exit_time) DESC, entry_time DESC"
            params = (request.POST.get('7'), '%' + request.POST.get('8') + '%')
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='1' and request.POST.get('9')=='1'):
            query = base_query + " WHERE roll_no=%s AND name LIKE %s AND isnull(exit_time) ORDER BY entry_time DESC"
            params = (request.POST.get('7'), '%' + request.POST.get('8') + '%')

        try:
            if params:
                c.execute(query, params)
            else:
                c.execute(query)
            result = c.fetchall()
            column_names = [
                'name', 'visitor_id', 'contact_no', 'roll_no', 
                'purpose', 'entry_time', 'exit_time'
            ]
        except mysql.connector.Error as err:
            return "Failed fetching from visitor from database: {}".format(err)
        c.close()

        output = template('tpl/only_table', rows=result, columns=column_names)
        return output



@get('/new_emp')
def new_emp_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/new_emp.tpl',lolcat=request.get_cookie("user"))

@post('/new_emp')
def new_emp_post():

    slist=[]
    for i in range(1,9):
        slist.append(request.POST.get('{}'.format(i)))

    c = cnx.cursor()

    query="""INSERT INTO employee (`name`, `employee_id`,`contact_no`, `dob`, `gender`, `address`,  `designation`, `hostel_id`) 
             VALUES (""" + "%s,"*7 +"%s);"

    

    try:
        c.execute(query,slist)
    except mysql.connector.Error as err:
        return ("Failed adding employee to database: {}".format(err))
    
    cnx.commit()
    c.close()
    c=cnx.cursor()

    query="""SELECT date_of_joining,salary from employee where employee_id={} """.format(slist[1])
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed querying to database: {}".format(err))

    result=c.fetchone()
    cnx.commit()
    c.close()

    return '<p>The new employee was inserted into the database, the joining date  is {} and salary is {} </p>'.format(result[0],result[1])




















@get('/new_student')
def new_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/new_student.tpl')

@post('/new_student')
def new_post():

    slist=[]
    for i in range(1,9):
        slist.append(request.POST.get('{}'.format(i)))
    
    # s1 = request.POST.get('1')
    # s2 = request.POST.get('2')
    # s3 = request.POST.get('3')
    # s4 = request.POST.get('4')
    # s5 = request.POST.get('5')
    # s6 = request.POST.get('6')
    # s7 = request.POST.get('7')
    # s8 = request.POST.get('8')
    # s9 = request.POST.get('9')
    # s10 = request.POST.get('10')
    # s11 = request.POST.get('11')

    c = cnx.cursor()

    query="""INSERT INTO `hms`.`student` (`name`, `roll_no`, `dob`, `gender`, `address`, `contact_no`, `year`, `branch`) 
             VALUES (""" + "%s,"*7 +"%s);"

    

    try:
        c.execute(query,slist)
    except mysql.connector.Error as err:
        if err.errno==1062:
            return ("Student roll no. already exists")
        return ("Failed adding student to database: {}".format(err))
    
    cnx.commit()
    c.close()
    c=cnx.cursor()

    query="""SELECT hostel_id,flat,room from student where roll_no={} """.format(slist[1])
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed querying to database: {}".format(err))

    result=c.fetchone()
    cnx.commit()
    c.close()

    return '<p>The new student was inserted into the database, the alloted room is {} {} {}</p>'.format(result[0],result[1],result[2])









@get('/update_student')
def update_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/update_student.tpl')

@post('/update_student')
def update_post():
    c=cnx.cursor()

    query=""" UPDATE `student` SET name='{}',contact_no={},address='{}',branch='{}' WHERE `roll_no`={};""".format(request.POST.get('11'),request.POST.get('2'),request.POST.get('3'),request.POST.get('4'),request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed updating student in database: {}".format(err))
    cnx.commit()
    c.close()

    c=cnx.cursor()

    query="""SELECT * from student where roll_no={} """.format(request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed fetching from  student from database: {}".format(err))
    result = c.fetchall()
    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()
    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    
    return output
    

    


@post('/update_student_form')
def update_student_form():
    roll_no=request.POST.get('1')



    output = template('tpl/update_student_form', roll=roll_no)
    return output


@get('/search_emp')
def search_emp_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/search_emp.tpl',lolcat=request.get_cookie("user"))


@post('/namesearch_emp')
def namesearch_emp():
    c=cnx.cursor()

    query=""" SELECT * from employee where name like '%{}%' """.format(request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    result=c.fetchall()

    column_names=[desc[0] for desc in c.description]

    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    return output


@post('/idsearch_emp')
def idsearch_emp():
    c = cnx.cursor()

    # Get the employee_id from the request
    employee_id = request.POST.get('1')

    # Create the query to select the employee by their ID using parameterized query to avoid SQL injection
    query = """SELECT * FROM employee WHERE employee_id = %s"""
    
    try:
        c.execute(query, (employee_id,))  # Pass employee_id as a parameter to the query
    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    # Fetch the query result
    result = c.fetchall()

    # Fetch the column names directly from the result's description
    column_names = [desc[0] for desc in c.description]

    c.close()

    # Render the template with the fetched data
    output = template('tpl/only_table', rows=result, columns=column_names)
    return output




@post('/hd_emp')
def hd_emp():
    c = cnx.cursor()

    # Get user inputs
    hostel_id = request.POST.get('1')
    designation = request.POST.get('2')

    # Build query based on input values
    if hostel_id == '0' and designation == '0':
        query = """ SELECT * from employee order by employee_id asc"""
    elif hostel_id != '0' and designation == '0':
        query = """ SELECT * from employee where hostel_id = %s order by employee_id asc"""
    elif hostel_id != '0' and designation != '0':
        query = """ SELECT * from employee where hostel_id = %s and designation = %s order by employee_id asc"""
    elif hostel_id == '0' and designation != '0':
        query = """ SELECT * from employee where designation = %s order by employee_id asc"""

    try:
        # Execute the query with the appropriate parameters
        if hostel_id != '0' and designation != '0':
            c.execute(query, (hostel_id, designation))
        elif hostel_id != '0':
            c.execute(query, (hostel_id,))
        elif designation != '0':
            c.execute(query, (designation,))
        else:
            c.execute(query)

    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    # Fetch the query result
    result = c.fetchall()

    # Fetch the column names directly from the result's description
    column_names = [desc[0] for desc in c.description]

    c.close()

    # Render the template with the fetched data
    output = template('tpl/only_table', rows=result, columns=column_names)
    return output










@get('/search_student')
def search_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
 


    return template('tpl/search_student.tpl',lolcat=request.get_cookie("user"))

@post('/namesearch_student')
def namesearch_student():
    selector = '*'

    if request.get_cookie("user") != '0':
        selector = 'name, roll_no, year, branch, hostel_id, flat, room'

    c = cnx.cursor()

    query = """ SELECT {} from current_students where name like '%{}%' """.format(selector, request.POST.get('1'))
    
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result = c.fetchall()

    # Get column names from the cursor's description attribute
    column_names = [desc[0] for desc in c.description]

    c.close()

    if request.get_cookie("user") != '0':
        column_names = ['name', 'roll_no', 'year', 'branch', 'hostel_id', 'flat', 'room']

    output = template('tpl/namesearch_student', rows=result, columns=column_names)
    return output



@post('/rollsearch_student')
def rollsearch_student():
    selector='*'

    if(request.get_cookie("user")!='0'):
        selector='name,roll_no,year,branch,hostel_id,flat,room'


    c=cnx.cursor()

    query=""" SELECT {} from student where roll_no={} """.format(selector,request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result=c.fetchall()

    
    column_names=[desc[0]for desc in c.description]

    c.close()
    if(request.get_cookie("user")!='0'):
        column_names=[['name'],['roll_no'],['year'],['branch'],['hostel_id'],['flat'],['room']]

    output = template('tpl/namesearch_student', rows=result,columns=column_names)
    return output
@post('/roomsearch_student')
def roomsearch_student():
    selector = '*'

    if request.get_cookie("user") != '0':
        selector = 'name, roll_no, year, branch, hostel_id, flat, room'

    c = cnx.cursor()

    hostel_id = request.POST.get('1')
    flat = request.POST.get('2')
    room = request.POST.get('3')

    # If all three are '0', select all records
    if hostel_id == '0' and flat == '0' and room == '0':
        query = """ SELECT {} from current_students """.format(selector)

    # Search by Hostel ID only
    elif hostel_id != '0' and flat == '0' and room == '0':
        query = """ SELECT {} from current_students where hostel_id={} """.format(selector, hostel_id)

    # Search by Hostel ID and Flat only
    elif hostel_id != '0' and flat != '0' and room == '0':
        query = """ SELECT {} from current_students where hostel_id={} and flat={} """.format(selector, hostel_id, flat)

    # Search by Hostel ID and Room only
    elif hostel_id != '0' and flat == '0' and room != '0':
        query = """ SELECT {} from current_students where hostel_id={} and room='{}' """.format(selector, hostel_id, room)

    # Search by Flat only
    elif hostel_id == '0' and flat != '0' and room == '0':
        query = """ SELECT {} from current_students where flat={} """.format(selector, flat)

    # Search by Flat and Room only
    elif hostel_id == '0' and flat != '0' and room != '0':
        query = """ SELECT {} from current_students where flat={} and room='{}' """.format(selector, flat, room)

    # Search by Room only
    elif hostel_id == '0' and flat == '0' and room != '0':
        query = """ SELECT {} from current_students where room='{}' """.format(selector, room)

    # Search by Hostel ID, Flat, and Room
    elif hostel_id != '0' and flat != '0' and room != '0':
        query = """ SELECT {} from current_students where hostel_id={} and flat={} and room='{}' """.format(selector, hostel_id, flat, room)

    else:
        return "Invalid choice."

    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result = c.fetchall()

    column_names = [desc[0] for desc in c.description]

    c.close()

    if request.get_cookie("user") != '0':
        column_names = [['name'], ['roll_no'], ['year'], ['branch'], ['hostel_id'], ['flat'], ['room']]

    output = template('tpl/namesearch_student', rows=result, columns=column_names)
    return output

    


@error(403)
def mistake403(code):
    return 'There is a mistake in your url!'


@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'


debug(True)
run(reloader=True)
# remember to remove reloader=True and debug(True) when you move your
# application from development to a productive environment