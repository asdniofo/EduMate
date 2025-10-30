#!/usr/bin/env python3
import os
import boto3
import psycopg2
import cx_Oracle
from pathlib import Path
import mimetypes

# Cloudflare R2 configuration
R2_ENDPOINT = "https://d9ccd44892a955eb74f49169431509a8.r2.cloudflarestorage.com"
R2_ACCESS_KEY = "7de029bbac8e5545039f1a5e680cb18c"
R2_SECRET_KEY = "4911a65055712481ffb8db0e7823baaa07dafa71b5acbb0616ae773b2e583f01"
R2_BUCKET = "edumate-files"
R2_PUBLIC_URL = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev"

# Database configuration
DB_URL = "20.249.165.235:1521/XEPDB1"
DB_USER = "EDUMATE"
DB_PASSWORD = "EDUMATE"

def main():
    print("===========================================")
    print("Real file upload to Cloudflare R2")
    print("===========================================")
    
    # Initialize S3 client for R2
    s3_client = boto3.client(
        's3',
        endpoint_url=R2_ENDPOINT,
        aws_access_key_id=R2_ACCESS_KEY,
        aws_secret_access_key=R2_SECRET_KEY,
        region_name='auto'
    )
    
    # Connect to Oracle database
    dsn = cx_Oracle.makedsn("20.249.165.235", 1521, service_name="XEPDB1")
    conn = cx_Oracle.connect(user=DB_USER, password=DB_PASSWORD, dsn=dsn)
    cursor = conn.cursor()
    
    try:
        # Upload lecture images
        upload_lecture_images(s3_client, cursor)
        
        # Upload videos
        upload_videos(s3_client, cursor)
        
        # Upload event images
        upload_event_images(s3_client)
        
        print("\n===========================================")
        print("All files uploaded successfully!")
        print("===========================================")
        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()

def upload_lecture_images(s3_client, cursor):
    print("\nUploading lecture images...")
    
    base_path = "src/main/webapp/resources/images/lecture/"
    
    if os.path.exists(base_path):
        for filename in os.listdir(base_path):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.gif')):
                local_path = os.path.join(base_path, filename)
                s3_key = f"lecture/images/{filename}"
                
                try:
                    content_type = mimetypes.guess_type(filename)[0] or 'image/jpeg'
                    
                    with open(local_path, 'rb') as file:
                        s3_client.upload_fileobj(
                            file,
                            R2_BUCKET,
                            s3_key,
                            ExtraArgs={'ContentType': content_type}
                        )
                    
                    print(f"  Uploaded: {filename} -> {R2_PUBLIC_URL}/{s3_key}")
                    
                except Exception as e:
                    print(f"  Failed to upload {filename}: {e}")

def upload_videos(s3_client, cursor):
    print("\nUploading video files...")
    
    base_path = "src/main/webapp/resources/videos/lecture/"
    
    if os.path.exists(base_path):
        for filename in os.listdir(base_path):
            if filename.lower().endswith(('.mp4', '.avi', '.mov', '.wmv')):
                local_path = os.path.join(base_path, filename)
                s3_key = f"lecture/videos/{filename}"
                
                try:
                    content_type = mimetypes.guess_type(filename)[0] or 'video/mp4'
                    
                    with open(local_path, 'rb') as file:
                        s3_client.upload_fileobj(
                            file,
                            R2_BUCKET,
                            s3_key,
                            ExtraArgs={'ContentType': content_type}
                        )
                    
                    print(f"  Uploaded: {filename} -> {R2_PUBLIC_URL}/{s3_key}")
                    
                except Exception as e:
                    print(f"  Failed to upload {filename}: {e}")

def upload_event_images(s3_client):
    print("\nUploading event images...")
    
    # Event thumbnails
    base_path = "src/main/resources/static/resources/images/event/thumbnail/"
    if os.path.exists(base_path):
        for filename in os.listdir(base_path):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.gif')):
                local_path = os.path.join(base_path, filename)
                s3_key = f"event/thumbnail/{filename}"
                
                try:
                    content_type = mimetypes.guess_type(filename)[0] or 'image/jpeg'
                    
                    with open(local_path, 'rb') as file:
                        s3_client.upload_fileobj(
                            file,
                            R2_BUCKET,
                            s3_key,
                            ExtraArgs={'ContentType': content_type}
                        )
                    
                    print(f"  Uploaded: {filename} -> {R2_PUBLIC_URL}/{s3_key}")
                    
                except Exception as e:
                    print(f"  Failed to upload {filename}: {e}")

if __name__ == "__main__":
    main()