FROM apache/airflow:slim-2.7.2

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

USER root
RUN apt update \
    && apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        ffmpeg \
        git \
        gpg \
        jq \
        libpq-dev \
        openssh-client \
        tzdata \
        unzip \
        wget \
        zip \
    && apt autoremove -yqq --purge \
	&& apt clean

RUN curl -sSL https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

RUN mkdir /var/{cronjob,jdpnas01} \
    && sudo chown -R airflow /var/{cronjob,jdpnas01}

USER airflow
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r /tmp/requirements.txt

ENV DEBIAN_FRONTEND=dialog
