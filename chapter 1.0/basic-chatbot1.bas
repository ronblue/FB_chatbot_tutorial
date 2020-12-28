'set screen for console
SCREEN 19

'static arrays of keywords and replies 
DIM AS STRING keywords1(0 TO 3) => _
 {"bad", "awful", "average", "don't know"}

DIM AS STRING replies1(0 TO 3) => _
 {"i'm sorry to hear that... hope your day will get better", _
  "well there are days like that cheer up!...", _
  "don't feel bad tomorrow is a new day!...", _
  "everyone has days like that just keep trying your best"}
                                   
DIM AS STRING keywords2(0 TO 3) => _
 {"good", "wonderful", "excellent", "best day ever"}

DIM AS STRING replies2(0 TO 3) => _
 {"i'm so happy for you!", "that's great! can you tell me about your day?", _
  "what did you do today?", "please tell me more :)"}

DIM AS STRING nokeyfound(0 TO 3) => _
 {"i see go on", "that is interesting", "how does that make you feel?", _
  "i understand"}

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
      PRINT "bot: " & replies1(INT(RND*(UBOUND(replies1)+1)))
   ELSEIF CHECK_INPUT(text, keywords2()) THEN
      PRINT "bot: " & replies2(INT(RND*(UBOUND(replies2)+1)))
   ELSE 
      PRINT "bot: " & nokeyfound(INT(RND*(UBOUND(nokeyfound)+1)))
   ENDIF
   
LOOP UNTIL text = "quit"
PRINT "bot: goodbye!"

SLEEP