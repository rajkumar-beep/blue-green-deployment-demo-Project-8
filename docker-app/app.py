from flask import Flask
import subprocess

app = Flask(__name__)

@app.route('/')
def home():

    # Get IMDSv2 token
    token = subprocess.getoutput(
        "curl -X PUT 'http://169.254.169.254/latest/api/token' "
        "-H 'X-aws-ec2-metadata-token-ttl-seconds: 21600' -s"
    )

    # Get hostname
    hostname = subprocess.getoutput(
        f"curl -H 'X-aws-ec2-metadata-token: {token}' "
        "http://169.254.169.254/latest/meta-data/local-hostname -s"
    )

    # Get availability zone
    az = subprocess.getoutput(
        f"curl -H 'X-aws-ec2-metadata-token: {token}' "
        "http://169.254.169.254/latest/meta-data/placement/availability-zone -s"
    )

    # Get instance id
    instance_id = subprocess.getoutput(
        f"curl -H 'X-aws-ec2-metadata-token: {token}' "
        "http://169.254.169.254/latest/meta-data/instance-id -s"
    )

    return f"""
    <!DOCTYPE html>
    <html>

    <head>

        <title>Blue-Green Deployment</title>

        <style>

            body {{
                background-color: #f4f6f9;
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }}

            .card {{
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0px 4px 15px rgba(0,0,0,0.2);
                text-align: center;
                width: 600px;
            }}

            h1 {{
                color: #2c3e50;
            }}

            .info {{
                margin-top: 20px;
                font-size: 20px;
                color: #34495e;
            }}

        </style>

    </head>

    <body>

        <div class="card">

            <h1>🚀 Blue-Green Deployment</h1>

            <h2>AWS + Docker + ASG + ALB</h2>

            <div class="info">
                <strong>Hostname:</strong><br>
                {hostname}
            </div>

            <div class="info">
                <strong>Availability Zone:</strong><br>
                {az}
            </div>

            <div class="info">
                <strong>Instance ID:</strong><br>
                {instance_id}
            </div>

        </div>

    </body>

    </html>
    """

app.run(host='0.0.0.0', port=80)
