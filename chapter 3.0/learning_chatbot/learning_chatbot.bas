'set console window title
WINDOWTITLE("chatbot chapter 3.0 - a learning chatbot")
'set screen for console
SCREEN 19

'declare two string dynamic arrays for keywords(answers) and replies(questions)
REDIM SHARED AS STRING ans(0), ques(0)

'declare two conctants of string for the two databases text files
CONST AS STRING answers = "answers.txt"
CONST AS STRING questions = "questions.txt"

'open files for append and by so creating the text files
DIM AS LONG h = FREEFILE()
OPEN answers FOR APPEND AS #h
CLOSE #h
OPEN questions FOR APPEND AS #h
CLOSE #h

'sub for loading values to a dynamic array of string
SUB sAppend(arr() AS STRING, item AS STRING)
   REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) +1)
   arr(UBOUND(arr)) = item
END SUB

'sub for loading keywords(answers) and replies(questions)
'from databases files to the two arrays ans() and ques()
SUB loadQA
   DIM h AS LONG = FREEFILE()
   DIM fline AS STRING
   OPEN answers FOR INPUT AS #h
      WHILE NOT EOF(h)
         LINE INPUT #h, fline
         SAPPEND ans(), fline
      WEND
   CLOSE #h
   OPEN questions FOR INPUT AS #h
      WHILE NOT EOF(h)
         LINE INPUT #h, fline
         SAPPEND ques(), fline
      WEND
   CLOSE #h
END SUB

'sub for printing properly the chatbot replies
SUB bot_speak(t AS STRING)
   PRINT "bot: " & t
   PRINT
END SUB

'this sub is important it checks is user input is new or not
'if it already knows the input then it will replay the learned output
'if the input is new then it will ask the user to give the proper replay
'and it will store it in the databases and in the arrays
SUB answersQuestions(txt AS STRING)
var result = 0
dim as boolean Found = false
DIM h AS LONG = FREEFILE()
DIM inpt AS STRING
FOR i AS INTEGER = 0 TO UBOUND(ans)
	IF instr(txt, ans(i)) <> 0 OR txt = ans(i) THEN
		found = true
		BOT_SPEAK ques(i)
		EXIT FOR
	END IF
	NEXT i
	IF found = false THEN
		INPUT "enter new input: ", inpt
		PRINT : BOT_SPEAK inpt
		OPEN answers FOR APPEND AS #h
		PRINT #h, txt
		CLOSE #h
		OPEN questions FOR APPEND AS #h
		PRINT #h, inpt
		CLOSE #h
		sAppend ans(), txt
		sAppend ques(), inpt
	END IF
END SUB

'the main sub where it all comes together
SUB main()
   DIM txt AS STRING
   loadQA()
   DO
      INPUT "user: ", txt: PRINT
      txt = LCASE(txt)
      answersQuestions(txt)
   LOOP UNTIL txt = "quit"
   SLEEP 
END SUB

MAIN()