from easydict import EasyDict as edict

from sample_config import config, network, dataset, loss, default, generate_config


dataset.custom = edict()
dataset.custom.dataset = "custom"
dataset.custom.dataset_path = "../../dataset/faces"
dataset.custom.num_classes = 0

dataset.custom.image_shape = (112, 112, 3)
dataset.custom.val_targets = ["lfw"]
