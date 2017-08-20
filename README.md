Swift 3 to-one to-many relationship.
Wanted to understand how relationship works hence created this small code for to-on to-many swift relationship.

Created two entity Account & User

Account has department as an attribute of type string.
User has firstName & lastName as attribute of type string.

In Account entity relationship has been set to-Many 
it means an Account entity can have many users for the department attribute.
in short an department can have many users connected to it.

In User entity relationship has been set to-one.
it means User can only be connected to an single department of Account entity.

Program is straight forward.
1 First it will setup Account -> department with "IT Head"
2 Next it will create User -> firstName & lastName
3 Lastly it will fetch the data

**Fetching is performed in different ways**
- get all the users of an specific department from Account Entity
- get all the department from Account Entity
- get an department of an specific user.

**To update the department of an existing user**
Follow below steps to understand it.

Compile & run it. It will create an record in coredata with 
user.firstName = "Nanu"
user.lastName = "Jogi"
Now stop the stimulator.

Next modify user.firstName = "Vinod"
user.lastName = "Kamath"
Now run again.
Now stop the stimulator

Next modify 
  let dept = "IT Head" inside the func mysetup() to
  let dept = "Purchase"
  
Next modify user.firstName = "Manoj"
user.lastName = "Shah"
Now run again.

You'll see something like this below

retrieveing all users from account department which belongs to 'it'
User = Nanu Jogi
User = Vinod Kamath

retrieveing all department from Account entity
IT Head
Purchase

we get the department of an specific user
User = IT Head

Now what I wanted was to change the department of "Nanu" to "Purchase" but was just not able to do it.
So settled as of now with deleteing it & then recreating it with department "Purchase" 
So see this you need to do below steps.

// Create Account
add comments ---->   //    mysetup() // adds string example "IT Head" in Account Entity for department attribute
add comments----->   //    createuser() // creating an user for testing

next find myfetch() function & uncomment below one line
// trial error working
    updatedepartmentofanuser()
    
Now run the program & it will first delete the record & then will re-insert it with different department.

Question: If you know how to update it **please enlighten**

Cheers


  
  
  



