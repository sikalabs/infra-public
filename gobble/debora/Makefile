run:
	gobble run

get-kubeconfig:
	gobble run --only-tag get-kubeconfig

add-kubeconfig: get-kubeconfig
	slu k8s config add -p kubeconfig.yml
