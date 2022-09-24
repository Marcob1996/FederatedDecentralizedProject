#!/usr/bin/env bash

# Lines that begin with #SBATCH specify commands to be used by SLURM for scheduling

#SBATCH --job-name=PDSGD     # sets the job name if not set from environment
#SBATCH --time=04:50:00     # how long you think your job will take to complete; format=hh:mm:ss
#SBATCH --account=furongh    # set QOS, this will determine what resources can be requested
#SBATCH --qos=high    # set QOS, this will determine what resources can be requested
#SBATCH --gres=gpu:4
#SBATCH --ntasks=16
#SBATCH --mem 128gb         # memory required by job; if unit is not specified MB will be assumed
#SBATCH --nice=0
#SBATCH --mail-type=END   # Valid type values are NONE, BEGIN, END, FAIL, REQUEUE

module load openmpi
module load cuda/11.1.1

mpirun -np 16 python Train.py  --graph clique-ring --num_clusters 4 --name pdsgd-iid-test1-16W-4c --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --lr 0.1 --degree_noniid 0 --noniid 0 --resSize 50 --bs 64 --epoch 200 --description PDSGD --randomSeed 282 --datasetRoot ./data --outputFolder Output
mpirun -np 16 python Train.py  --graph clique-ring --num_clusters 4 --name pdsgd-iid-test2-16W-4c --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --lr 0.1 --degree_noniid 0 --noniid 0 --resSize 50 --bs 64 --epoch 200 --description PDSGD --randomSeed 867 --datasetRoot ./data --outputFolder Output
mpirun -np 16 python Train.py  --graph clique-ring --num_clusters 4 --name pdsgd-iid-test3-16W-4c --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --lr 0.1 --degree_noniid 0 --noniid 0 --resSize 50 --bs 64 --epoch 200 --description PDSGD --randomSeed 66 --datasetRoot ./data --outputFolder Output
mpirun -np 16 python Train.py  --graph clique-ring --num_clusters 4 --name pdsgd-iid-test4-16W-4c --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --lr 0.1 --degree_noniid 0 --noniid 0 --resSize 50 --bs 64 --epoch 200 --description PDSGD --randomSeed 77 --datasetRoot ./data --outputFolder Output
mpirun -np 16 python Train.py  --graph clique-ring --num_clusters 4 --name pdsgd-iid-test5-16W-4c --comm_style pd-sgd --momentum 0.9 --i1 1 --i2 1 --lr 0.1 --degree_noniid 0 --noniid 0 --resSize 50 --bs 64 --epoch 200 --description PDSGD --randomSeed 88 --datasetRoot ./data --outputFolder Output
