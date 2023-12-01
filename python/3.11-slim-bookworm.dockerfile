FROM python:3.11-slim-bookworm

RUN apt update -y && \  
    apt -y install && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

RUN pip install --upgrade pip

RUN useradd -ms /bin/bash -u 1000 appuser

WORKDIR /home/appuser

USER appuser
