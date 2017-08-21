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
        user.firstName = "Manoj"
        user.lastName = "Shah"
        
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

        //        caniknowUserfromAccount()
        
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
        
        print ("\nretrieveing all users from account department which belongs to 'it'")
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
            
            // Big bunch of trial error whats inside this & what's inside that.
            // If we modify this it modifies all the department.
//            
//            print (getdata.first?.firstName)
//            print (getdata.first?.lastName)
            
//            // getdata.first?.account?.department = "Purchase"
//            getdata.first?.firstName = "Nanu"
//            getdata.first?.lastName = "Jogi"
//            getdata.first?.account?.department = "nil"
//          coreDataStack.saveContext()
            
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
//
//                    print (data.firstName)
//                    print (data.lastName)
//                    print (data.account?.department)
                
//
//                    //   data.account?.department = "IT Head"
//                    //     coreDataStack.saveContext()
            }
            
        } catch let error as NSError {
            print("Fething error : \(error), \(error.userInfo)")
        }
        
    } // end of updatedepartmentofanuser

    // @NSManaged public var users: NSOrderedSet?
    // To fetch the data from an NSORderedSet
    
    // To get an User.firstName & User.lastName from Account Entity seems to be a lot of work
    // If you have better ways just let me know. 
    
    // As of now settled with below code  for an specific department only.
    
    // If we want to know all the Users of all the Department seems like an Daunting Task!
    
    func caniknowUserfromAccount() {
        let accountrequest = NSFetchRequest<Account>(entityName: "Account")
        let predicate = NSPredicate(format: "%K CONTAINS[c] %@", #keyPath(Account.department), "purchase")
        accountrequest.predicate = predicate

        do {
            let getdata = try self.coreDataStack.managedContext.fetch(accountrequest)

            for data in getdata {
                if let departments = data.department,
                    let counter = data.users?.count { //unwrap the optional
                    print ("\(departments)")
                    print("\(counter)")
                    var mycount = 0
                    while mycount < counter {
                        if let names = data.users?[mycount] {
                            print ((names as AnyObject).firstName!!)
                            print ((names as AnyObject).lastName!!)
                            mycount += 1
                        }
                    }
//                    if let names = data.users?[0]
//                    {
//                        print ((names as AnyObject).firstName!!)
//                    }
//                    print (data.users?[0])
//                    print (data.users?[1])
                }
            } // end of for data in getdata
            
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    // ----- end of trial and error code
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

