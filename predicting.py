# Requirements: fastbook, import PIL, from PIL import Image, import requests, from io import BytesIO, import numpy, 
import fastbook
from fastbook import *
# import fastai
# from fastai.vision import *

def load_model(the_path):
  from pathlib import Path


  path = Path(the_path)
  breed_classify = load_learner("export.pkl")


  return breed_classify

def prediction(image_file, the_path):
  import PIL
  from PIL import Image
  # import Image
  import requests
  from io import BytesIO
  import numpy

  import json
  breed_classify = load_model(the_path)

  url = image_file
  response = requests.get(url)
  imgg = Image.open(BytesIO(response.content))

  pix = numpy.array(imgg)

  what,x,tensor = breed_classify.predict(pix)

  data = {}
  data['prediction'] = [what]

  with open('data.txt', 'w'): # as outfile:
    json.dumps(data)

  return data

img_file = "https://storage.googleapis.com/pet_image_bucket/german_shorthair.jpg"

the_path = '.'

print(prediction(img_file, the_path))

