//
//  ViewController.swift
//  to-one-to-many
//
//  Created by Nanu Jogi on 18/08/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    var myclass = MyClass()
    
    var currentdept:Account!
    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdocu = myclass.getDocumentsDirectory()
        print ("\(pdocu)")
        
        // Create Account
        
        //        mysetup() // adds string example "IT Head" in Account Entity for department attribute
        //       createuser() // creating an user for testing
        
        myfetch()   // lets fetch that data which we added.
        
    }
    
    func mysetup() {
        let dept = "IT Head"
        let deptfetch: NSFetchRequest<Account> = Account.createFetchRequest()
        deptfetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Account.department), dept)
        do {
            let results = try coreDataStack.managedContext.fetch(deptfetch)
            if results.count > 0 {
                // department already inside Account entity.
                currentdept = results.first
                print (currentdept)
            } else {
                // add new department
                currentdept = Account(context: coreDataStack.managedContext)
                currentdept.department = dept
                coreDataStack.saveContext()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    } // end of mysetup
    
    func createuser() {
        
        // Create User
        user = User(context: coreDataStack.managedContext)
        
        // Configure User
        user.firstName = "Nanu"
        user.lastName = "Jogi"
        
        // Important: We have to insert the new user to Account entity.
        currentdept?.addToUsers(user) // OR below way it is one and the same.
        
        // user.account = account   // this way it is result is identical.
        
        // Save the managed object context
        coreDataStack.saveContext()
        
    } // end of createuser
    
    func myfetch () {
        
        // will get all the users of an specific department from Account Entity
        getalluserfromaccountdepartment()
        
        // will get all the department from Account Entity
        getalldepartmentofaccountentity()
        
        // will get an department of an specific user.
        getdepartementofanuser()
        
        // This will update an department of an user.
        //        updatedepartmentofanuser()
        
        // Getting an User from Account seems like an Daunthing task.
        // It works but tooo much of codes. just uncomment below line
        
        caniknowUserfromAccount()
        
    } // end of myfetch
    
    func getdepartementofanuser() {
        
        print ("\nwe get the department of an specific user")
        let fetchuser = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(User.firstName), "nanu")
        fetchuser.predicate = predicate
        do {
            
            // retrieves an department of an user
            let getdata = try self.coreDataStack.managedContext.fetch(fetchuser)
            
            for data in getdata {
                
                // let us unwrap the optionals
                if let unwrap_account_department = data.account?.department {
                    print ("User = \(unwrap_account_department)")
                }
            } // end of for data in getdata
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    } // end of getdepartementofanuser
    
    func getalldepartmentofaccountentity() {
        
        print ("\nretrieveing all department from Account entity")
        
        // retrieve all department from Account entity
        let accountrequest = NSFetchRequest<Account>(entityName: "Account")
        
        do {
            let getdata = try self.coreDataStack.managedContext.fetch(accountrequest)
            
            for data in getdata {
                if let departments = data.department { //unwrap the optional
                    print ("\(departments)")
                }
            } // end of for data in getdata
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
    } // end of getdapartmentofanuser
    
    func getalluserfromaccountdepartment() {
        
        print ("\nretrieveing all users from account department which belongs to 'it' via User Entity")
        let userrequest = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(User.account.department), "it")
        userrequest.predicate = predicate
        do {
            
            // retrieves all user from an Account entity department attribute
            let getdata = try self.coreDataStack.managedContext.fetch(userrequest)
            
            for data in getdata {
                // let us unwrap the optional
                if let unwrapfirstName = data.firstName,
                    let unwraplastName = data.lastName {
                    print ("User = \(unwrapfirstName) \(unwraplastName)")
                }
                
            } // end of for data in getdata
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
    } // getalluserfromaccountdepartment
    
    // Was trying to change the relationship of an user from existing to a new one in Account entity already like "Purchase" but was not able to find an solution.
    
    // So settled with delete it & then recreated the User with different department
    
    func updatedepartmentofanuser() {
        let fetchdepartment = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(User.firstName), "nanu")
        fetchdepartment.predicate = predicate
        
        do {
            let getdata = try coreDataStack.managedContext.fetch(fetchdepartment)
            
            for data in getdata {
                // Could not modify the existing user to an new department. so first deleteting it & then adding it back with different department.
                
                coreDataStack.managedContext.delete(data)
                coreDataStack.saveContext()
                
                // Create User
                user = User(context: coreDataStack.managedContext)
                
                // Configure User
                user.firstName = "Nanu"
                user.lastName = "Jogi"
                
                mysetup() // here we change the department that we want.
                
                // Important: We have to insert the new user to Account entity.
                currentdept?.addToUsers(user) // IMPORTANT STEP
                
                // Save the managed object context
                coreDataStack.saveContext()
                
            }
            
        } catch let error as NSError {
            print("Fething error : \(error), \(error.userInfo)")
        }
        
    } // end of updatedepartmentofanuser
    
    /*
     Note: Easier approach for this is function already written above in ---> getalluserfromaccountdepartment()
     Wanted to reach same thing via Account Entity & learnt to write below code.
     
     @NSManaged public var users: NSOrderedSet?
     To fetch the data from an NSORderedSet
     
     Now we have all the Users from Account Entity their first name & lastname.
     */
    
    func caniknowUserfromAccount() {
        print ("\nretrieveing all users from entity Account attribute department")
        let accountrequest = NSFetchRequest<Account>(entityName: "Account")
        let predicate1 = NSPredicate(format: "%K != nil", #keyPath(Account.department))
        accountrequest.predicate = predicate1
        //      let predicate2 = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(Account.users), "nanu")
        //      let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1])
        //      let predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(Account.department), "it")
        
        do {
            // fetch it
            let getdata = try self.coreDataStack.managedContext.fetch(accountrequest)
            for data in getdata {
                //    print (data)
                if let departments = data.department,
                    let counter = data.users?.count { // Get the number of records in User entity for this particular department.
                    print ("\ndepartment = \(departments)")
                    //     print("\(counter)")
                    
                    // here we loop to get different firstName & lastName of the department.
                    var mycount = 0
                    while mycount < counter {
                        
                        // Just another try to get unwrapped names from User
//                        let mytry = data.users?[mycount] as? AnyObject
//                        if let getunwrappedfirstname = mytry?.firstName,
//                            let getunwrappedlastname = mytry?.lastName {
//                            print (getunwrappedfirstname!)
//                            print (getunwrappedlastname!)
//                            
//                        }
                        
                        if let names = data.users?[mycount] {
                            if let usrfirst = (names as AnyObject).firstName?!, // unwrap the optionals
                                let usrlast = (names as AnyObject).lastName?! { // unwrap the optionals
                                print ("User = \(usrfirst) \(usrlast)")
                            }
                            // print ((names as AnyObject).firstName!!)
                            // print ((names as AnyObject).lastName!!)
                            mycount += 1
                        }
                    } // end of while loop
                    
                }
            } // end of for data in getdata
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    } // end of caniknowUserfromAccount
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


/*
 
 
 Swift 3 - OR
 let predicate1 = NSPredicate(format: "X == 1")
 let predicate2 = NSPredicate(format: "Y == 2")
 let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])
 
 Swift 3 - AND
 
 let predicate1 = NSPredicate(format: "X == 1")
 let predicate2 = NSPredicate(format: "Y == 2")
 let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
 
 */
