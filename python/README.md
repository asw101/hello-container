# python

clone repo
```
git clone https://github.com/Microsoft/python-sample-vscode-flask-tutorial
```

docker run
```
cd python-sample-vscode-flask-tutorial/
docker run --rm -v $(pwd):/pwd/ -w /pwd/ -p 8080:5000 -it python bash
pip install -r requirements.txt
export FLASK_APP=startup.py
flask run --host=0.0.0.0
# open http://localhost:8080
```

docker build
```
docker build -t hello-python python-sample-vscode-flask-tutorial/
docker run --rm -p 8080:5000 -it hello-python
```
