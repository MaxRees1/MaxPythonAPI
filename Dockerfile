#FROM python:3.9-alpine
#RUN mkdir /app
#ADD . /app
#COPY main.py .
#WORKDIR /app
#RUN pip install -r requirements.txt
#EXPOSE 8000
#CMD ["python", "main.py"]

FROM python:3.9.0

RUN pip install flask azure-cosmos
COPY main.py .
EXPOSE 8000
CMD ["python3", "./main.py"]