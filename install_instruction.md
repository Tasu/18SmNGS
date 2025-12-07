# Instructions for installing required tools.
- please follow the developer's instruction basically.

### minibar install https://github.com/calacademy-research/minibar
0. please finish installing conda (miniconda3)
 - please make sure that conda init is done.
 - please make sure you have (base) for shell prompt.
```bash
###### only one time
conda init #if not executed yet
. ~/.bashrc #if not executed yet
######
conda info -e
```

1. create conda environemnt for minibar
```bash
conda create -y -n minibar python=2.7
```

2. activate minibar env, locating minibar env bin directory 
```bash
#activating "minibar" env
conda activate minibar
#please check the conda environment is (minibar)
conda info -e
#please check the pip in the environment is for this environment
which pip
which python
python --version
PYTHONPATH=`which python`
CONDAENVBINDIR=${PYTHONPATH%python}
echo $CONDAENVBINDIR
```

3. install dependency using pip in minibar env
```bash
#check if pip install your library to minibar env only.
pip show pip
pip install edlib
#make sure edlib is installed in minibar env
pip show edlib | grep Location
```

4. get minibar.py from github repostiroy
```bash
mkdir -p ~/download/github
cd ~/download/github
git clone https://github.com/calacademy-research/minibar.git
```

5. test the installation
```bash
conda activate minibar
python ~/download/github/minibar/minibar.py -v
```
6. copy minibar.py to minibar env bin directory, modify a permission of minibar.py for execution.
```bash
cp ~/download/github/minibar/minibar.py ${CONDAENVBINDIR}
chmod +x  ${CONDAENVBINDIR}/minibar.py
```

7. usage, test
```bash
conda activate minibar
minibar.py -v
minibar.py -h
```


### amplicon_sorter install https://github.com/avierstr/amplicon_sorter
0. please finish installing conda (miniconda3)
 - please make sure that conda init is done.
 - please make sure you have (base) for shell prompt.
```bash
###### only one time
conda init #if not executed yet
. ~/.bashrc #if not executed yet
######
conda info -e
```

1. create conda environemnt for amplicon_sorter
```bash
conda create -y -n amplicon_sorter python=3.9
```

2. activate amplicon_sorter
```bash
#activating "amplicon_sorter" env
conda activate amplicon_sorter
#please check the conda environment is (amplicon_sorter)
conda info -e
#please check the pip in the environment is for this environment
which pip
which python
python --version
```

3. install dependency using pip
- https://github.com/avierstr/amplicon_sorter
```bash
#check if pip install your library to amplicon_sorter env only.
pip show pip
pip install edlib
pip install biopython matplotlib
```

4. get amplicon_sorter.py from github repostiroy
```bash
mkdir -p ~/download/github
cd ~/download/github
git clone https://github.com/avierstr/amplicon_sorter.git
```
5. test the installation
```bash
python3 ~/download/github/amplicon_sorter/amplicon_sorter.py -h
```

#optional
6. copy amplicon_sorter.py to conda amplicon_sorter env and make it executable
```bash
#amplicon_sorter use windows style line endings preventing the unix system to execute from shebang
conda activate amplicon_sorter
PYTHONPATH=`which python`
CONDAENVPATH=${PYTHONPATH%python}
cp ~/download/github/amplicon_sorter/amplicon_sorter.py ${CONDAENVPATH}
#fix windows line ending style to unix system
sed -i 's/\r$//' ${CONDAENVPATH}/amplicon_sorter.py
chmod +x ${CONDAENVPATH}/amplicon_sorter.py
amplicon_sorter.py -h
```

7. usage of amplicon_sorter
```bash
conda activate amplicon_sorter
python <location of amplicon_sorter.py> options
```
