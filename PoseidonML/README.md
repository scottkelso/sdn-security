# PoseidonML
## Setup
To run a PoseidonML instance, clone the repository. Cyberreboot's one will work the best and have the best accuracy but there are two other forks with other machine learning algorithms. They can be found at the following links...

- https://github.com/scottkelso/PoseidonML.git
- https://github.com/jaiken06/PoseidonML.git

```commandline
git clone https://github.com/cyberreboot/PoseidonML.git
cd PoseidonML/
make install
```

The first thing to do to install of the dependencies is to run a Makefile command `install`.
_**Note**: This command requires pip3 to be installed. `apt-get install python3-pip`_

## Training Model
python train_OneLayer.py data/ output.pickle

## Evaluating Model
python eval_OneLayer.py data/ output.pickle
