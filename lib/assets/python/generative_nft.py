#!/usr/bin/env python3

import base64
from io import BytesIO
import numpy as np
from PIL import Image


def human_brain_cell():
	nft = HumanCell(None, 'Brain')
	nft_array = nft.generate()

	pil_img = Image.fromarray(nft_array)
	buff = BytesIO()
	pil_img.save(buff, format="JPEG")
	b64_string = base64.b64encode(buff.getvalue()).decode("utf-8")
	print(b64_string)
	return nft, b64_string


class OpenScienceNFT:
	def __init__(self, data):
		self.data = data

	def generate(self):
		nft_array = np.zeros([100, 200, 3], dtype=np.uint8)
		nft_array[:,:100] = [255, 128, 0]
		nft_array[:,100:] = [0, 0, 255]

		self.nft_array = nft_array
		return self.nft_array

	def save(self, out_name):
		assert hasattr(self, 'nft_array')
		img = Image.fromarray(self.nft_array)
		img.save(out_name)


class HumanCell(OpenScienceNFT):
	def __init__(self, data, organ):
		super().__init__(data)
		self.organ = organ


class CElegans(OpenScienceNFT):
	def __init__(self, data, sex, stage):
		super().__init__(data)
		self.sex = sex
		self.stage = stage


if __name__ == '__main__':
	human_brain_cell()
