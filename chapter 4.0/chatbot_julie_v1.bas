SCREEN 19
WINDOWTITLE("CHATBOT JULIE V1 - TYPE '--help' FOR COMMANDS LIST")
redim SHARED r0001(0) AS STRING
REDIM SHARED k0001(0) AS STRING
REDIM SHARED AS STRING r0002(0), k0002(0), r0003(0), k0003(0), r0004(0), k0004(0), r0005(0), k0005(0), r0006(0), k0006(0)
REDIM SHARED AS STRING r0007(0), k0007(0), r0008(0), k0008(0), r0009(0), k0009(0), r0010(0), k0010(0), nokey(0)
REDIM SHARED AS STRING r0011(0), k0011(0), r0012(0), k0012(0), r0013(0), k0013(0), r0014(0), k0014(0), r0015(0), k0015(0)
REDIM SHARED AS STRING u0001(0), b0001(0), c0001(0), r0016(0), k0016(0), wordx(0), def01(0)
REDIM SHARED AS STRING line1(0), line2(0), line3(0), line4(0), line5(0), line6(0), line7(0), line8(0), line9(0), line0(0)

REDIM SHARED AS STRING ans(0), ques(0)

DIM SHARED xword AS INTEGER = 0
CONST AS STRING answers = "answers.txt"
CONST AS STRING questions = "questions.txt"
CONST AS STRING julielog = "julie_log.txt"
DIM SHARED AS STRING user, problem
DIM SHARED AS BOOLEAN isUserQuestion = true
DIM SHARED AS STRING botQuestions
user = "user"
problem = ""
DIM SHARED TTSvoice as STRING
TTSvoice = "Microsoft Zira Desktop" 'tts female or male voice (or Zira or David)
RANDOMIZE TIMER

DIM AS LONG h = FREEFILE()
OPEN answers FOR APPEND AS #h
CLOSE #h
OPEN questions FOR APPEND AS #h
CLOSE #h
OPEN julielog FOR APPEND AS #h
CLOSE #h


SUB sAppend(arr() AS string, item AS STRING)
	REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) +1)
	arr(UBOUND(arr)) = item
END SUB

SUB loadQA
DIM h AS LONG = FREEFILE()
DIM fline AS STRING
OPEN answers FOR INPUT AS #h
WHILE NOT EOF(h)
LINE INPUT #h, fline
sAppend ans(), fline
WEND
CLOSE #h
OPEN questions FOR INPUT AS #h
WHILE NOT EOF(h)
LINE INPUT #h, fline
sAppend ques(), fline
WEND
CLOSE #h

END SUB

Sub SleepEx()
  sleep
  While Inkey <> "":Wend
end sub

SUB loadArrays(filename AS STRING)
DIM h AS INTEGER = FREEFILE()
DIM fline AS STRING

OPEN filename FOR INPUT AS #h
WHILE NOT EOF(h)
	LINE INPUT #h, fline
	SELECT CASE LEFT(fline, 6)
		CASE "r0001:"
		sAppend r0001(), TRIM(MID(fline, 7))
		CASE "k0001:"
		sAppend k0001(), TRIM(MID(fline, 7))
		CASE "r0002:"
		sAppend r0002(), TRIM(MID(fline, 7))
		CASE "k0002:"
		sAppend k0002(), TRIM(MID(fline, 7))
		CASE "r0003:"
		sAppend r0003(), TRIM(MID(fline, 7))
		CASE "k0003:"
		sAppend k0003(), TRIM(MID(fline, 7))
		CASE "r0004:"
		sAppend r0004(), TRIM(MID(fline, 7))
		CASE "k0004:"
		sAppend k0004(), TRIM(MID(fline, 7))
		CASE "r0005:"
		sAppend r0005(), TRIM(MID(fline, 7))
		CASE "k0005:"
		sAppend k0005(), TRIM(MID(fline, 7))
		CASE "r0006:"
		sAppend r0006(), TRIM(MID(fline, 7))
		CASE "k0006:"
		sAppend k0006(), TRIM(MID(fline, 7))
		CASE "r0007:"
		sAppend r0007(), TRIM(MID(fline, 7))
		CASE "k0007:"
		sAppend k0007(), TRIM(MID(fline, 7))
		CASE "r0008:"
		sAppend r0008(), TRIM(MID(fline, 7))
		CASE "k0008:"
		sAppend k0008(), TRIM(MID(fline, 7))
		CASE "r0009:"
		sAppend r0009(), TRIM(MID(fline, 7))
		CASE "k0009:"
		sAppend k0009(), TRIM(MID(fline, 7))
		CASE "r0010:"
		sAppend r0010(), TRIM(MID(fline, 7))
		CASE "k0010:"
		sAppend k0010(), TRIM(MID(fline, 7))
		CASE "r0011:"
		sAppend r0011(), TRIM(MID(fline, 7))
		CASE "k0011:"
		sAppend k0011(), TRIM(MID(fline, 7))
		CASE "r0012:"
		sAppend r0012(), TRIM(MID(fline, 7))
		CASE "k0012:"
		sAppend k0012(), TRIM(MID(fline, 7))
		CASE "r0013:"
		sAppend r0013(), TRIM(MID(fline, 7))
		CASE "k0013:"
		sAppend k0013(), TRIM(MID(fline, 7))
		CASE "r0014:"
		sAppend r0014(), TRIM(MID(fline, 7))
		CASE "k0014:"
		sAppend k0014(), TRIM(MID(fline, 7))
		CASE "r0015:"
		sAppend r0015(), TRIM(MID(fline, 7))
		CASE "k0015:"
		sAppend k0015(), TRIM(MID(fline, 7))
		CASE "u0001:"
		sAppend u0001(), TRIM(MID(fline, 7))
		CASE "b0001:"
		sAppend b0001(), TRIM(MID(fline, 7))
		CASE "c0001:"
		sAppend c0001(), TRIM(MID(fline, 7))
		CASE "r0016:"
		sAppend r0016(), TRIM(MID(fline, 7))
		CASE "k0016:"
		sAppend k0016(), TRIM(MID(fline, 7))
		CASE "def01:"
		sAppend def01(), TRIM(MID(fline, 7))
		CASE "wordx:"
		sAppend wordx(), TRIM(MID(fline, 7))
		CASE "line0:"
		sAppend line0(), TRIM(MID(fline, 7))
		CASE "line1:"
		sAppend line1(), TRIM(MID(fline, 7))
		CASE "line2:"
		sAppend line2(), TRIM(MID(fline, 7))
		CASE "line3:"
		sAppend line3(), TRIM(MID(fline, 7))
		CASE "line4:"
		sAppend line4(), TRIM(MID(fline, 7))
		CASE "line5:"
		sAppend line5(), TRIM(MID(fline, 7))
		CASE "line6:"
		sAppend line6(), TRIM(MID(fline, 7))
		CASE "line7:"
		sAppend line7(), TRIM(MID(fline, 7))
		CASE "line8:"
		sAppend line8(), TRIM(MID(fline, 7))
		CASE "line9:"
		sAppend line9(), TRIM(MID(fline, 7))
		
		
		CASE "nokey:"
		sAppend nokey(), TRIM(MID(fline, 7))
		CASE "e0000:":EXIT WHILE
	END SELECT
WEND
CLOSE #h

END SUB

SUB speak (lines as string) 'uses voice command line voice.exe
	DIM AS LONG h = FREEFILE()
	OPEN julielog FOR APPEND AS #h
	PRINT #h, "Julie: " + lines
	CLOSE #h
	PRINT "Julie: " + lines: PRINT
    Shell("voice -r -2 -n " & Chr(34) & TTSvoice & Chr(34) & " " & Chr(34) & lines & Chr(34))
    'SHELL _HIDE "espeak -ven-us+f2 -s150 " + CHR$(34) + lines$ + CHR$(34)
END Sub

SUB txtfile(f AS STRING)
	CLS
	DIM AS STRING buffer
	DIM h AS LONG = FREEFILE()
	OPEN f FOR BINARY AS #h
	buffer = SPACE(LOF(h))
	GET #h ,  , buffer
	CLOSE #h
	PRINT buffer
	sleepex()
	CLS
End SUB

FUNCTION checkArray(Array() AS STRING, inpt AS STRING) AS BOOLEAN
	var result = 0
	dim as boolean Found = false
	for i as integer =  0 to ubound(Array)
	  result = Instr(inpt, Array(i))
	  if result <> 0 then
		Found = True 
		exit for
	  end if
	next i
	RETURN found
END FUNCTION

SUB answersQuestions(txt AS STRING)
var result = 0
dim as boolean Found = false
DIM h AS LONG = FREEFILE()
DIM inpt AS STRING
FOR i AS INTEGER = 0 TO UBOUND(ans)
	IF instr(txt, ans(i)) <> 0 OR txt = ans(i) THEN
		found = true
		speak ques(i)
		EXIT FOR
	END IF
	NEXT i
	IF found = false THEN
		INPUT "enter new input: ", inpt
		PRINT : speak inpt
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

SUB poemGenerator()
	speak line0(INT(RND*(UBOUND(line0))+1)) & " " & line1(INT(RND*(UBOUND(line1))+1)) & " " & line2(INT(RND*(UBOUND(line2))+1)) & _
	" " & line3(INT(RND*(UBOUND(line3))+1)) & " " & line4(INT(RND*(UBOUND(line4))+1)) & " " & line5(INT(RND*(UBOUND(line5))+1)) & _
	" " & line6(INT(RND*(UBOUND(line6))+1)) & " " & line7(INT(RND*(UBOUND(line7))+1)) & " " & line8(INT(RND*(UBOUND(line8))+1)) & _
	" " & line9(INT(RND*(UBOUND(line9))+1))
END SUB


SUB userQuestion(txt AS STRING)
	IF checkArray(k0001(), txt) THEN
		speak r0001(INT(RND*(UBOUND(r0001))+1))
	ELSEIF checkArray(k0002(), txt) THEN
		speak r0002(INT(RND*(UBOUND(r0002))+1))
	ELSEIF checkArray(k0003(), txt) THEN
		speak r0003(INT(RND*(UBOUND(r0003))+1))
	ELSEIF checkArray(k0004(), txt) THEN
		speak r0004(INT(RND*(UBOUND(r0004))+1))
	ELSEIF checkArray(k0005(), txt) THEN
		speak r0005(INT(RND*(UBOUND(r0005))+1))
	ELSEIF checkArray(k0006(), txt) THEN
		speak r0006(INT(RND*(UBOUND(r0006))+1))
	ELSEIF checkArray(k0007(), txt) THEN
		speak r0007(INT(RND*(UBOUND(r0007))+1))
	ELSEIF checkArray(k0008(), txt) THEN
		speak r0008(INT(RND*(UBOUND(r0008))+1))
	ELSEIF checkArray(k0009(), txt) THEN
		speak r0009(INT(RND*(UBOUND(r0009))+1))
	ELSEIF checkArray(k0010(), txt) THEN
		speak r0010(INT(RND*(UBOUND(r0010))+1))
	ELSEIF checkArray(k0011(), txt) THEN
		speak r0011(INT(RND*(UBOUND(r0011))+1))
	ELSEIF checkArray(k0012(), txt) THEN
		speak r0012(INT(RND*(UBOUND(r0012))+1))
	ELSEIF checkArray(k0013(), txt) THEN
		speak r0013(INT(RND*(UBOUND(r0013))+1))
	ELSEIF checkArray(k0014(), txt) THEN
		speak r0014(INT(RND*(UBOUND(r0014))+1))
	ELSEIF checkArray(k0015(), txt) THEN
		speak r0015(INT(RND*(UBOUND(r0015))+1))
	ELSEIF checkArray(k0016(), txt) THEN
		speak r0016(INT(RND*(UBOUND(r0016))+1))

	
	
	ELSEIF checkArray(def01(), txt) THEN
	speak nokey(INT(RND*(UBOUND(nokey))+1))
	ELSE
	answersQuestions(txt)
'		speak nokey(INT(RND*(UBOUND(nokey))+1))
	END IF

END SUB


SUB botQuestion(txt AS STRING)

SELECT CASE botQuestions

CASE "bother"
	problem = txt
	speak "i'm sorry that " & problem & " is bothering you dear " & user
	speak b0001(INT(RND*(UBOUND(b0001))+1))
	isUserQuestion = true

END SELECT

END SUB


SUB main()
Dim Start1 As Double
Dim TimeUp as Double
Start1 = Timer
TimeUp = Start1 + (60 * 60)
DIM h AS LONG = FREEFILE()
DIM txt AS STRING, rply AS STRING, searchTopic AS STRING
DIM AS STRING start(0 TO 5) = {"hello there i'm julie the chatbot", "hi i'm julie the chatbot", "hi i'm julie what is your name?", "good day to you i'm julie","hello i'm julie how are you?", "hello i'm julie nice to meet you let's talk"}
loadArrays("julie_database.txt")
loadQA()
start:
speak start(INT(RND*(UBOUND(start)+1)))
DO
'IF user = "" THEN
LINE INPUT user + ": ", txt: PRINT
'ELSE
'LINE INPUT user & ": ", txt: PRINT
'END IF
txt = LCASE(txt)
OPEN julielog FOR APPEND AS #h
PRINT #h, user + ": " + txt
CLOSE #h
IF checkArray(wordx(), txt) THEN
	IF xword = 0 THEN
		speak "watch your language!"
		xword += 1
	ELSEIF xword = 1 THEN
		speak "i'm warning you! watch your language! one more time and i'll say goodbye!"
		xword += 1
	ELSEIF xword = 2 THEN
		speak "ok i had enough! goodbye!"
		END
	END IF
ELSEIF txt = "sorry" THEN
	speak "ok i forgive you"
	xword = 0
ELSEIF txt = "--delete log" THEN
	Dim result As Integer = Kill( julielog )
	Dim result2 As Integer = Kill( answers )
	Dim result3 As Integer = Kill( questions )
	If result <> 0 Then Print "error trying to kill " ; julielog ; " !"
	If result2 <> 0 Then Print "error trying to kill " ; answers ; " !"
	If result3 <> 0 Then Print "error trying to kill " ; questions ; " !"
	OPEN julielog FOR APPEND AS #h
	CLOSE #h
	OPEN answers FOR APPEND AS #h
	CLOSE #h
	OPEN questions FOR APPEND AS #h
	CLOSE #h
	REDIM ans() AS STRING
	REDIM ques() AS STRING
	speak "all databases have been erased!"
elseIF checkArray(c0001(), txt) THEN
'	SHELL("start https://www.youtube.com/watch?v=6m4k0yEqvsw&list=PLkzq0nWDbWl_ll2rQo8JWxhPh0_t5Ld9t&index=2&t=0s")
	SHELL("start https://youtu.be/6m4k0yEqvsw")
ELSEIF INSTR(txt, "my name is ") THEN
	user = TRIM(MID(txt, 12))
	speak "hello " & user & " it's nice to meet you and talk to you"
ELSEIF txt = "quit" THEN
	speak "goodbye!"
ELSEIF txt = "--help" THEN
	txtfile("help.txt")
	txtfile("help2.txt")
	GOTO start
ELSEIF INSTR(txt, "search google for ") THEN
	searchTopic = TRIM(MID(txt, 19))
	shell("start https://www.google.com/search?q="+searchTopic)
ELSEIF INSTR(txt, "time left") THEN
	speak "time left " & STR(INT((TimeUp - TIMER) / 60 )) & " minutes till session is over"
ELSEIF INSTR(txt, "more time") THEN
	Start1 = Timer
	TimeUp = Start1 + (60 * 60)
	speak "session countdown has been restarted now " & STR(INT((TimeUp -TIMER) / 60)) & "minutes till session is over"
ELSEIF INSTR(txt, "write a poem") THEN
	poemGenerator()
ELSEIF checkArray(u0001(), txt) THEN
	speak "what is bothering you " & user & "?"
	botQuestions = "bother"
	isUserQuestion = FALSE
ELSEIF isUserQuestion = true THEN
	userQuestion(txt)
ELSEIF isUserQuestion = FALSE THEN
	botQuestion(txt)
	
END IF

LOOP UNTIL txt = "quit" OR TIMER >= TimeUp

END SUB

main()
PRINT "CONVERSATION ENDED PRESS ANY KEY TO CLOSE PROGRAM..."
SLEEP