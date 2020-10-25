
# TensorFlow


https://www.tensorflow.org/install/

## Install TensorFlow:  Use Virtualenv   (check the docker install later)


```
pip install --upgrade virtualenv
virtualenv --system-site-packages -p python3 venv 
cd venv
source ./bin/activate
pip install --upgrade tensorflow
pip install --upgrade pandas
pip install --upgrade matplotlib
```

```
git clone https://github.com/tensorflow/models.git
```

data/ — Will have records and csv files.
images/ — This directory will contain our dataset.
training/ — In this directory we will save our trained model.
eval/ — Will save results of evaluation on trained model.


## LabelImg

```
git clone https://github.com/tzutalin/labelImg.git
virtualenv -p python3 labelImg
cd labelImg
source ./bin/activate
pip install PyQt5
pip install lxml
python labelImg.py
```



### troubleshooting

*add matplotlibrc*
```
backend: TkAgg
```

*supported hardward instruction*
https://github.com/lakshayg/tensorflow-build




## Object Detection (models)

https://github.com/tensorflow/models
https://github.com/tensorflow/models/tree/master/research/object_detection

### Installation 
https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md

#### protobuf compiler

For mac, need to make it

```
brew install autoconf 
brew install automake
brew install libtool
```

##### Get it
https://github.com/google/protobuf

Download appropriat release
https://github.com/google/protobuf/releases

```
tar -xvzf protobuf-python-3.5.1.tar.gz
cd protobuf-3.5.1/
./autogen.sh
./configure
make
make check
sudo make install
which protoc
protoc --version
```

#### Others
```
sudo pip install Cython
sudo pip install pillow
sudo pip install lxml
sudo pip install jupyter
sudo pip install matplotlib
```

Follow the guide for the rest

```
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
make
cp -r pycocotools <path_to_tensorflow>/models/research/

protoc object_detection/protos/*.proto --python_out=.

export PYTHONPATH=$PYTHONPATH:~/projects/tensorflow/models/research:~/projects/tensorflow/models/research/slim
```



## OpenCV

### Mac Install

*Install dependencies for opencv*

```
$ brew install cmake pkg-config
$ brew install jpeg libpng libtiff openexr
$ brew install eigen tbb
```

```
$ pip install numpy
```

*Clone opencv*

```
$ cd ~/projects
$ git clone https://github.com/opencv/opencv
$ git clone https://github.com/opencv/opencv_contrib
```

*Configure Build*

```
$ mkdir build
$ cd build
$ cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/projects/opencv_contrib/modules \
    -D PYTHON3_LIBRARY=/usr/local/Cellar/python/3.6.5/Frameworks/Python.framework/Versions/3.6/lib/python3.6/config-3.6m-darwin/ \
    -D PYTHON3_INCLUDE_DIR=/usr/local/Cellar/python/3.6.5/Frameworks/Python.framework/Versions/3.6/include/python3.6m/ \
    -D PYTHON3_EXECUTABLE=$VIRTUAL_ENV/bin/python \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=ON ..
```

*Make*

`-j4` is to optimize four cores, depends on the environment

```
$ make -j4
```

```
sudo make install
```


