from airflow import DAG
from airflow.decorators import task
from airflow.operators.bash import BashOperator

from datetime import datetime

with DAG("youtube",
    start_date=datetime(2023, 11, 5), 
    schedule="@daily",
    catchup=False):

    download = BashOperator(
        task_id="youtube_download",
        bash_command="/opt/airflow/scripts/youtube-download")

    publish = BashOperator(
        task_id="youtube_publish",
        bash_command="echo 'Publish YouTube clips'")
    
    download >> publish
