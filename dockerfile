FROM python:3.6-stretch

WORKDIR /app

RUN pip install requests
RUN pip install numpy

RUN pip install -Uqq fastbook
RUN pip install Pillow  



COPY . .

CMD [ "python", "predicting.py" ]