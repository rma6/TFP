all: tpp tf4f2 check
	@ if [ ! -d bin ]; then \
		mkdir bin ;\
	fi ;\
	cp tfp.sh bin/tfp.sh ;\
	chmod +x bin/tfp.sh

tpp: check
	@ g++ -std=c++11 tpp.cpp -g -o tpp ;\
	if [ ! -d bin ]; then \
		mkdir bin ;\
	fi ;\
	mv tpp bin ;\
	chmod +x bin/tpp

tf4f2: check
	@ g++ -std=c++11 tf4f2.cpp -g -o tr ;\
	if [ ! -d bin ]; then \
		mkdir bin ;\
	fi ;\
	mv tr bin ;\
	cp tr.sh bin/tr.sh ;\
	chmod +x bin/tr.sh ;\
	chmod +x bin/tr

check:
	@ if [ ! -f tr.sh  ]; then\
		echo "Missing file: tr.sh" ;\
		exit 1 ;\
	fi ;\
	if [ ! -f tfp.sh  ]; then\
		echo "Missing file: tfp.sh" ;\
		exit 1 ;\
	fi ;\
	if [ ! -f tpp.cpp  ]; then\
		echo "Missing file: tpp.cpp" ;\
		exit 1 ;\
	fi ;\
	if [ ! -f tf4f2.cpp  ]; then\
		echo "Missing file: tf4f2.cpp" ;\
		exit 1 ;\
	fi

clean:
	@ if [ -d bin ]; then \
		rm -r bin ;\
	fi
