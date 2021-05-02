# Requirements: fastbook, import PIL, from PIL import Image, import requests, from io import BytesIO, import numpy, 
import fastbook
from fastbook import *
# import fastai
import urllib
# from fastai.vision import * 
# from fastai.basic_train import load_learner

def load_model(the_path):
  from pathlib import Path

  url = "https://storage.googleapis.com/ml_model_py/export.pkl"
  urllib.request.urlretrieve(url, '/tmp/export.pkl')


  path = Path("/tmp")
  breed_classify = load_learner(path/"export.pkl")


  return breed_classify

def prediction(image_file, the_path):
  import PIL
  from PIL import Image
  # import Image
  import requests
  from io import BytesIO
  import numpy

  import json
  data = {}
  breed_classify = load_model(the_path)

  url = image_file
  response = requests.get(url)
  imgg = Image.open(BytesIO(response.content))

  pix = numpy.array(imgg)

  what,_,tensor = breed_classify.predict(pix)
  if what.lower() in ['abyssinian', 'bengal', 'birman', 'bombay', 'british_shorthair', 'egyptian_mau', 'maine_coon', 'persian', 'ragdoll', 'russian_blue', 'siamese', 'sphynx']:
    data['animal'] = ['cat']
  
  if what.lower() in ['american_bulldog', 'american_pit_bull_terrier', 'basset_hound', 'beagle', 'boxer', 'chihuahua', 'english_cocker_spaniel', 'english_setter', 'german_shorthaired', 'great_pyrenees', 'havanese', 'japanese_chin', 'keeshond', 'leonberger', 'miniature_pinscher', 'newfoundland', 'pomeranian', 'pug', 'saint_bernard', 'samoyed', 'scottish_terrier', 'shiba_inu', 'staffordshire_bull_terrier', 'wheaten_terrier', 'yorkshire_terrier']:
    data['animal'] = ['cat']
  
  data['prediction'] = [what.lower()]


  with open('data.txt', 'w'): # as outfile:
    json.dumps(data)

  return data

img_file = "https://storage.googleapis.com/pet_image_bucket/german_shorthair.jpg"

the_path = '.'

print(prediction(img_file, the_path))


