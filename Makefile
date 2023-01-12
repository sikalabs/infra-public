fmt:
	make tf-fmt
	make prettier-fmt

tf-fmt:
	terraform fmt -recursive

tf-fmt-check:
	terraform fmt -recursive -check

prettier-fmt:
	yarn run prettier-write

prettier-fmt-check:
	yarn run prettier-check

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)
