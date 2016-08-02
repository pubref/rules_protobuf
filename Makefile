buildify_all:
	buildifier WORKSPACE
	find third_party/ -name BUILD | xargs buildifier
	find examples/ -name BUILD | xargs buildifier
