#FROM python:3.10-buster
FROM tensorflow/tensorflow:2.10.0

COPY taxifare /taxifare

COPY requirements_prod.txt /requirements_prod.txt

COPY Makefile /Makefile

COPY setup.py /setup.python

RUN pip install --upgrade pip
RUN pip install -r requirements_prod.txt

ENV LOCAL_DATA_PATH ~/.lewagon/mlops/data
ENV LOCAL_REGISTRY_PATH ~/.lewagon/mlops/training_outputs

ENV DATASET_SIZE new
ENV VALIDATION_DATASET_SIZE=new
ENV CHUNK_SIZE=100000

ENV DATA_SOURCE=local
ENV MODEL_TARGET=mlflow
ENV PROJECT=agile-entry-365113
ENV REGION=europe-west1

ENV BUCKET_NAME=taxifare-bucket-le-wagon
ENV BLOB_LOCATION=data

ENV MULTI_REGION=EU
ENV DATASET=taxifare_dataset

ENV INSTANCE=cloud-data-train

ENV MLFLOW_TRACKING_URI=https://mlflow.lewagon.ai
ENV MLFLOW_EXPERIMENT=taxifare_experiment_mauro-vb
ENV MLFLOW_MODEL_NAME=taxifare_model_mauro-vb

ENV PREFECT_BACKEND=production
ENV PREFECT_FLOW_NAME=taxifare_lifecycle_mauro-vb
ENV PREFECT_LOG_LEVEL=WARNING

ENV IMAGE=taxifare

CMD uvicorn taxifare.api.fast:app --host 0.0.0.0 --port $PORT --reload
