all:hello

hello.o:hello.s
	gcc -o hello.o -c hello.s -g

hello:hello.o
	ld -o hello hello.o -g

clean:
	-rm hello.o hello -f
