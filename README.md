# Simple ootcl

Example of very simple way to have Object Oriented TCL. I don't think this can be used in real projects but can be good learning example.
When you source the ootcl.tcl file it gives you following procedures:

1. **class** - used to define your new class, takes 2 arguments the name of the class and the body. To can also have inheritance between classes.

   Example:
   ```
   class A {
      variable a
      proc get_a {} {
         variable a
         return $a
      }
   }
   ### Define another class 'B', which extends from 'A' and have only proc 'b'
   class B extends: A {
      proc print_b {} {
         puts BBBB
      }
   }
   
   ```

2. **new** - allows you to create new object of the class

   Example:
   ```
   new a A()
   new b B()
   # will return the value of variable $a
   a::get_a 
   # will print message 'BBBB'
   b::print_b
   ```
   
3. **delete** - removes the object of the class
   
   Example:
   ```
   # remove the object a
   delete a
   ```
   
   
   



