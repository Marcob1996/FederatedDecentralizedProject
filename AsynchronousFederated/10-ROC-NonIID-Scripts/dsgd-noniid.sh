#!/usr/bin/env bash

# Lines that begin with #SBATCH specify commands to be used by SLURM for scheduling

#SBATCH --job-name=DSGD     # sets the job name if not set from environment
#SBATCH --time=05:30:00     # how long you think your job will take to complete; format=hh:mm:ss
#SBATCH --account=furongh    # set QOS, this will determine what resources can be requested
#SBATCH --qos=high    # set QOS, this will determine what resources can be requested
#SBATCH --gres=gpu:3
#SBATCH --ntasks=10
#SBATCH --mem 64gb         # memory required by job; if unit is not specified MB will be assumed
#SBATCH --nice=0
#SBATCH --mail-type=END   # Valid type values are NONE, BEGIN, END, FAIL, REQUEUE

module load openmpi
module load cuda/11.1.1

mpirun -np 10 python Train.py  --graph clique-ring --num_clusters 3 --name dsgd-noniid-test1-10W --comm_style d-sgd --momentum 0.9 --lr 0.8 --degree_noniid 0.5 --noniid 1 --resSize 18 --bs 32 --epoch 300 --description DSGD-paper --randomSeed 1000 --datasetRoot ./data --outputFolder Output
mpirun -np 10 python Train.py  --graph clique-ring --num_clusters 3 --name dsgd-noniid-test2-10W --comm_style d-sgd --momentum 0.9 --lr 0.8 --degree_noniid 0.5 --noniid 1 --resSize 18 --bs 32 --epoch 300 --description DSGD-paper --randomSeed 2500 --datasetRoot ./data --outputFolder Output
mpirun -np 10 python Train.py  --graph clique-ring --num_clusters 3 --name dsgd-noniid-test3-10W --comm_style d-sgd --momentum 0.9 --lr 0.8 --degree_noniid 0.5 --noniid 1 --resSize 18 --bs 32 --epoch 300 --description DSGD-paper --randomSeed 250 --datasetRoot ./data --outputFolder Output
mpirun -np 10 python Train.py  --graph clique-ring --num_clusters 3 --name dsgd-noniid-test4-10W --comm_style d-sgd --momentum 0.9 --lr 0.8 --degree_noniid 0.5 --noniid 1 --resSize 18 --bs 32 --epoch 300 --description DSGD-paper --randomSeed 225 --datasetRoot ./data --outputFolder Output
mpirun -np 10 python Train.py  --graph clique-ring --num_clusters 3 --name dsgd-noniid-test5-10W --comm_style d-sgd --momentum 0.9 --lr 0.8 --degree_noniid 0.5 --noniid 1 --resSize 18 --bs 32 --epoch 300 --description DSGD-paper --randomSeed 200 --datasetRoot ./data --outputFolder Output