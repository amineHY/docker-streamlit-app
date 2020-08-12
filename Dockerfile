FROM python:3.7.4
# FROM python:3.6.9

LABEL maintainer "Amine Hadj-Youcef  <hadjyoucef.amine@gmail.com>"
# If you have any comment : LinkedIn - https://www.linkedin.com/in/aminehy/

# Copy local code to the container image.
ENV APP_HOME /app

WORKDIR $APP_HOME
COPY . ./

# --------------- Install python packages using `pip` ---------------

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
EXPOSE 8080

# --------------- Export envirennement variable ---------------
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD ["streamlit", "run", "--server.port", "8080", "main.py"]
