#!/usr/bin/expect -f

set timeout -1
set date [timestamp -format %Y%m%d%H%M]

log_file "/var/log/expect/ssh-ubuntu-$date.log"

spawn ssh klapertart@192.168.56.102

expect {
    timeout {
        exit 1
    }
    "Are you sure*" {
        send "yes\r"
        exp_continue
    }
    "*assword:" {
        send "getpass\r"

        expect "$ " 
        puts "Connected!"
        send "exit\r"
        expect eof
    }
}

log_file

