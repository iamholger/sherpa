# 
FROM andrewosh/binder-base
MAINTAINER Holger Schulz <iamholger@gmail.com>
USER root
RUN apt-get update
RUN pip install fileupload
RUN jupyter nbextension install --py fileupload
RUN jupyter nbextension enable --py fileupload
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN apt-get install libsqlite3-dev swig -y && apt-get clean
RUN mkdir /code && cd /code && \
    wget http://www.hepforge.org/archive/sherpa/SHERPA-MC-2.2.1.tar.gz && \
    tar xzf SHERPA-MC-2.2.1.tar.gz && cd SHERPA-MC-2.2.1 && ./configure --prefix=/usr/local --enable-ufo --enable-pyext && make install -j 8 && cd / && rm -rf /code
ENV LD_LIBRARY_PATH /usr/local/lib
ENV PYTHONPATH /usr/local/lib/python2.7/site-packages
