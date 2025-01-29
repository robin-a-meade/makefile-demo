all: foo

bar:
	echo "bar contents" >bar

baz:
	echo "baz contents" >baz

qux:
	echo "qux contents" >qux

waldo:
	echo "waldo contents" >waldo

foo: bar

foo: baz

foo: qux
	cat bar baz qux >foo

# This rule, if uncommented, overrides the above rule
# Apparently, recipes are not additive
# If a target has two rules with recipes, the latter rule clobbers the former
#foo: waldo
#	cat waldo >>foo

clean:
	rm -v -f bar baz quz waldo foo

.PHONY: all clean


# Discussion
# ==========
#
# If you do:
#
#    make -p -f /dev/null | less
#
# you'll see that the rule for the `foo` target is printed as:
#
#   foo: qux bar baz
#      	cat bar baz qux >foo
#
# In other words, the rules for foo that listed only prerequisites were
# combined with the rule that specified the recipe.

