FROM python:3-alpine

WORKDIR /app

COPY app.py app.py
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3000

CMD [ "app.py" ]
ENTRYPOINT [ "python" ]
