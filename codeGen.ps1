# Define project structure
$projectName = "KnowledgeBaseAI"
$folders = @(
    "$projectName",
    "$projectName\data",
    "$projectName\src",
    "$projectName\models",
    "$projectName\notebooks"
)
$files = @(
    "$projectName\src\main.py",
    "$projectName\src\train_model.py",
    "$projectName\src\interactive_search.py",
    "$projectName\src\multilingual_support.py",
    "$projectName\requirements.txt",
    "$projectName\.gitignore",
    "$projectName\README.md"
)

# Create folders
foreach ($folder in $folders) {
    if (-not (Test-Path -Path $folder)) {
        New-Item -ItemType Directory -Path $folder
        Write-Output "Created folder: $folder"
    } else {
        Write-Output "Folder already exists: $folder"
    }
}

# Create files
foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) {
        New-Item -ItemType File -Path $file
        Write-Output "Created file: $file"
    } else {
        Write-Output "File already exists: $file"
    }
}

# Initialize a virtual environment
$envPath = "$projectName\venv"
if (-not (Test-Path -Path $envPath)) {
    python -m venv $envPath
    Write-Output "Virtual environment created at: $envPath"
} else {
    Write-Output "Virtual environment already exists: $envPath"
}

# Activate the virtual environment and install required packages
$requirements = @"
transformers
datasets
torch
fastapi
uvicorn
googletrans==4.0.0-rc1
jupyter_http_over_ws
"@

$requirements | Out-File -FilePath "$projectName\requirements.txt" -Encoding UTF8
Write-Output "Created requirements.txt"

Set-Location -Path "$projectName"

# Activate virtual environment and install packages
& "$envPath\Scripts\Activate.ps1"
pip install -r requirements.txt

Write-Output "Installed packages from requirements.txt"

# GitHub Integration (Optional)
$gitInitialized = Read-Host "Do you want to initialize a Git repository for this project? (y/n)"
if ($gitInitialized -eq "y") {
    git init
    git add .
    git commit -m "Initial commit"
    Write-Output "Git repository initialized. Please push to your remote repository."
} else {
    Write-Output "Skipping Git initialization."
}

# Colab Integration
$colabSetup = @"
# Colab Integration Instructions

This project can be linked with Google Colab using one of the following methods:

### 1. Google Drive

1. Zip the project folder:
    ```powershell
    Compress-Archive -Path .\ -DestinationPath $projectName.zip
    ```

2. Upload `$projectName.zip` to Google Drive.

3. In Colab, mount Google Drive:
    ```python
    from google.colab import drive
    drive.mount('/content/drive')
    !unzip /content/drive/MyDrive/$projectName.zip -d /content/
    ```

### 2. GitHub

1. Push this project to GitHub:
    ```bash
    git remote add origin https://github.com/amc-admin/KnowledgeBaseAI
    git push -u origin master
    ```

2. Clone in Colab:
    ```python
    !git clone https://github.com/amc-admin/KnowledgeBaseAI.git
    %cd $projectName
    ```

### 3. Local Runtime

1. Install and enable Jupyter extension:
    ```bash
    pip install jupyter_http_over_ws
    jupyter serverextension enable --py jupyter_http_over_ws
    ```

2. Start Jupyter with local runtime support:
    ```bash
    jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --port=8888 --NotebookApp.port_retries=0
    ```

3. Connect to Colab local runtime:
    - Go to `Connect` -> `Connect to local runtime` in Colab.

"@

$colabSetup | Out-File -FilePath "COLAB_INSTRUCTIONS.md" -Encoding UTF8
Write-Output "Colab integration instructions added to COLAB_INSTRUCTIONS.md"

# Add content to README.md
$readmeContent = @"
# $projectName

This project contains the codebase for building a generative AI model for Knowledge Base Management. The following structure is created:

- **data/**: Contains datasets used for training and testing.
- **models/**: Stores trained models.
- **notebooks/**: Jupyter notebooks for experimentation.
- **src/**: Source code for training, interactive search, and multilingual support.

## Setup Instructions

1. Activate the virtual environment:
    ```bash
    .\venv\Scripts\Activate.ps1
    ```

2. Install required Python packages:
    ```bash
    pip install -r requirements.txt
    ```

3. Run the scripts in the `src` directory to train models, start the interactive search API, and add multilingual support.

## Scripts

- **main.py**: Entry point for the application.
- **train_model.py**: Script for fine-tuning the GPT model.
- **interactive_search.py**: Script for setting up the interactive search API using FastAPI.
- **multilingual_support.py**: Script for implementing multilingual support.

## Colab Integration

See `COLAB_INSTRUCTIONS.md` for details on integrating this project with Google Colab.

"@

$readmeContent | Out-File -FilePath "README.md" -Encoding UTF8
Write-Output "Updated README.md"

# Deactivate virtual environment
deactivate
Write-Output "Environment setup complete!"
