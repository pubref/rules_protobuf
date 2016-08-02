buildify_all:
	buildifier WORKSPACE
	find third_party/ -name BUILD | xargs buildifier
	find java/ -name BUILD | xargs buildifier
