FROM python:3.7.4


# --------------- Install python packages using `pip` ---------------



# https://github.com/joyzoursky/docker-python-chromedriver/blob/master/py3/py3.6-xvfb-selenium/Dockerfile
RUN apt-get update 
# install selenium
RUN apt-get install -y python3-software-properties
RUN apt-get install -y software-properties-common
RUN apt-get -y install apt-transport-https ca-certificates
RUN apt-get -y install apt-transport-https curl
RUN apt-get -y install wget curl
RUN apt-get install -y firefox-esr
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
    && apt-get clean

RUN apt-get install --fix-missing
RUN pip install nltk
RUN pip install selenium==3.8.0
RUN pip install --upgrade pip
# set dbus env to avoid hanging
ENV DISPLAY=:99
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null
#RUN pip install --upgrade selenium

##
# Programatic Firefox driver that can bind with selenium/gecko.
##
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-linux64.tar.gz
RUN tar -xvzf geckodriver-v0.23.0-linux64.tar.gz
RUN sh -c 'tar -x geckodriver -zf geckodriver-v0.23.0-linux64.tar.gz -O > /usr/bin/geckodriver'
RUN chmod +x /usr/bin/geckodriver
RUN rm geckodriver-v0.23.0-linux64.tar.gz

RUN cp geckodriver /usr/local/bin/
ENV PATH /usr/bin/geckodriver:$PATH
RUN pip install pyvirtualdisplay
# A lot of academic text is still in PDF, so better get some tools to deal with that.
#RUN sudo /opt/conda/bin/pip install git+https://github.com/pdfminer/pdfminer.six.git

ENV MOZ_HEADLESS = 1
RUN python - c "from selenium import webdriver;\
from selenium.webdriver.firefox.options import Options; \
options = Options(); \
options.headless = True; \
driver = webdriver.Firefox(options=options) ;\
driver.get('http://google.com/') ;\
print('Headless Firefox Initialized') ;\
driver.quit();"

RUN apt-get update
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN conda --version
RUN conda update --yes conda
RUN conda install --yes gcc_linux-64

ADD . .
ADD requirements.txt ./

# Copy local code to the container image.
ENV APP_HOME /app

WORKDIR $APP_HOME
COPY . ./

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt \
	&& rm -rf requirements.txt
RUN pip install --upgrade streamlit
# --------------- Configure Streamlit ---------------
RUN mkdir -p /root/.streamlit

RUN bash -c 'echo -e "\
	[server]\n\
	enableCORS = false\n\
	" > /root/.streamlit/config.toml'

EXPOSE 8501


# --------------- Export envirennement variable ---------------
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD ["streamlit", "run", "--server.port", "8080", "main.py"]
