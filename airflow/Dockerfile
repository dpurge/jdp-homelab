FROM apache/airflow:2.7.2

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

USER root
RUN apt update; apt install -y --no-install-recommends \
    git \
	; apt clean
	
USER airflow
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV DEBIAN_FRONTEND=dialog
