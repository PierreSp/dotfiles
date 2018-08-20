#!/bin/bash

# Greeting and input
read -p "What is the name of your project?: " name
echo "$name"
# Create folder structure
mkdir "$name"
mkdir $name/$name
mkdir $name/$name/tests
mkdir $name/doc
mkdir $name/$name/examples
mkdir $name/$name/py_module


# Generate inits
touch $name/$name/__init__.py
touch $name/$name/py_module/__init__.py
#echo "from markdown import markdown" >> $name/$name/__init__.py

touch $name/$name/tests/__init__.py

# Create setup.py
echo "from setuptools import setup


setup(name='$name',
      version='0.1',
      description='TBF',
      classifiers=[
        'Development Status :: 3 - Alpha',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.6',
      author='Pierre Springer',
      author_email='pierre.springer@tum.de',
      license='MIT',
      test_suite='nose.collector',
      tests_require=['nose', 'nose-cover3'],
      entry_points={
          'console_scripts': ['funniest-joke=funniest.command_line:main'],
      },
      include_package_data=True,
      zip_safe=False)
      " >> $name/setup.py


# Changes, manifest, readme,...
echo "v<version>, <date> -- Initial release." >> $name/CHANGES.txt

echo "include *.txt
recursive-include docs *.txt" >> MANIFEST.in

echo "
===========
$name
===========

Example Readme:

A Section
=========

Lists look like this:

* First

* Second. Can be multiple lines
  but must be indented properly.

A Sub-Section
-------------

Numbered lists look like you'd expect:

1. hi there

2. must be going

Urls are http://like.this and links can be
written `like this <http://www.example.com/foo/bar>`_."


