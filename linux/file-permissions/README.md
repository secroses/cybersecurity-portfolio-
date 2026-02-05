# Linux File Permissions Management

## Project Description
This project demonstrates how Linux file and directory permissions are reviewed
and modified to enforce proper authorization and reduce security risks.

Using a Kali Linux virtual machine, I analyzed existing permissions and applied
changes to ensure that only authorized users had the appropriate level of access.
This scenario reflects real-world security tasks commonly performed by system
administrators and cybersecurity analysts.

---

## Checking File and Directory Permissions

To inspect file and directory permissions, including hidden files, I used the
following command:

```bash
ls -la
This command displays detailed information such as permission settings, file
ownership, and visibility. It is essential for identifying misconfigured access
controls in a Linux environment.

Understanding the Permissions String
Linux permissions are represented by a 10-character string.

Example:

-rw-rw-r--
Explanation:

The first character indicates the file type:

- = regular file

d = directory

Characters 2–4 represent user (owner) permissions

Characters 5–7 represent group permissions

Characters 8–10 represent other permissions

Permission values:

r = read

w = write

x = execute

- = no permission

Understanding this structure is critical for detecting unauthorized access and
applying least-privilege principles.

Modifying File Permissions
The organization’s security policy does not allow write access for group or other
users on regular files.

To remove unauthorized write permissions, I used the chmod command:

chmod 644 project_k.txt
This configuration ensures:

User: read and write access

Group: read-only access

Others: read-only access

This reduces the risk of accidental or malicious file modification.

Modifying Permissions on a Hidden File
The hidden file .project_x.txt is archived and should not be writable by any user.
However, both the user and group must retain read access.

Command used:

chmod 440 .project_x.txt
This ensures:

User: read-only

Group: read-only

Others: no access

Hidden files often contain sensitive data, so restricting write access is a
security best practice.

Modifying Directory Permissions
All files and directories in the projects directory are owned by the user.
Only the owner should be able to access the drafts directory and its contents.

Command used:

chmod 700 drafts
This configuration grants full access to the owner while completely restricting
group and other users.

Summary
In this project, I reviewed and enforced Linux file and directory permissions to
align with security and authorization requirements. By using commands such as
ls -la and chmod, I identified misconfigurations and applied least-privilege
access controls, reducing the risk of unauthorized access in a Linux system.
