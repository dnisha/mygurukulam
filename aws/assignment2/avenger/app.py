from flask import Flask, render_template, request
import boto3
import base64

app = Flask(__name__)
s3 = boto3.client('s3')

@app.route('/')
def index():
    return "Hello, World!"

@app.route('/image')
def serve_image():
    try:
        bucket_name = 'frontend-app-img'
        image_key = 'iron-man-ouqxo5w2b59h0042.jpeg'  # Replacing with the actual S3 object key

        # Fetching the image from S3
        response = s3.get_object(Bucket=bucket_name, Key=image_key)
        image_data = response['Body'].read()

        # Converting the image to base64 encoding
        base64_encoded_image = base64.b64encode(image_data).decode("utf-8")

        # Rendering the HTML template and pass the image data
        return render_template('index.html', myImage=base64_encoded_image)
    except Exception as e:
        return str(e), 404

if __name__ == '__main__':
    app.run(debug=True)

