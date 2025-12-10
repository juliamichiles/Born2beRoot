- should have the 42 header?
- in the line bellow should it be my user or full 42 email? I think full email
- should 'Description' and 'Project Description' be the same section? I don't think so

_This project has been created as part of the 42 curriculum by juliatav_

## Description

Born2BeRoot is a system administration project that introduces Virtual Machines and a series of key system-related concepts, such as virtualization, disk partitioning, LVM, service configuration, automated monitoring, and firewall management — all through setting a secure virtual environment.

---
## Instructions

* This project does not require compilation. 
* To use the system here configured, start the virtual machine using VirtualBox and unlock the disk, now you should be able to connect to the server via SSH using:
	`ssh -p 4242 <login>@localhost`
* To view sudo logs, check:
	`/var/log/sudo/`
* The monitoring script runs automatically every 10 minutes through cron and once at server startup, it can also be maually executed with:
	`bash monitoring.sh`
---

## Resources

This project was done using the following references:

* Debian Documentation — https://www.debian.org/doc/
* UFW — https://wiki.ubuntu.com/UncomplicatedFirewall
* VirtualBox Manual — https://www.virtualbox.org/manual/
* _What is AppArmor?_ — https://www.youtube.com/watch?v=KYM-Dzivnjs
* _What is a Server?_ — https://www.geeksforgeeks.org/computer-networks/what-is-server/ 
* B2BR Guide — https://github.com/Vikingu-del/Born2beRoot/tree/main

**Man pages consulted:** awk, grep, sudo, passwd, adduser, ufw, systemctl, uname, df, top, who, lsblk, users, hostname, ip, journalctl

**AI usage:** AI was used to clarify some concepts, assist in reading official documentation, structure summary notes, and format this README. All configuration, commands, and system setup were performed manually.

---
## Project description
- this section must also explain the choice of operating system (Debian or Rocky), with their respective pros and cons.
- It must indicate the main design choices made during the setup (partitioning, security policies, user management, services installed) as well as a comparison between:
	-  Debian vs Rocky Linux
	-  AppArmor vs SELinux
	-  UFW vs firewalld
	-  VirtualBox vs UTM
