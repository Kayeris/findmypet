FROM fastai/fastai

ARG BUILD=course

# RUN apt-get update && apt-get install -y software-properties-common rsync
# RUN add-apt-repository -y ppa:git-core/ppa && apt-get update && apt-get install -y git libglib2.0-dev graphviz && apt-get update

WORKDIR /app

RUN pip install requests
RUN pip install numpy

RUN pip install pillow  
RUN pip install fastbook



# #RUN /bin/bash
# RUN git clone https://github.com/fastai/fastai.git --depth 1  && git clone https://github.com/fastai/fastcore.git --depth 1
# RUN /bin/bash -c "if [[ $BUILD == 'course' ]] ; then echo \"Course Build\" && cd fastai && pip install . && cd ../fastcore && pip install . && cd .. && git clone https://github.com/fastai/fastbook --depth 1 && git clone https://github.com/fastai/course-v4 --depth 1; fi"

COPY . . 

CMD [ "python", "predicting.py" ]