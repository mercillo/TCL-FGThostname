#!
proc get_sys_status aname {
upvar $aname a
set input [exec "get system status | grep Hostname\n" "# " 15 ]
puts $input
set linelist [split $input \n]
puts $linelist

foreach line $linelist {
if {![regexp {([^:]+):(.*)} $line dummy key value]} continue
switch -regexp -- $key {
Hostname {
set a(hostname) [string trim $value]
} }
}
puts "**"
puts $a(hostname)
}




proc change_ddns {object} {
puts "Starting ChangeDDNS Proc"
puts "config system ddns\n"
puts "edit 1\n"
puts "set ddns.$object.securedretail.com\n"
puts "end\n"
}


get_sys_status status
puts "Global variable of status hostname"
puts $status(hostname)
set result [regexp -all -inline {\d} $status(hostname)]
puts $result
regsub -all {\s} $result {} output
puts $output
change_ddns $output
