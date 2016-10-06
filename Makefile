fmt:
	buildifier WORKSPACE
	find bzl/build_file/ -name '*.BUILD' | xargs buildifier
	find third_party/ -name BUILD | xargs buildifier
	find examples/ -name BUILD | xargs buildifier
