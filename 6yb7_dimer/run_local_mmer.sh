#!/bin/bash
export TF_FORCE_UNIFIED_MEMORY=1
export XLA_PYTHON_CLIENT_MEM_FRACTION=4.0
export XDG_RUNTIME_DIR=/scratch/$HOME/XDG_RUNTIME_DIR/AF2
mkdir -p $XDG_RUNTIME_DIR
export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
export DB_DIR="/projects/community/alphafold/dbs/reduced_dbs/MMer"
export BIN_DIR="/projects/community/ai-fold/2021/bd387/envs/af2/bin/"



module load gcc/11.2 openmpi
module use /projects/community/modulefiles
module load ai-fold
#source /projects/community/ai-fold/2021/bd387/etc/profile.d/conda.sh
#conda activate af2
source activate af2

module load cuda/11.4.1

input_fasta_file=$1
output_data_dir=$2
echo "input fasta file"
echo $input_fasta_file
echo "Output data directory"
echo $output_data_dir

#CUDA_VISIBLE_DEVICES=0
python /projects/community/ai-fold/2021/bd387/envs/af2/alphafold/run_alphafold.py --helpfull
python /projects/community/ai-fold/2021/bd387/envs/af2/alphafold/run_alphafold.py \
    --data_dir=$DB_DIR \
    --uniref90_database_path=$DB_DIR/../uniref90/uniref90.fasta \
    --uniclust30_database_path=$DB_DIR/../uniclust30/uniclust30_2018_08/uniclust30_2018_08 \
    --mgnify_database_path=$DB_DIR/../mgnify/mgy_clusters_2018_12.fa \
    --bfd_database_path=$DB_DIR/../../bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt  \
    --template_mmcif_dir=$DB_DIR/../pdb_mmcif/mmcif_files/ \
    --obsolete_pdbs_path=$DB_DIR/../pdb_mmcif/obsolete.dat \
    --uniprot_database_path=$DB_DIR/uniprot/uniprot.fasta \
    --pdb_seqres_database_path=$DB_DIR/pdb_seqres/pdb_seqres.txt \
    --kalign_binary_path=$BIN_DIR/kalign \
    --jackhmmer_binary_path=$BIN_DIR/jackhmmer \
    --hhblits_binary_path=$BIN_DIR/hhblits \
    --hhsearch_binary_path=$BIN_DIR/hhsearch \
    --model_preset=multimer \
    --db_preset=full_dbs \
    --is_prokaryote_list=false \
    --max_template_date=2021-12-01 \
    --fasta_paths=$input_fasta_file \
    --output_dir=$output_data_dir 
