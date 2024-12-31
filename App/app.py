from flask import Flask, jsonify, request
import boto3
from botocore.exceptions import NoCredentialsError, ClientError

app = Flask(__name__)

# Initialize the S3 client using boto3
s3 = boto3.client('s3')

# Define the bucket name (you can pass this as an environment variable or parameter)
BUCKET_NAME = 'mys32772'

@app.route('/list-bucket-content', defaults={'path': ''})
@app.route('/list-bucket-content/<path:path>', methods=['GET'])
def list_bucket_content(path):
    try:
        # List objects within the specified S3 path (prefix) and get both files and folders
        response = s3.list_objects_v2(Bucket=BUCKET_NAME, Prefix=path, Delimiter='/')

        if 'Contents' not in response and 'CommonPrefixes' not in response:
            # If no contents or prefixes are found, the folder doesn't exist
            return jsonify({'error': f'No such file or folder: {path}'}), 404

        contents = []

        # Collect files in the response
        for obj in response.get('Contents', []):
            if obj['Key'] != path:  # Exclude the directory itself
                contents.append({'type': 'file', 'key': obj['Key'], 'size': obj['Size']})

        # Collect folders (prefixes) in the response
        for prefix in response.get('CommonPrefixes', []):
            contents.append({'type': 'folder', 'key': prefix['Prefix']})

        return jsonify({'content': contents}), 200

    except ClientError as e:
        return jsonify({'error': str(e)}), 400
    except NoCredentialsError:
        return jsonify({'error': 'AWS credentials not found'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
