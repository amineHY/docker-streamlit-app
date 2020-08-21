
![Docker Automated build](https://img.shields.io/docker/automated/aminehy/docker-streamlit-app)
![Docker Pulls](https://img.shields.io/docker/pulls/aminehy/docker-streamlit-app)

# Description
This repository contains a docker image that allows running streamlit web application. It can be used to test the application and/or deploy to a cloud service like Google Cloud, Heroku, Amazon AWS
 

# Run the docker container
Simply enter the following command to run your application
```
docker run -ti --rm aminehy/docker-streamlit-app:latest
```

**Local development**
 - Mount your working folder in the container 
  ```
  docker run -ti --rm -v $(pwd):/app aminehy/docker-streamlit-app:latest
  ```

 - If your main file name is different to  `main.py` (e.g. `app.py`)
 ```
 docker run -ti --rm -v $(pwd):/app aminehy/docker-streamlit-app:latest streamlit run name_main_file.py
 ```

- To access the docker container in the bash mode
```
docker run -ti --rm -p 8080 aminehy/deploy_streamlit_app:latest bash
```
Two addresses will come up, only the top URL is functional.

# Build docker image
You can build this docker image from a dockerfile using this command
```
docker build -t aminehy/docker-streamlit-app:latest .
```





