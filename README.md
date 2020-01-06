
![Docker Automated build](https://img.shields.io/docker/automated/aminehy/docker-streamlit-app)
![Docker Pulls](https://img.shields.io/docker/pulls/aminehy/docker-streamlit-app)

# Description
This repository contains a docker image that allows running streamlit web application. It can be used to test the application and/or deploy to a cloud service like Google Cloud, Heroku, Amazon AWS
 
# Build docker image
You can build this docker image from a dockerfile using this command
```
docker build -t aminehy/docker-streamlit-app:latest .
```

# Run the docker container
Simply enter the following command to run your application
```
docker run -ti --rm aminehy/docker-streamlit-app:latest streamlit run main.py
```

Or you can mount your folder in the container to directly run the application script (`main.py`)
```
docker run -ti --rm -v $(pwd):/app aminehy/docker-streamlit-app:latest
```

Or you can just access the terminal and start playing around
```
docker run -ti --rm -v $(pwd):/app aminehy/deploy_streamlit_app:latest bash
```




