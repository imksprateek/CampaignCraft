import base64
import boto3,json
import os
from flask import Flask, request, jsonify, Response, redirect, send_file
from botocore.exceptions import ClientError
import uuid

app = Flask(__name__)
BUCKET = "hecker-bucket"

@app.route('/generate', methods=['GET'])
def generate_image():
    query_dict = request.args.to_dict(flat=False)

    prompt = query_dict.get('prompt', [None])[0]
    
    client = boto3.client("bedrock-runtime", region_name="us-east-1")

    model_id = "anthropic.claude-v2"

    user_message = f"You are a prompt engineer. Design a prompt for Image generation AI for the following requirement. Make sure you don't include any sensitive words that the image AI might not generate. You are generating a background image with no text. You should only have the prompt in your response: {prompt}"
    conversation = [
        {
            "role": "user",
            "content": [{"text": user_message}],
        }
    ]

    try:
        response = client.converse(
            modelId="anthropic.claude-v2",
            messages=conversation,
            inferenceConfig={"maxTokens":2400,"stopSequences":["\n\nHuman:"],"temperature":1,"topP":1},
            additionalModelRequestFields={"top_k":250}
        )

        response_text = response["output"]["message"]["content"][0]["text"]
        print(response_text)

    except (ClientError, Exception) as e:
        print(f"ERROR: Can't invoke '{model_id}'. Reason: {e}")
        return jsonify({'error': 'Error in generating prompt from Text model', 'reason':f'Model id: {model_id}, {e}'})
    
    
    client = boto3.client("bedrock-runtime", region_name="us-east-1")
    
    model_id = "stability.stable-diffusion-xl-v1"

    native_request = {"text_prompts":[{"text":f"{response_text}","weight":1}],"cfg_scale":10,"steps":50,"seed":0,"width":1024,"height":1024,"samples":1}

    model_request = json.dumps(native_request)

    response = client.invoke_model(modelId=model_id, body=model_request)

    model_response = json.loads(response["body"].read())

    base64_image_data = model_response["artifacts"][0]["base64"]
    s3 = boto3.resource('s3')
    filename = str(uuid.uuid4())
    s3.Object(BUCKET, filename).put(Body=base64.b64decode(base64_image_data))

    s3_client = boto3.client('s3')
    paginator = s3_client.get_paginator('list_objects_v2')
    pages = paginator.paginate(Bucket=BUCKET)

    image_urls = []
    for page in pages:
        if 'Contents' in page:
            for obj in page['Contents']:
                key = obj['Key']
                image_url = f"https://s3.amazonaws.com/{BUCKET}/{key}"
                image_urls.append(image_url) 
    
    return jsonify({'current': f"https://s3.amazonaws.com/{BUCKET}/{filename}", 'images': image_urls})


@app.route('/speech', methods=['get'])
def detect_speech():
    query_dict = request.args.to_dict(flat=False)

    prompt = query_dict.get('prompt', [None])[0]

if __name__ == '__main__':
	app.run(debug = True)
