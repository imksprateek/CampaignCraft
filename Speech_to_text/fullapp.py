from flask import Flask, request, jsonify
import boto3
from botocore.exceptions import ClientError
import time
import requests

app = Flask(__name__)

# Initialize S3, Transcribe, and Translate clients
s3 = boto3.client('s3')
transcribe = boto3.client('transcribe')
translate = boto3.client('translate')

# Specify your S3 bucket name
bucket_name = 'speech-audio'

@app.route('/transcribe', methods=['POST'])
def transcribe_audio():
    data = request.json
    audio_key = data.get('s3_uri').replace(f's3://{bucket_name}/', '')  # Extract object key from S3 URI
    job_name = f'transcription-job-{int(time.time())}'  # Unique job name using timestamp

    try:
        # Start transcription job
        response = transcribe.start_transcription_job(
            TranscriptionJobName=job_name,
            Media={'MediaFileUri': f's3://{bucket_name}/{audio_key}'},
            MediaFormat='wav',  # Change to 'mp3' if your audio is in mp3 format
            LanguageCode='hi-IN'  # Hindi language code
        )
        return jsonify({"job_name": job_name, "message": "Transcription job started"}), 200
    except ClientError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/check_job/<job_name>', methods=['GET'])
def check_job(job_name):
    try:
        response = transcribe.get_transcription_job(TranscriptionJobName=job_name)
        status = response['TranscriptionJob']['TranscriptionJobStatus']
        return jsonify({"job_name": job_name, "status": status}), 200
    except ClientError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/get_transcript/<job_name>', methods=['GET'])
def get_transcript(job_name):
    try:
        # Get the transcription job details
        response = transcribe.get_transcription_job(TranscriptionJobName=job_name)
        transcript_uri = response['TranscriptionJob']['Transcript']['TranscriptFileUri']

        # Fetch the transcript from the provided URI
        transcript_response = requests.get(transcript_uri)
        transcript_data = transcript_response.json()
        original_text = transcript_data['results']['transcripts'][0]['transcript']

        # Translate the transcribed text to English
        translated_text = translate_text(original_text, target_language='en')

        return jsonify({
            "original_text": original_text,
            "translated_text": translated_text
        }), 200

    except ClientError as e:
        return jsonify({"error": str(e)}), 500

def translate_text(text, target_language):
    try:
        # Translate text from Hindi to English
        response = translate.translate_text(
            Text=text,
            SourceLanguageCode='hi',  # Source language code for Hindi
            TargetLanguageCode=target_language  # Target language is English
        )
        return response['TranslatedText']
    except ClientError as e:
        return str(e)

if __name__ == '__main__':
    app.run(debug=True)
