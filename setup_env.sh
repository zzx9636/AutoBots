#!/bin/bash

# define color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ENV_NAME=${1:-Autobots}    

. /etc/profile
module purge
module load anaconda3/2022.10

conda config --add channels conda-forge
conda config --add channels default
conda config --set channel_priority flexible

set -e
echo -e "$BLUE Set up $RED$ENV_NAME$BLUE conda environment. $NC"

conda create --name $ENV_NAME python=3.7 pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia --yes
conda activate $ENV_NAME

echo -e "$BLUE Install Dependencies. $NC"
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
mkdir -p third_parties
cd third_parties
if [ ! -d "nuscenes-devkit" ] 
then
    git submodule add https://github.com/nutonomy/nuscenes-devkit.git
fi
pip install nuscenes-devkit

# echo -e "$BLUD Install nuScenes devkit. $NC"
# git submodule add https://github.com/argoverse/argoverse-api.git
# pip install -e argoverse-api

echo -e "$BLUE Test Environment. $NC"
cd ..
python test_env.py

echo -e "$GREEN Finished!\n To activate this environment, use: \n$RED$ conda activate test $NC"

