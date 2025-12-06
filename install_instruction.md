# amplicon_sorter install
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
6. copy amplicon_sorter.py to anywhere you want to put
cp ~/download/github/amplicon_sorter/amplicon_sorter.py /workspaces/codespaces-jupyter/bin/

7. use amplicon_sorter
```bash
conda activate amplicon_sorter
#python <location of amplicon_sorter.py> options
python /workspaces/codespaces-jupyter/bin/amplicon_sorter.py -v
```
