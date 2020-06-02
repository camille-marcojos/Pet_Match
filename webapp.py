from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

@webapp.route('/')
def index():
    return render_template('index.html')

@webapp.route('/counselors', methods=['POST','GET'])
#the name of this function is just a cosmetic thing
def browse_counselors():
    print("Fetching and rendering counselors web page")
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = "SELECT * from Counselors;"
        result = execute_query(db_connection, query).fetchall()
        print(result)
        return render_template('counselors.html', rows=result)
    elif request.method == 'POST':
        print("Adding an counselor")
        fname = request.form['firstName'] 
        lname = request.form['lastName'] 
        shelterID = request.form['shelterID'] 
        
        query = 'INSERT INTO Counselors (first_name, last_name, shelterID) VALUES (%s,%s,%s)'    
        data = (fname, lname, shelterID)

        db_connection = connect_to_database()
        execute_query(db_connection, query, data)
        return redirect('/counselors')
    
@webapp.route('/applications')
#the name of this function is just a cosmetic thing
def browse_applications():
    print("Fetching and rendering applications web page")
    db_connection = connect_to_database()
    query = "SELECT app_num, app_date, Adopters.first_name, Adopters.last_name, petID1, petID2, petID3 FROM Applications INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID;"
    result = execute_query(db_connection, query).fetchall()
    print(result)
    return render_template('applications.html', rows=result)

@webapp.route('/adoption_details', methods=['POST','GET'])
#the name of this function is just a cosmetic thing
def browse_adoption_details():
    db_connection = connect_to_database()
    if request.method == 'GET':
        print("Fetching and rendering adoption details web page")
        query = "SELECT AdoptionDetails.app_num, Adopters.first_name, Adopters.last_name, Applications.counselorID, Dogs.name AS Dog_Name, app_status from AdoptionDetails INNER JOIN Applications ON AdoptionDetails.app_num = Applications.app_num INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID INNER JOIN Dogs ON AdoptionDetails.petID = Dogs.petID;"
        result = execute_query(db_connection, query).fetchall()
        print(result)
        return render_template('adoption_details.html', rows=result)
    elif request.method == 'POST':
        print("Adding an adoption detail")
        appID = request.form['appID'] 
        petID = request.form['petID'] 
        appstatus = request.form['appStatus'] 
        
        query = 'INSERT INTO AdoptionDetails (app_num, petID, app_status) VALUES (%s,%s,%s)'    
        data = (appID, petID, appstatus)

        db_connection = connect_to_database()
        execute_query(db_connection, query, data)
        return redirect('/adoption_details')


@webapp.route('/add_application', methods=['POST','GET'])
def add_application():
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = 'SELECT shelterID, name from Shelters'
        shelters = execute_query(db_connection,query).fetchall()
        print(shelters)

        query = 'SELECT adopterID, adopterID from Adopters'
        adopters = execute_query(db_connection,query).fetchall()
        print(adopters)

        query = 'SELECT counselorID, counselorID from Counselors'
        counselors = execute_query(db_connection,query).fetchall()
        print(counselors)

        query = 'SELECT petID, petID from Dogs'
        pets = execute_query(db_connection,query).fetchall()
        print(counselors)
        
        return render_template('add_application.html', shelters = shelters, adopters = adopters, counselors = counselors, pets = pets)
    elif request.method == 'POST':
        print("Adding an application")
        date = request.form['appDate'] 
        adopterID = request.form['adopterID'] 
        shelterID = request.form['shelterID'] 
        counselorID = request.form['counselorID'] 
        petID1 = request.form['petID1'] 
        petID2 = request.form['petID2'] 
        petID3 = request.form['petID3'] 
        meet_greet = request.form['meetGreet'] 
        num_adults = request.form['numAdults'] 
        num_kids = request.form['numChildren'] 
        num_pets = request.form['numAnimals'] 
        home_status = request.form['homeStatus'] 
        home_type = request.form['homeType'] 

        query = 'INSERT INTO Applications (app_date, shelterID, counselorID, adopterID, petID1, petID2, petID3, meet_greet, num_adults, num_children, num_pets, home_type, home_status) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'    
        data = (date, shelterID, counselorID, adopterID, petID1, petID2, petID3, meet_greet, num_adults, num_kids, num_pets, home_type, home_status)

        db_connection = connect_to_database()
        execute_query(db_connection, query, data)
  
        return redirect('/applications')


@webapp.route('/dogs', methods=['POST', 'GET'])
#the name of this function is just a cosmetic thing
def browse_dogs():
    print("Fetching and rendering dogs web page")
    db_connection = connect_to_database()
    if request.method == 'GET':
        breeds_query = 'SELECT DISTINCT breed FROM Dogs;'
        brreds = execute_query(db_connection,query).fetchall()

        query = 'SELECT petID, Shelters.name, Dogs.name, birthday, gender, breed, size, adoption_status, energy_level, coat_type, color, dogs_ok, cats_ok, kids_ok FROM Dogs INNER JOIN Shelters ON Dogs.shelterID = Shelters.shelterID'
        result = execute_query(db_connection, query).fetchall()
        
        return render_template('dogs.html', rows=result, breeds=breeds)
    elif request.method == 'POST':
        status = request.form['dogstatus']

        if status != "any":
            query = 'SELECT petID, Shelters.name, Dogs.name, birthday, gender, breed, size, adoption_status, energy_level, coat_type, color, dogs_ok, cats_ok, kids_ok FROM Dogs INNER JOIN Shelters ON Dogs.shelterID = Shelters.shelterID WHERE adoption_status='%s''
            data = (status)
            result = execute_query(db_connection, query).fetchall()
            return render_template('dogs.html', rows=result)
        else:
            
        query = 'SELECT petID, Shelters.name, Dogs.name, birthday, gender, breed, size, adoption_status, energy_level, coat_type, color, dogs_ok, cats_ok, kids_ok FROM Dogs INNER JOIN Shelters ON Dogs.shelterID = Shelters.shelterID'
        result = execute_query(db_connection, query).fetchall()
        
        return render_template('dogs.html', rows=result, breeds=breeds)

@webapp.route('/adopters', methods=['POST','GET'])
def adopters():
    
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = "SELECT * from Adopters;"
        result = execute_query(db_connection, query).fetchall()
        print(result)

        return render_template('adopters.html', rows=result)
    elif request.method == 'POST':
        print("Add new adopter!")
        first_name = request.form['fname']
        last_name = request.form['lname']
        phone = request.form['phone']
        email = request.form['email']
        street = request.form['street']
        city = request.form['city']
        state = request.form['state']
        zipcode = request.form['zipcode']
    
        query = 'INSERT INTO Adopters (first_name, last_name, phone, email, street, city, state, zip) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)'
        data = (first_name, last_name, phone, email, street, city, state, zipcode)
        execute_query(db_connection, query, data)
        return redirect('/adopters')

@webapp.route('/update_adopter/<int:id>', methods=['POST','GET'])
def update_adopter(id):
    print('In the function')
    db_connection = connect_to_database()
    #display existing data
    if request.method == 'GET':
        print('The GET request')
        adopter_query = 'SELECT * FROM Adopters WHERE adopterID = %s'  % (id)
        adopter_result = execute_query(db_connection, adopter_query).fetchone()

        if adopter_result == None:
            return "No such person found!"

        table_query = 'SELECT * FROM Adopters'
        table_results = execute_query(db_connection, table_query).fetchall()

        print('Returning')
        return render_template('update_adopter.html', adopter = adopter_result, rows = table_results)
    elif request.method == 'POST':
        print('The POST request')
        adopterID =request.form['adopterID']
        first_name = request.form['fname']
        last_name = request.form['lname']
        phone = request.form['phone']
        email = request.form['email']
        street = request.form['street']
        city = request.form['city']
        state = request.form['state']
        zipcode = request.form['zipcode']
    
        query = 'UPDATE Adopters SET first_name=%s, last_name=%s, phone=%s, email=%s, street=%s, city=%s, state=%s, zip=%s WHERE adopterID=%s'
        data = (first_name, last_name, phone, email, street, city, state, zipcode, adopterID)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated")

        return redirect('/adopters')

@webapp.route('/delete_adopter/<int:id>')
def delete_adopter(id):
    '''deletes a dog with the given id'''
    db_connection = connect_to_database()
    query = "DELETE FROM Adopters WHERE adopterID = %s"
    data = (id,)

    result = execute_query(db_connection, query, data)
    return redirect('/adopters')


@webapp.route('/add_dog', methods=['POST','GET'])
def add_new_dog():
    
    db_connection = connect_to_database()
    if request.method == 'GET':
       
        return render_template('add_dog.html')
    elif request.method == 'POST':
        print("Add new dog!")
        shelterID = '1'
        name = request.form['dogname']
        birthday = request.form['birthday']
        breed = request.form['breed']
        gender = request.form['doggender']
        size = request.form['dogsize']
        status = request.form['dogstatus']
        energy = request.form['energy']
        coat = request.form['coat']
        color = request.form['color']
        dogsOK = request.form['dogsOK']
        catsOK = request.form['catsOK']
        kidsOK = request.form['kidsOK']
    
        query = 'INSERT INTO Dogs (shelterID, name, birthday, gender, breed, size, adoption_status, energy_level, coat_type, color, dogs_ok, cats_ok, kids_ok) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        data = (shelterID, name, birthday, gender, breed, size, status, energy, coat, color, dogsOK, catsOK, kidsOK)
        execute_query(db_connection, query, data)
        return redirect('/dogs')

@webapp.route('/update_dog/<int:id>', methods=['POST','GET'])
def update_dog(id):
    print('In the function')
    db_connection = connect_to_database()
    #display existing data
    if request.method == 'GET':
        print('The GET request')
        dog_query = 'SELECT * from Dogs WHERE petID = %s'  % (id)
        dog_result = execute_query(db_connection, dog_query).fetchone()

        if dog_result == None:
            return "No such dog found!"

        print('Returning')
        return render_template('update_dog.html', dog = dog_result)
    elif request.method == 'POST':
        print('The POST request')
        petID = request.form['petID']
        name = request.form['dogname']
        birthday = request.form['birthday']
        breed = request.form['breed']
        gender = request.form['doggender']
        size = request.form['dogsize']
        status = request.form['dogstatus']
        energy = request.form['energy']
        coat = request.form['coat']
        color = request.form['color']
        dogsOK = request.form['dogsOK']
        catsOK = request.form['catsOK']
        kidsOK = request.form['kidsOK']
    
        query = "UPDATE Dogs SET name=%s, birthday=%s, gender=%s, breed=%s, size=%s, adoption_status=%s, energy_level=%s, coat_type=%s, color=%s, dogs_ok=%s, cats_ok=%s, kids_ok=%s WHERE petID=%s"
        data = (name, birthday, gender, breed, size, status, energy, coat, color, dogsOK, catsOK, kidsOK, petID)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated")
        return redirect('/dogs')

@webapp.route('/delete_dog/<int:id>')
def delete_dog(id):
    '''deletes a dog with the given id'''
    db_connection = connect_to_database()
    query = "DELETE FROM Dogs WHERE petID = %s"
    data = (id,)

    result = execute_query(db_connection, query, data)
    return redirect('/dogs')