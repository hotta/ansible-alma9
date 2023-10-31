# Postgresql support

You  have nothing to do with postgresql. The following description is just a memo.

## Create python development environment using postgresql

```
# Install Postgresql server
$ cd ansible-alma9
$ ansible-playbook jobs/postgresql.yml
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

## postgresql-15 changes breaking compatibility

From postgresql-15, PUBLIC creation permission on the public shcema was removed due to CVE-2018-1058. By default, only the owner of the database can create objects on schema public.

The following commands work around this limitation.

```
DBNAME=# grant create on schema public to public;
```

