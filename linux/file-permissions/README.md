# Lab: Linux File Permissions and Access Control Audit

## Project Description
As a security professional, my primary responsibility is to audit and manage access to critical digital assets. In this lab, the research team handled sensitive data that required strict control to prevent information leaks. My goal was to update permissions in the "projects" directory to ensure the Principle of Least Privilege (PoLP).

## Phase 1: Security Audit (Reconnaissance)
The first step was to check the current state of the filesystem using the command line.

Command used:
ls -la

Results observed:
- File project_k.txt: -rw-rw-rw- (Too permissive)
- File project_m.txt: -rw-r----- 
- Hidden file .project_x.txt: -rw-w-----
- Directory drafts: drwx--x---

The -la flag was essential to see the "Long Format" (permissions and owners) and "All files" (including hidden configuration files).

## Phase 2: Permission Notation (Standard POSIX.1)
In Linux (and Kali Linux), we can manage permissions using letters (r, w, x) or numbers (Octal).

### Numeric (Octal) Values:
- Read (r) = 4
- Write (w) = 2
- Execute (x) = 1
- No Permission (-) = 0

### How to calculate:
You add the numbers for each category (User, Group, Others).
- 7 (4+2+1) = Full access (rwx)
- 6 (4+2+0) = Read and Write (rw-)
- 5 (4+0+1) = Read and Execute (r-x)
- 4 (4+0+0) = Read only (r--)

### Real-World SOC Examples:
In a Security Operations Center, we use specific numbers for hardening:
- /var/log/auth.log -> 640 (Owner can rw, Group can r, Others nothing)
- /etc/splunk/ -> 750 (Full access for owner, read/enter for group)
- /scripts/detection -> 700 (Only the owner can see and run it)

## Phase 3: Hardening Actions (Task Execution)
Based on the audit, I executed the following commands to secure the environment:

1. Restricting "Others" on project_k.txt:
Command: chmod o-w project_k.txt
(New state: -rw-rw-r--)

2. Securing the archived hidden file .project_x.txt:
Command: chmod u-w,g-w,g+r .project_x.txt
(New state: -r--r-----)

3. Protecting the drafts directory:
Command: chmod g-x drafts
(New state: drwx------)

## Summary
By using the chmod command, I successfully aligned the filesystem with the organization's security policies. Restricting write access for the "Others" category and removing execute permissions from the group on sensitive directories significantly reduces the attack surface.
