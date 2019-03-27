#! /bin/bash



echo -e "ssh_hardening_requirements, Violation, Remarks" >> ssh_report.csv

#ssh config file path

path='/etc/ssh/sshd_config'
port=$(grep Port $path  | awk '{print $2}')

#array default port

array=(1 5 7 9 11 13 17 18 19 20 21 22 23 25 37 39 42 43 49 50 53 63 67 68 69 70 71 72 73  79 80 88 95 101 102 105 107 109 110 111 113 115 117 119 123 137 138 139 143 161 162 163 164 174 177 178 179 191 194 199 201 202 204 206 209 210 213 220 347 363 369 370 372 389 427 434 435 443 444 445 464 468 487 488 496 500 535 538 546 547 554 563 565 587 610 611 612 631 636 674 694 749 750 765 767 873 992 993 994 995 512 513 514 515 517 518 519 520 521 525 526 530 531 532 533 540 543 544 548 556 1080 1236 1300 1433 1434 1494 1512 1524 1525 1645 1646 1649 1701 1718 1719 1720 1758 1759 1789 1812 1813 1911 1985 1986 1997 2049 2102 2103 2104 2401 2430 2430 2431 2431 2432 2433 2433 2600 2601 2602 2603 2604 2605 2606 2809 3130 3306 3346 4011 4321 4444 5002 5308 5999 6000 7000 7001 7002 7003 7004 7005 7006 7007 7008 7009 9876 10080 11371 11720 13720 13721 13722 13724 13782 13783 22273 26000 26208 33434 15 98 106 465 616 808 871 901 953 1127 1178 1313 1529 2003 2150 2988 3128 3455 5432 4557 4559 5232 5354 5355 5680 6010 6667 7100 7666 8008 8080 8081 9100 9359 10081 10082 10083 20011 20012 22305 22289 22321 24554 27374 60177 60179)

#To check sshruns on default port 22


if [ $port == "22" ]
then
 	#sudo sed -i 's/22/'$des_port'/g' $path
 	echo -e "Port Number, violated, Running on default port..change the port" >> ssh_report.csv

elif [[ " ${array[@]} " =~ " $port " ]]
then
 	echo -e "Port Number, violated, Running in linux defualt ports..change it" >> ssh_report.csv
else
 	echo -e "Port Number, No violation ,Running on different port" >> ssh_report.csv
fi


#To check Rootlogin Disabled

root_login=$(grep PermitRootLogin $path | awk '{print $2;exit}')

if [ $root_login == "no" ]
then
 	echo -e "Root Login, No violation, Root login disabled" >> ssh_report.csv
else
 	#sudo sed -i 's/prohibit-password/no/g;s/yes/no/g' $path
 	echo -e "Root Login, Violated, Root login is enabled..Make it disabled" >> ssh_report.csv
fi

#To check passwordAuththentication disabled
 
Pass_Auth=$(grep 'PasswordAuthentication' $path | awk '{print $2;exit}')

if [ $Pass_Auth == "no" ]
then
 	echo -e "Password Authentication, Violated, No password Authentication" >> ssh_report.csv
else
 	echo -e "Password Authentication, No Violation, password Authentication is enable" >> ssh_report.csv
fi


#To check fail2ban service installed in system 

fail=$(dpkg -l | grep 'fail2ban' | awk '{print $2;exit}')

fail="${fail:-default value}"

if [ $fail = "fail2ban" ]
then
 	echo -e "Fail2ban service, No violation, Installed" >> ssh_report.csv
else
 	echo -e "Fail2ban Service, Violated, Service not installed" >> ssh_report.csv
fi

