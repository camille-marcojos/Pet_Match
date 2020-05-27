@webapp.route('/dogs')
def browse_dogs():
    print("Fetching and rendering dogs web page")
    db_connection = connect_to_database()
    query = "SELECT * from Dogs;"
    result = execute_query(db_connection, query).fetchall()
    print(result)
    return render_template('dogs.html', rows=result)

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





