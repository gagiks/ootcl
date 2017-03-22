#-------------------------------------------------------------------------------
# Name  	: Object Oriented TCL
# Author	: Gagik Sukiasyan <gagiks@synopsys.com>
# Description	:
# 	Capability of writing object oriented code in TCL
# 
# Example	:
# 	### Define a class named 'A', which have proc 'a'
# 	class A {
# 		variable a
# 		proc a {} {
# 			puts aaa
# 		}
# 	} 
# 	### Define another class 'B', which extends from 'A' and have only proc 'b'
# 	class B extends: A {
# 		proc b {} {
# 			puts BBBB
# 		}
# 	}
# 	### Take one object of 'A' and one of 'B'
# 	new a A()
# 	new b B()
# 	### This will print 'aaa' as 'a' proc of 'A' objec is called
	# a::a
# 	### This also will print 'aaa' as 'a' proc of parent class is called
# 	b::a


package provide ootcl 1

proc class {name args} {
	
	set tmp "upvar #0 CLASS_$name cls"
	eval $tmp
	set body {}
	if {[lindex $args 0] == "extends:"} {
		set parent [lindex $args 1]
		set tmp "upvar CLASS_$parent parent_cls"
		eval $tmp
		if [info exists parent_cls] {
			lappend body $parent_cls(body)
		}
		lappend body [lindex $args 2]
	} else {
		lappend body [lindex $args 0]
	}
	
	set cls(name)  $name
	set cls(body)  [join $body "\n"]
	
	return
}

proc new {name title args} {
	
	set title [concat $title $args]
	
	set tmp [split $title "("]
	set class [lindex $tmp 0]
	set tmp [join [lrange $tmp 1 end] "("]
	set tmp [split $tmp ")"]
	set arg [join [lrange $tmp 0 end-1] ")"]
	
	set tmp "upvar #0 CLASS_$class cls"
	eval $tmp
	set cmd "namespace eval $name {\n $cls(body) \n  if { \"\[info commands $class\]\" != \"\" } {$class $arg} \n }"
	
	uplevel #0 "$cmd"

	return
}

proc delete {name} {

	if {[info commands ${name}::destroy ] != ""} {
		uplevel #0 "${name}::destroy"
# 		return
	}
	catch {uplevel #0 "namespace delete $name"}
	
}


