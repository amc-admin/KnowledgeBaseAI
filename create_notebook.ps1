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
    "$projectName\README.md",
    "$projectName\notebooks\example_notebook.ipynb"
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



# Create an example Jupyter Notebook
$notebookContent = @"
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Welcome to KnowledgeBaseAI\n",
    "\n",
    "This notebook serves as an example of how to get started with the Knowledge Base Management AI model.\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Importing necessary libraries\n",
    "import transformers\n",
    "import torch\n",
    "from datasets import load_dataset\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Example code for loading a dataset\n",
    "dataset = load_dataset('wikipedia', '20220301.en', split='train[:1%]')\n",
    "print(dataset[0])\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "version": "3.8.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
"@

$notebookContent | Out-File -FilePath "$projectName\notebooks\example_notebook.ipynb" -Encoding UTF8
Write-Output "Created example Jupyter notebook at notebooks/example_notebook.ipynb"

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
    !git clone https://github.com/amc-admin/$projectName.git
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

