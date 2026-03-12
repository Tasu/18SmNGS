# ref Blank flask docker https://qiita.com/free-honda/items/6273289e813eabcbd9d9
# deprecated
# tested with x86_64 and aarch64
# use pixi image for ubuntu 20
FROM ghcr.io/prefix-dev/pixi:0.61.0-focal
# set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# shell selection for jupyter kernel install
SHELL ["/bin/bash", "-c"]

# directory for application
WORKDIR /app

# packages install with apt (openssh-server for SSH access)
RUN apt-get update && apt-get install -y openssh-server && rm -rf /var/lib/apt/lists/*

# software install with pixi (command line tools only)
RUN pixi global install -c bioconda -c conda-forge seqkit==2.12.0
RUN pixi global install -c bioconda -c conda-forge porechop==0.2.4

# python module install, python3.9 and python modules, using /app as a workspace.
RUN pixi init
RUN pixi workspace channel add bioconda
RUN pixi add python==3.9
# RUN pixi add Flask==2.3.2 # flask app interface is deprecated.
# for the compatibility with linux-aarch64 platform.
# RUN pixi add edlib==1.3.9
RUN pixi add python-edlib==1.3.9
RUN pixi add biopython==1.85
RUN pixi add matplotlib==3.9.1
# Jupyter Notebook 6.x for compatibility
# RUN pixi add notebook==6.5.4
RUN pixi workspace channel add conda-forge
RUN pixi add jupyterlab==4.4.6
RUN pixi add bash_kernel==0.10.0 --pypi

#install bash kernel for jupyter

RUN pixi run python -m bash_kernel.install

# deprecated env variables for Flask app
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0

# SSH settings (change if needed.)
ENV SSH_USER=sshuser
ENV SSH_PASSWORD=sshuser

# Flask internal on 5000. Jupyter internal on 8555. SSH on 22.
# EXPOSE 5000
#port for jupyter notebook
EXPOSE 8555
#port for ssh/sftp
EXPOSE 22 

# RUN mkdir -p /app/files
COPY . .

# entrypoint script for starting up jupyter server / ssh server
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
