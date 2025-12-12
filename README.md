_This project has been created as part of the 42 curriculum by juliatav_

## Description

Born2BeRoot is a system administration project that introduces Virtual Machines and a series of key system-related concepts, such as virtualisation, disk partitioning, LVM, service configuration, automated monitoring, and firewall management — all through setting a secure virtual environment.

---
## Instructions

* This project does not require compilation. 
* To use the system here configured, start the virtual machine using VirtualBox and unlock the disk. Now you should be able to connect to the server via SSH using:
	`ssh -p 4242 <login>@localhost`
* To view sudo logs, check:
	`/var/log/sudo/`
* The monitoring script runs automatically every 10 minutes through cron, and once at server startup, it can also be manually executed with:
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

For this project, it is required to install and configure a secure Linux server following strict specifications.
I opted to work with **Debian** since it's a stable and reliable OS with extensive documentation, whose setup process is simpler and more beginner-friendly than Rocky's.

The system was set up using encrypted LVM partitioning to improve security and organisation. A strong password policy was enforced as requested by the subject, as well as strict sudo configuration with logging and UFW was used to manage port access.

User management includes the root account as well as a user that belongs to _user42_ and _sudo_ groups. SSH was installed as requested, running only on port **4242**. A monitoring script with the system's information will be displayed at startup and every 10 minutes.

* **Debian vs. Rocky Linux:** Rocky Linux has a more complex system setup (mainly due to SELinux and firewalld), it provides strong security, but demands more knowledge from the user.

* **AppArmor vs. SELinux:** AppArmor is a path-based system, making it easier to learn and to configure. SELinux uses label-based controls, which, as previously mentioned, are harder to configure.

* **UFW vs. firewalld:** Firewalld is a dynamic, zone-based firewall manager; it has more features and it's more flexible than UFW, it's a more powerful tool than UFW, but it's also more challenging for beginners. UFW, on the other hand, is simpler and more user-friendly with its straightforward syntax, making it ideal for beginners and minimal setups.

* **VirtualBox vs. UTM:** UTM is a lightweight alternative to VirtualBox; it's simpler and has fewer features, while VirtualBox is more complex and offers broad compatibility. It may be slower or less efficient in many cases.
