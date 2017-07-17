FROM ubuntu:16.04

ADD matroschka.py /opt/matroschka/matroschka.py
ADD steganohide.py /opt/matroschka/steganohide.py
ADD xtea.py /opt/matroschka/xtea.py

ENV DEBIAN_FRONTEND=noninteractive \
    MAC_PASSWORD=hmacpass \
    KEY_PASSWORD=keypass

RUN apt-get update && \
    apt-get -yq upgrade && \
    apt-get install --no-install-recommends -yq \
        python-pip \
        zlib1g libjpeg8 \
        zlib1g-dev libjpeg-dev python-dev \
        apt-utils


RUN pip install --upgrade pip

RUN pip install setuptools
RUN pip install Pillow

RUN dpkg -P zlib1g-dev libjpeg-dev python-dev apt-utils && \
    apt-get -yq autoremove

RUN python -m compileall /opt/matroschka
RUN rm -rf /opt/matroschka/*.py

ADD crypt /crypt
ADD fcrypt /fcrypt
ADD decrypt /decrypt

WORKDIR /opt/matroschka

CMD /decrypt
