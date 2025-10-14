# Notes for creating a conda environment on the QIMR HPC

```bash

module load conda-envs/base

source ~/proxy

conda create --name <YOUR_CONDA_ENV> python=<PYTHON_VERSION>

conda deactivate && conda activate <YOUR_CONDA_ENV>
```


