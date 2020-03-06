CC := clang++ -std=c++2a -fmodules-ts -fprebuilt-module-path=.

app: m.o main.cc
	$(CC) m.o main.cc -o app
m.o: m.cc
	$(CC) --precompile -x c++-module m.cc -o m.pcm
	$(CC) -c m.pcm -o m.o
