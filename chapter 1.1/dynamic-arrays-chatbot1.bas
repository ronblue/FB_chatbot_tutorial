'set screen for console
SCREEN 19

'declare dynamic arrays of string instead of static ones
REDIM AS STRING keywords1(0), replies1(0), keywords2(0)
REDIM AS STRING replies2(0), nokeyfound(0)

'sub for loading values to a dynamic array of string
SUB sAppend(arr() AS STRING, item AS STRING)
   REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) +1)
   arr(UBOUND(arr)) = item
END SUB

'for catching the values from the DATA at the bottom
DIM r AS STRING

'for loops to load each dynamic array with the values read from the DATA at the bottom
FOR i AS INTEGER = 1 TO 4
   READ r
   SAPPEND keywords1(), r 
NEXT

FOR i AS INTEGER = 1 TO 4
   READ r
   SAPPEND replies1(), r
NEXT

FOR i AS INTEGER = 1 TO 4
   READ r
   SAPPEND keywords2(), r
NEXT

FOR i AS INTEGER = 1 TO 4
   READ r
   SAPPEND replies2(), r
NEXT

FOR i AS INTEGER = 1 TO 4
   READ r
   SAPPEND nokeyfound(), r
NEXT

'function for cheaking input for keywords array
FUNCTION check_input(txt AS STRING, txt_array() AS STRING) AS boolean
   FOR i AS INTEGER = 0 TO UBOUND(txt_array)
      IF INSTR(txt, txt_array(i)) THEN
         RETURN TRUE
         
      ENDIF
   NEXT
   RETURN FALSE
END FUNCTION

'begin randomization
RANDOMIZE TIMER

'dim a string variable for catching the input
DIM AS STRING text

'start of conversation - bot ask the user a question
PRINT "bot: hello how was your day so far? tell me please about your day..."

'main loop
DO
   'get user input
   INPUT "user: ", text
   
   'if stetments to check keywords arrays with input and generate random replay
   IF CHECK_INPUT(text, keywords1()) THEN
      PRINT "bot: " & replies1(INT(RND*(UBOUND(replies1))+1))
   ELSEIF CHECK_INPUT(text, keywords2()) THEN
      PRINT "bot: " & replies2(INT(RND*(UBOUND(replies2))+1))
   ELSE 
      PRINT "bot: " & nokeyfound(INT(RND*(UBOUND(nokeyfound))+1))
   ENDIF
   
LOOP UNTIL text = "quit"
PRINT "bot: goodbye!"

SLEEP

'DATA structures lines
'keywods1
DATA "bad"
DATA "awful"
DATA "average"
DATA "don't know"

'replies1
DATA "i'm sorry to hear that... hope your day will get better"
DATA "well there are days like that cheer up!..."
DATA "don't feel bad tomorrow is a new day!..."
DATA "everyone has days like that just keep trying your best

'keywords2
DATA "good"
DATA "wonderful"
DATA "excellent"
DATA "best day ever"

'replies2
DATA "i'm so happy for you!"
DATA "that's great! can you tell me about your day?"
DATA "what did you do today?"
DATA "please tell me more :)"

'nokeyfound
DATA "i see go on"
DATA "that is interesting"
DATA "how does that make you feel?"
DATA "i understand"
