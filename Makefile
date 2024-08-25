test:
	rm -f target/test 
	clang -x ir -o target/test test.ll
	./target/test

closure:
	rm -f target/closure 
	clang -x ir -o target/closure closure.ll
	./target/closure

