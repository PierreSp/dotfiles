#!/bin/sh

# Tools for emacs
pip install --upgrade flake8 importmagic yapf epc
pip install --upgrade "jedi>=0.9.0" "json-rpc>=1.8.1" "service_factory>=0.1.5"

# General
pip install --upgrade numpy matplotlib seaborn pandas scipy tqdm jupyter ipython jupyterlab

# Machine Learning
echo "Do you want to install data science stuff?"
echo "Y/N ?:"
read answer
echo Answer: $answer
if [ "$answer" != "Y" ] || [ "$answer" != "y" ] || [ "$answer" != "Yes" ] || [ "$answer" != "yes" ]; then
  pip install --upgrade scikit-learn tensorflow tensorly keras pytorch keras-tqdm statsmodels
fi

# Machine Learning
echo "Do you want to install statistics stuff?"
echo "Y/N ?:"
read answer
echo Answer: $answer
if [ "$answer" != "Y" ] || [ "$answer" != "y" ] || [ "$answer" != "Yes" ] || [ "$answer" != "yes" ]; then
  pip install --upgrade scikit-survival statsmodels PyMC
fi
