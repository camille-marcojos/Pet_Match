-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the dogmatch database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-------- QUERIES FOR COUNSELORS --------
-- get all Counselor IDs and Names and Shelter ID to populate the Counselors page
SELECT * from Counselors;

-- add a new counselor
INSERT INTO Counselors (first_name, last_name, shelterID) VALUES (:fnameInput, :lnameInput, 01);

-- update a counselor's data based on submission of the Update counselor form 
UPDATE Counselors SET first_name = :fnameInput, last_name= :lnameInput WHERE counselorID= :counselorID_from_the_update_form;

-- delete a counselor
DELETE FROM Counselors WHERE counselorID = :counselor_ID_selected_from_view_counselors_page;


-------- QUERIES FOR APPLICATIONS --------
-- get all submitted applications for Application page
SELECT app_num, app_date, Adopters.first_name, Adopters.last_name, petID1, petID2, petID3 FROM Applications 
	INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID;

-- delete an application
DELETE FROM Applications WHERE app_num = :app_num_selected_from_view_applications_page;

-- add a new application
INSERT INTO Applications (date, adopterID, shelterID, counselorID, petID1, petID2, petID3, meet_greet, num_adults, num_kids, num_pets, home_status, home_type) 
VALUES (:dateInput, :adopterIDInput, :sheltIDinput, :counselorIDinput, :petID1input, :petID2input, :petID3input, :meet_greetInput, :num_adultsInput, :num_kidsInput, :num_petsInput, :home_statusInput, :home_typeInput);

-- get a single application's data based on the search application form
SELECT app_num, app_date, Adopters.first_name, Adopters.last_name, petID1, petID2, petID3 FROM Applications 
	INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID
	WHERE app_num = :app_numInput_from_applications_page
	OR Adopters.first_name = :fnameInput_from_applications_page
	OR Adopters.last_name = :lnameInput_from_applications_page


-------- QUERIES FOR ADOPTION DETAILS --------
-- get all applications that have dog info and show status
SELECT AdoptionDetails.app_num, Adopters.first_name, Adopters.last_name, Applications.counselorID, Dogs.name AS Dog_Name, app_status from AdoptionDetails
    INNER JOIN Applications ON AdoptionDetails.app_num = Applications.app_num
    INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID
    INNER JOIN Dogs ON AdoptionDetails.petID = Dogs.petID;

-- get adoption details for a single application based on the search forms
SELECT AdoptionDetails.app_num, Adopters.first_name, Adopters.last_name, Applications.counselorID, Dogs.name AS Dog_Name, app_status from AdoptionDetails
    INNER JOIN Applications ON AdoptionDetails.app_num = Applications.app_num
    INNER JOIN Adopters ON Applications.adopterID = Adopters.adopterID
    INNER JOIN Dogs ON AdoptionDetails.petID = Dogs.petID
    INNER JOIN Counselors ON Applications.counselorID = Counselors.counselorID
    WHERE AdoptionDetails.app_num= :app_numInput_from_adoption_details_search_form
    OR AdoptionDetails.petID= :petID_Input_from_adoption_details_search_form
    OR app_status =:app_status_from_dropdown_Input
    OR Adopters.first_name = :adopter_fnameInput_from_adoption_details_search_form
	OR Adopters.last_name = :adopter_lnameInput_from_adoption_details_search_form
	OR Applications.counselorId = :counselorIDinput
	OR Counselors.first_name = :counselor_fnameInput_from_adoption_details_search_form
	OR Counselors.last_name = :counselor_lnameInput_from_adoption_details_search_form;

-- update an application status on the adoption details page based on submission of the Update adoption status dropdown
UPDATE AdoptionDetails SET app_status = :app_statusInput WHERE app_num= :app_num_from_the_update_form;


-- associate an application with a dog (M-to-M relationship addition)
INSERT INTO AdoptionDetails (app_num, petID, app_status) VALUES (:app_num_from_Input, :petID_from_Input, :app_status_from_dropdown_Input);

-- dis-associate a dog from an application (M-to-M relationship deletion)
DELETE FROM AdoptionDetails WHERE app_num = :app_num_selected_from_list AND petID = :petID_selected_from_list;

----------------- QUERIES FOR DOGS -----------------
--to do: calculate age from birthday (to be able to display and filter by)
--display table on Dogs page
SELECT petID, name, birthday, breed, size, color, adoption_status FROM Dogs;
--filter by breed
SELECT petID, name, birthday, breed, size, color, adoption_status FROM Dogs
WHERE breed = :breedSelectInput;
--filter by birthday/age
--filter by gender
SELECT petID, name, birthday, breed, size, color, adoption_status FROM Dogs
WHERE gender = :genderSelectInput;
--filter by size
SELECT petID, name, birthday, breed, size, color, adoption_status FROM Dogs
WHERE size = :sizeSelectInput;
--filter by status
SELECT petID, name, birthday, breed, size, color, adoption_status FROM Dogs
WHERE adoption_status = :adoption_statusSelectInput;
--display all dog details (visible when view button is clicked)
SELECT * FROM Dogs WHERE petID = :petIDInput;
--search for dogs
SELECT * FROM Dogs WHERE name LIKE %:searchInput%;

----------------- QUERIES FOR ADOPTERS -----------------
--display adopters table
SELECT * FROM Adopters;
--search for adopters
SELECT * FROM Adopters WHERE first_name LIKE %:searchInput%
 OR last_name LIKE %:searchInput%
 OR phone LIKE %:searchInput%
 OR email LIKE %:searchInput%
 OR street LIKE %:searchInput%
 OR city LIKE %:searchInput%
 OR state LIKE %:searchInput%
 OR zip LIKE %:searchInput%;
