# Script Repository

This repository contains a collection of useful scripts for various purposes. Below is a list of the available scripts along with their functionality.
## Available Scripts
### 1. **Password Generator Script**
#### Description
This script generates a secure, random password and optionally saves it to a CSV file. It takes two parameters:
- **username**: The username for which the password is generated.
- **save_to_file**: A boolean (`true` or `false`) indicating whether the password should be saved to a CSV file.
#### Usage
To generate a password for a specific username and either save it or print it:

```bash
./password_generator.sh <username> <save_to_file>
```

```bash
# <username>: The username for which the password is generated.
# <save_to_file>: Either true or false. If true, the username and password will be saved to a file. If false, the password is displayed in the terminal.
```
#### Notes
Passwords are saved to ~/passwords.csv by default.
You can change the password length and file location by editing the script.

---
