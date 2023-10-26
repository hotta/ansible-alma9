# Postgresql support

## Create development environment using postgresql

```
# Install Postgresql server
$ cd ansible-alma8
ansible-playbook jobs/postgresql.yml
# Install pyenv and python-3.9.16
$ cd
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
$ . ~/.bash_profile
$ pyenv install 3.9.16
$ pyenv local 3.9.16
```

## An example code to connect to postgresql

```
# Install python venv
$ python3 -m venv venv
$ . ./venv/bin/activate
$ pip install psycopg2
# Create and run a program
$ cat > pg_example.py <<EOS
import os
import psycopg2

# dsn = postgresql://{username}:{password}@{hostname}:{port}/{database}
def get_connection():
    dsn = 'postgresql:///vagrant'
    return psycopg2.connect(dsn)

conn = get_connection()
cur = conn.cursor()
cur.execute('SELECT * FROM users')
cur.close()
conn.close()
EOS
python pg_example.py
```

No error means the connection is sucessfull.