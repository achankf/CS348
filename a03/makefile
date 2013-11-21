IN= $(shell find -name "*.tex")
INCLUDE = $(shell find -name "*.texin")
OUT= $(IN:.tex=.pdf)
SQL = createdb.sql
CLEANSQL = $(SQL:.sql=.sql_clean)

all: $(OUT)

$(OUT):$(IN) $(INCLUDE) $(CLEANSQL)
	pdflatex $<

%.sql_clean : %.sql
	grep -ve drop -e connect $< | \
	sed "s/--.*$$//g" | \
	sed 's:\\::g' > $@

.phony: clean
clean:
	rm -f *.log *.aux *.eps *eps-converted-to.pdf *.sql_clean
cleanall:clean
	rm -f $(OUT)
