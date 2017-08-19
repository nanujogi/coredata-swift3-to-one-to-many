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

TODO: to update the department of an existing user.

