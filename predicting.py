# Requirements: fastbook, import PIL, from PIL import Image, import requests, from io import BytesIO, import numpy,
from flask import Flask
from flask import request

import fastbook
from fastbook import *
# import fastai
import urllib
import argparse
import sys


# from fastai.vision import *
# from fastai.basic_train import load_learner

# nodejs endpoint -> communicates with python -> returns value container as a file -> nodejs sends to url


def load_model(the_path):
    from pathlib import Path

    url = "https://storage.googleapis.com/ml_model_py/export.pkl"
    urllib.request.urlretrieve(url, '/tmp/export.pkl')

    path = Path("/tmp")
    breed_classify = load_learner(path/"export.pkl")

    return breed_classify


def prediction(image_file, the_path):
    print("huh")
    import PIL
    from PIL import Image
    # import Image
    import requests
    from io import BytesIO
    import numpy

    import json
    data = {}
    print("loaded")
    breed_classify = load_model(the_path)

    url = image_file
    response = requests.get(url)
    imgg = Image.open(BytesIO(response.content))

    pix = numpy.array(imgg)

    what, _, tensor = breed_classify.predict(pix)
    if what.lower() in ['abyssinian', 'bengal', 'birman', 'bombay', 'british_shorthair', 'egyptian_mau', 'maine_coon', 'persian', 'ragdoll', 'russian_blue', 'siamese', 'sphynx']:
        data['animal'] = ['cat']

    if what.lower() in ['american_bulldog', 'american_pit_bull_terrier', 'basset_hound', 'beagle', 'boxer', 'chihuahua', 'english_cocker_spaniel', 'english_setter', 'german_shorthaired', 'great_pyrenees', 'havanese', 'japanese_chin', 'keeshond', 'leonberger', 'miniature_pinscher', 'newfoundland', 'pomeranian', 'pug', 'saint_bernard', 'samoyed', 'scottish_terrier', 'shiba_inu', 'staffordshire_bull_terrier', 'wheaten_terrier', 'yorkshire_terrier']:
        data['animal'] = ['cat']

    data['prediction'] = [what.lower()]

    with open('data.txt', 'w'):  # as outfile:
        json.dumps(data)

    return data


print("okkk")


app = Flask(__name__)


@app.route("/petify")
def index():
    img = request.args.get('img')
    img_file = "https://storage.googleapis.com/pet_image_bucket/" + img

    # img_file = "https://storage.googleapis.com/pet_image_bucket/" + img
    the_path = '.'
    print("hi")

# german_shorthair.jpg

    return prediction(img_file, the_path)


if __name__ == '__main__':
    app.run(ssl_context="adhoc", host='0.0.0.0', port=5000)
# docker run --rm --name predicting -p 5000:5000 predicting:python

# gcloud builds submit --tag gcr.io/PROJECT-ID/helloworld

# us.gcr.io/findmypet-312403/gcf
# gcloud builds submit --tag us.gcr.io/findmypet-312403/index


# gcloud builds submit --tag us.gcr.io/findmypet-312403/index
# docker build -t gcr.io/findmypet-312403/index -f Dockerfile

 # docker build -t gcr.io/$MY_PROJECT_ID/flaskapp_cr:v1 -f Dockerfile

# docker build -t gcr.io/findmypet-312403/index -f Dockerfile .
# docker push  docker build -t gcr.io/findmypet-312403/index -f Dockerfile . gcr.io/$MY_PROJECT_ID/flaskapp_cr:v1
# docker push gcr.io/findmypet-312403/index


# gcloud run deploy --image us.gcr.io/findmypet-312403/index --platform managed
