#!/bin/bash

# define color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

. /etc/profile
module purge
module load anaconda3/2022.10

conda config --add channels conda-forge
conda config --remove channels default

set -e

echo -e "$BLUE Set up $RED$1$BLUE conda environment. $NC"

exit 0
conda env create -n $1 python=3.7
conda activate $1

echo -e "$BLUE Install Dependencies. $NC"
conda install -n $1 pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia --yes

pip install h5py==3.3.0
pip install opencv_python==4.5.3.56
pip install pandas==1.3.1
pip install pyproj==3.2.1
pip install pyquaternion==0.9.9
pip install scikit-learn==1.0.2
pip install scipy==1.7.1
pip install trajnetplusplustools==0.3.0
pip install tensorboard

# Set up dataset
echo -e "$BLUD Install nuScenes devkit. $NC"
mkdir third_parties
cd third_parties
git submodule add https://github.com/nutonomy/nuscenes-devkit.git

pip install nuscenes-devkit

# echo -e "$BLUD Install nuScenes devkit. $NC"
# git submodule add https://github.com/argoverse/argoverse-api.git
# pip install -e argoverse-api


