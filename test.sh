kubectl run image-warmer-1 --image=vllm/vllm-openai:v0.10.2 --restart=Never --overrides='{"spec": {"nodeSelector": {"kubernetes.io/hostname": "zg2gn02"}, "containers": [{"name": "image-warmer-1", "image": "vllm/vllm-openai:v0.10.2", "command": ["sh", "-c", "sleep 5 && exit 0"]}], "restartPolicy": "Never"}}'


kubectl run image-warmer-1 --image=vllm/vllm-openai:v0.10.1 --restart=Never --overrides='{"spec": {"nodeSelector": {"kubernetes.io/hostname": "zg2gn04"}, "containers": [{"name": "image-warmer-1", "image": "vllm/vllm-openai:v0.10.1", "command": ["sh", "-c", "sleep 5 && exit 0"]}], "restartPolicy": "Never"}}'



mpirun --allow-run-as-root \
  -np 16 \
  -H gpu42:8,gpu43:8 \
  -x LD_LIBRARY_PATH \
  -x PATH \
  -x NCCL_DEBUG=INFO \
  -x NCCL_SOCKET_IFNAME=bond1 \
  -x NCCL_IB_HCA=mlx5_0:1,mlx5_1:1,mlx5_4:1,mlx5_5:1,mlx5_6:1,mlx5_13:1,mlx5_16:1,mlx5_17:1 \
  /share/apps/nccl-test/nccl-tests/build/reduce_scatter_perf -b 8 -e 16g -f 2 -g 1
