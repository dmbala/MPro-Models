# Job files for monomer and dimer structure predictions of MPro

./6yb7_mono:
  input.fa (input fasta file)
  run_gpu.slrm (Slurm job submission script)
  run_local_gpu.sh (Wrapper script to submit the job on a gpu)

./6yb7_dimer:
  input.fa
  run_gpu.slrm
  run_local_mmer.sh (Wrapper script to submit multimer job on a gpu)

