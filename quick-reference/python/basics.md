### Creating a venv

The second argument is the location to create the virtual environment.
Generally, you can just create this in your project and call it env.
And, you should .gitignore it.

```bash
python3 -m venv env
```

### Activate virtual env

Before you can start installing or using packages in your virtual environment
you’ll need to activate it. Activating a virtual environment will put the
virtual environment-specific python and pip executables into your shell’s PATH.

```bash
source env/bin/activate
which python
```

### Install dependencies 

```bash
pip install requests
pip install requests==2.18.4
pip install requests>=2.0.0,<3.0.0
pip install --pre requests     # pre-release
pip install requests[security] # some packages have option extras
```

### Deactivate

```bash
# when you switch projects
deactivate
```

