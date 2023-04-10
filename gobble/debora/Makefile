run:
	gobble run

run-proxy:
	gobble run --only-tag proxy

get-kubeconfig:
	gobble run --only-tag get-kubeconfig

add-kubeconfig: get-kubeconfig
	slu k8s config add -p kubeconfig.yml
