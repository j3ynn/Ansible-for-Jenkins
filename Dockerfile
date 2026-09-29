FROM python:3.12-slim

RUN pip install --no-cache-dir ansible

RUN pip install --no-cache-dir kubernetes 

RUN ansible-galaxy collection install kubernetes.core

WORKDIR /ansible

COPY . /ansible