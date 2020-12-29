'set console window title
WINDOWTITLE("chatbot chapter 2.0 - databased chatbot")
'set screen for console
SCREEN 19

'declare SHARED (GLOBAL) dynamic arrays of string instead of static ones
REDIM SHARED AS STRING keywords1(0), replies1(0), keywords2(0)
REDIM SHARED AS STRING replies2(0), nokeyfound(0)

'sub for loading values to a dynamic array of string
SUB sAppend(arr() AS STRING, item AS STRING)
   REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) +1)
   arr(UBOUND(arr)) = item
END SUB

'load database file into arrays sub
SUB loadArrays(f AS STRING)
   DIM AS LONG h = FREEFILE()
   DIM AS STRING fileline
   OPEN f FOR INPUT AS #h
   WHILE NOT EOF(h)
      LINE INPUT #h, fileline
      SELECT CASE LEFT(fileline, 3)
         CASE "k1:"
            SAPPEND keywords1(), TRIM(MID(fileline, 4))
         CASE "r1:"
            SAPPEND replies1(), TRIM(MID(fileline, 4))
         CASE "k2:"
            SAPPEND keywords2(), TRIM(MID(fileline, 4))
         CASE "r2:"
            SAPPEND replies2(), TRIM(MID(fileline, 4))
         CASE "d1:"
            SAPPEND nokeyfound(), TRIM(MID(fileline, 4))
         CASE "e1:"
            EXIT while
      END SELECT
   WEND
   CLOSE #h
END SUB

'function for cheaking input for keywords array
FUNCTION check_input(txt AS STRING, txt_array() AS STRING) AS boolean
   FOR i AS INTEGER = 0 TO UBOUND(txt_array)
      IF INSTR(txt, txt_array(i)) THEN
         RETURN TRUE
      ENDIF
   NEXT
   RETURN FALSE
END FUNCTION

'sub for printing properly the chatbot replies
SUB bot_speak(t AS STRING)
   PRINT "bot: " & t
   PRINT
END SUB

'begin randomization
RANDOMIZE TIMER

'function for doing the input-keywords-replies process
FUNCTION bot_brain(txt AS STRING) AS STRING
   IF CHECK_INPUT(txt, keywords1()) THEN
      RETURN replies1(INT(RND*(UBOUND(replies1))+1))
   ELSEIF CHECK_INPUT(txt, keywords2()) THEN
      RETURN replies2(INT(RND*(UBOUND(replies2))+1))
   ELSE 
      RETURN nokeyfound(INT(RND*(UBOUND(nokeyfound))+1))
   ENDIF   
END FUNCTION

'call loadarray sub to load database to arrays
LOADARRAYS("database.TXT")


'dim a string variable for catching the input
DIM AS STRING text
'dim another string variable to catch the bot_brain function value
DIM AS STRING rply 
'start of conversation - bot ask the user a question
BOT_SPEAK("hello how was your day so far? tell me please about your day...")

'main loop for the conversation with the chatbot
DO
   'get user input
   INPUT "user: ", text
   PRINT
   rply = BOT_BRAIN(text)
   BOT_SPEAK(rply)

LOOP UNTIL text = "quit"
BOT_SPEAK("goodbye!")

SLEEP

