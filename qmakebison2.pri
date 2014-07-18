How To Use Flex And Bison With Qmake (My Own Way)
from http://www.freehackers.org/thomas/2009/11/22/how-to-use-flex-and-bison-with-qmake-my-own-way/


% cat flex.pri

flex.name = Flex ${QMAKE_FILE_IN}
flex.input = FLEXSOURCES
flex.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.lexer.cpp
flex.commands = flex -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.lexer.cpp ${QMAKE_FILE_IN}
flex.CONFIG += target_predeps
flex.variable_out = GENERATED_SOURCES
silent:flex.commands = @echo Lex ${QMAKE_FILE_IN} && $$flex.commands
QMAKE_EXTRA_COMPILERS += flex

% cat bison.pri

bison.name = Bison ${QMAKE_FILE_IN}
bison.input = BISONSOURCES
bison.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.parser.cpp
bison.commands = bison -d -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.parser.cpp ${QMAKE_FILE_IN}
bison.CONFIG += target_predeps
bison.variable_out = GENERATED_SOURCES
silent:bison.commands = @echo Bison ${QMAKE_FILE_IN} && $$bison.commands
QMAKE_EXTRA_COMPILERS += bison
bison_header.input = BISONSOURCES
bison_header.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.parser.hpp
bison_header.commands = bison -d -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.parser.cpp ${QMAKE_FILE_IN}
bison_header.CONFIG += target_predeps no_link
silent:bison_header.commands = @echo Bison ${QMAKE_FILE_IN} && $$bison.commands
QMAKE_EXTRA_COMPILERS += bison_header

Of course, the proper way to use those is to include them and then define FLEXSOURCES / BISONSOURCES as needed. Example:

include(flex.pri)
include(bison.pri)
FLEXSOURCES = myproject.l
BISONSOURCES = myproject.y
