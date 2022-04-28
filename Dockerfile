FROM python:3.8

WORKDIR /usr/src/app

COPY . .

RUN pip install -e .

ENV FLASK_APP=js_example

CMD [ "flask", "run", "--host", "0.0.0.0" ]

