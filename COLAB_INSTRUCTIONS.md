# Colab Integration Instructions

This project can be linked with Google Colab using one of the following methods:

### 1. Google Drive

1. Zip the project folder:
    `powershell
    Compress-Archive -Path .\ -DestinationPath KnowledgeBaseAI.zip
    `

2. Upload $projectName.zip to Google Drive.

3. In Colab, mount Google Drive:
    `python
    from google.colab import drive
    drive.mount('/content/drive')
    !unzip /content/drive/MyDrive/KnowledgeBaseAI.zip -d /content/
    `

### 2. GitHub

1. Push this project to GitHub:
    `ash
    git remote add origin https://github.com/amc-admin/KnowledgeBaseAI
    git push -u origin master
    `

2. Clone in Colab:
    `python
    !git clone https://github.com/amc-admin/KnowledgeBaseAI.git
    %cd KnowledgeBaseAI
    `

### 3. Local Runtime

1. Install and enable Jupyter extension:
    `ash
    pip install jupyter_http_over_ws
    jupyter serverextension enable --py jupyter_http_over_ws
    `

2. Start Jupyter with local runtime support:
    `ash
    jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --port=8888 --NotebookApp.port_retries=0
    `

3. Connect to Colab local runtime:
    - Go to Connect -> Connect to local runtime in Colab.

