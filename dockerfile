FROM fastai/fastai

ARG BUILD=course

# RUN apt-get update && apt-get install -y software-properties-common rsync
# RUN add-apt-repository -y ppa:git-core/ppa && apt-get update && apt-get install -y git libglib2.0-dev graphviz && apt-get update

WORKDIR /app

RUN pip install requests
RUN pip install numpy

RUN pip install pillow  
RUN pip install fastbook


RUN pip install Flask gunicorn








COPY . . 




EXPOSE 5000
ENV PORT 5000




CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "1" ,"--threads", "8", "--timeout", "0" ,"predicting:app"]


#docker run --rm predicting:3.6  -a key


# nodejs endpoint -> communicates with python -> returns value container as a file -> nodejs sends to url

