"""
Python 3 script for generating crytographically secure
config files for the docker application.
"""

import os
import string
import secrets


def generate_secure_password(pass_length):
    """Generate cryptographically secure password"""

    generator = secrets.SystemRandom()

    string_src = string.ascii_letters + string.digits
    password = ""

    for x in range(0, pass_length):
        password += generator.choice(string_src)

    return password
 

def verify_files(docker_folder):

    app_file = os.path.join(docker_folder, ".env.app.conf")
    db_file = os.path.join(docker_folder, ".env.db.conf")

    if not os.path.isfile(app_file):
        raise FileNotFoundError(f"Config file {app_file} not generated.")

    if not os.path.isfile(db_file):
        raise FileNotFoundError(f"Config file {db_file} not generated.")


def write_db_config(db_file, secure_pass)
    f = open(db_file, "w")
    pass_block = f"MYSQL_ROOT_PASSWORD={secure_pass}"

    f.write(pass_block)
    f.close()


def write_app_config(app_file, secure_pass):

    f = open(app_file, "w")
    pass_block = f"MYSQL_ROOT_PASSWORD={secure_pass}"

    f.write(pass_block)

    main_block = """RECAPTCHA_SITE_KEY=
RECAPTCHA_SECRET_KEY=
SENDGRID_USERNAME=
SENDGRID_PASSWORD=
BASE_URL=localhost:3000
SECRET_KEY_BASE=
SECRET_TOKEN=
S3_REGION=us-east-1
S3_PROTOCOL=
S3_HOST_NAME=
S3_ACCESS_KEY_ID=
S3_SECRET_ACCESS_KEY=
S3_PRIVATE_BUCKET=
"""

    f.write(main_block)
    f.close()


def main():

    docker_folder = "./docker"

    if not os.path.isdir(docker_folder):
        raise FileNotFoundError("""docker subdirectory not found
            This script must be run from the repository folder.""")

    pass_length = 30
    secure_pass = generate_secure_password(pass_length)

    app_file = os.path.join(docker_folder, ".env.app.conf")
    db_file = os.path.join(docker_folder, ".env.db.conf")

    write_app_config(app_file, secure_pass)
    write_db_config(db_file, secure_pass)

    print("The secure MySQL root password for this docker instance is:")
    print(secure_pass)
    print('\n')
    print("The config files have been generated with this pass. Copypaste this password somewhere secure.")


main()