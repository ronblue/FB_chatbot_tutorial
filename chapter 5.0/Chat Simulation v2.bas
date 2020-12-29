#LANG"qb"
'OPTION _EXPLICIT
'_TITLE "Chat Simulation" ' B+ started 2019-05-26  post loadArrays test on Script Eliza.txt file
'2019-05-29 post basic getReply$ function of Eliza / Script Player
'2019-05-30 LINE INPUT to allow commas, try isolatePunctuation$ and joinPunction, look like it's working.
'2019-05-31 OK it all seems to be working without all caps and with punctuation.
'2019-06-13 mod by ron77 to add Parrany Petience as a second Chatbot to chat with Eliza as a Simulation - for that Duplicated Eliza Function and Subs And added a second Text File "Parrany Script.TXT"
'mod by ron77 for freebasic in "qb" dialect... - 2019-04-04

CONST punctuation = "?!,.:;<>(){}[]"
DIM SHARED Greeting AS STRING, You AS STRING, Script AS STRING
DIM SHARED kCnt AS INTEGER, rCnt AS INTEGER, wCnt AS INTEGER, NoKeyFoundIndex AS INTEGER
REDIM SHARED keywords(0) AS STRING, replies(0) AS STRING, wordIn(0) AS STRING, wordOut(0) AS STRING
REDIM SHARED rStarts(0) AS INTEGER, rEnds(0) AS INTEGER, rIndex(0) AS INTEGER

DIM SHARED kCnt2 AS INTEGER, rCnt2 AS INTEGER, wCnt2 AS INTEGER, NoKeyFoundIndex2 AS INTEGER
REDIM SHARED keywords2(0) AS STRING, replies2(0) AS STRING, wordIn2(0) AS STRING, wordOut2(0) AS STRING
REDIM SHARED rStarts2(0) AS INTEGER, rEnds2(0) AS INTEGER, rIndex2(0) AS INTEGER



'append to the string array the string item
SUB sAppend (arr() AS STRING, item AS STRING)
    REDIM Preserve arr(LBOUND(arr) TO UBOUND(arr) + 1) AS STRING
    arr(UBOUND(arr)) = item
END SUB

'append to the integer array the integer item
SUB nAppend (arr() AS INTEGER, item AS INTEGER)
    REDIM Preserve arr(LBOUND(arr) TO UBOUND(arr) + 1) AS INTEGER
    arr(UBOUND(arr)) = item
END SUB

FUNCTION isolatePunctuation$ (s AS STRING)
    'isolate punctuation so when we look for key words they don't interfere
    DIM b AS STRING, i AS INTEGER
    b = ""
    FOR i = 1 TO LEN(s)
        IF INSTR(punctuation, MID$(s, i, 1)) > 0 THEN b = b + " " + MID$(s, i, 1) + " " ELSE b = b + MID$(s, i, 1)
    NEXT
    isolatePunctuation$ = b
END FUNCTION

FUNCTION joinPunctuation$ (s AS STRING)
    'undo isolatePuntuation$
    DIM b AS STRING, find AS STRING, i AS INTEGER, place AS INTEGER
    b = s
    FOR i = 1 TO LEN(punctuation)
        find = " " + MID$(punctuation, i, 1) + " "
        place = INSTR(b, find)
        WHILE place > 0
            IF place = 1 THEN
                b = MID$(punctuation, i, 1) + MID$(b, place + 3)
            ELSE
                b = MID$(b, 1, place - 1) + MID$(punctuation, i, 1) + MID$(b, place + 3)
            END IF
            place = INSTR(b, find)
        WEND
    NEXT
    joinPunctuation$ = b
END Function

' pull data out of some script file
SUB LoadArrays (scriptFile AS STRING)
    DIM startR AS INTEGER, endR AS INTEGER, ReadingR AS INTEGER, temp AS INTEGER
    DIM fline AS STRING, kWord AS STRING

    OPEN scriptFile FOR INPUT AS #1
    WHILE EOF(1) = 0
        LINE INPUT #1, fline
        SELECT CASE LEFT$(fline$, 2)
        	CASE "g:": Greeting = __TRIM(MID$(fline, 3))
        	CASE "y:": You = __TRIM(MID$(fline, 3))
        	CASE "c:": Script = __TRIM(MID$(fline, 3))
            CASE "s:"
                wCnt = wCnt + 1: temp = INSTR(fline, ">")
                IF temp THEN
                    sAppend wordIn(), " " + __TRIM(MID$(fline, 3, temp - 3)) + " "
                    sAppend wordOut(), " " + __TRIM(MID$(fline, temp + 1)) + " "
                END IF
            CASE "r:"
                rCnt = rCnt + 1
                sAppend replies(), __TRIM(MID$(fline, 3))
                IF NOT ReadingR THEN
                    ReadingR = -1
                    startR = rCnt
                END IF
            CASE "k:"
                IF ReadingR THEN
                    endR = rCnt
                    ReadingR = 0
                END IF
                IF rCnt THEN
                    kCnt = kCnt + 1
                    kWord = __TRIM(MID$(fline, 3))
                    sAppend keywords(), " " + kWord + " "
                    nAppend rStarts(), startR
                    nAppend rIndex(), startR
                    nAppend rEnds(), endR
                    IF kWord = "nokeyfound" THEN NoKeyFoundIndex = kCnt
                END IF
            CASE "e:": EXIT WHILE
        END SELECT
    WEND
    CLOSE #1
    IF ReadingR THEN 'handle last bits
        endR = rCnt
        kCnt = kCnt + 1
        sAppend keywords(), "nokeyfound"
        nAppend rStarts(), startR
        nAppend rIndex(), startR
        nAppend rEnds(), endR
        NoKeyFoundIndex = kCnt
    END IF
END SUB





SUB LoadArrays2 (scriptFile AS STRING) ' Parrany ChatBot2 Load Rplays From Text File
    DIM startR2 AS INTEGER, endR2 AS INTEGER, ReadingR2 AS INTEGER, temp2 AS INTEGER
    DIM fline2 AS STRING, kWord2 AS STRING

    OPEN scriptFile FOR INPUT AS #1
    WHILE EOF(1) = 0
        LINE INPUT #1, fline2
        SELECT CASE LEFT$(fline2$, 2)
            CASE "s:"
                wCnt2 = wCnt2 + 1: temp2 = INSTR(fline2, ">")
                IF temp2 THEN
                    sAppend wordIn2(), " " + __TRIM(MID$(fline2, 3, temp2 - 3)) + " "
                    sAppend wordOut2(), " " + __TRIM(MID$(fline2, temp2 + 1)) + " "
                END IF
            CASE "r:"
                rCnt2 = rCnt2 + 1
                sAppend replies2(), __TRIM(MID$(fline2, 3))
                IF NOT ReadingR2 THEN
                    ReadingR2 = -1
                    startR2 = rCnt2
                END IF
            CASE "k:"
                IF ReadingR2 THEN
                    endR2 = rCnt2
                    ReadingR2 = 0
                END IF
                IF rCnt2 THEN
                    kCnt2 = kCnt2 + 1
                    kWord2 = __TRIM(MID$(fline2, 3))
                    sAppend keywords2(), " " + kWord2 + " "
                    nAppend rStarts2(), startR2
                    nAppend rIndex2(), startR2
                    nAppend rEnds2(), endR2
                    IF kWord2 = "nokeyfound" THEN NoKeyFoundIndex2 = kCnt2
                END IF
            CASE "e:": EXIT WHILE
        END SELECT
    WEND
    CLOSE #1
    IF ReadingR2 THEN 'handle last bits
        endR2 = rCnt2
        kCnt2 = kCnt2 + 1
        sAppend keywords2(), "nokeyfound"
        nAppend rStarts2(), startR2
        nAppend rIndex2(), startR2
        nAppend rEnds2(), endR2
        NoKeyFoundIndex2 = kCnt2
    END IF
END SUB

' =============================== here is the heart of ELIZA / Player function
FUNCTION GetReply$ (rply2 AS STRING)
    DIM inpt AS STRING, tail AS STRING, answ AS STRING
    DIM kFlag AS INTEGER, k AS INTEGER, kFound AS INTEGER, l AS INTEGER, w AS INTEGER
    ' USER INPUT SECTION
    inpt = rply2
    inpt = " " + inpt + " " '<< need this because keywords embedded in spaces to ID whole words only
    inpt = isolatePunctuation$(inpt)
    FOR k = 1 TO kCnt 'loop through key words until we find a match
        kFound = INSTR(LCASE$(inpt), LCASE$(keywords(k)))
        IF kFound > 0 THEN '>>> need the following for * in some replies
            tail = " " + MID$(inpt, kFound + LEN(keywords(k)))
            FOR l = 1 TO LEN(tail) 'DO NOT USE INSTR
                FOR w = 1 TO wCnt 'swap words in tail if used there
                    IF LCASE$(MID$(tail, l, LEN(wordIn(w)))) = LCASE$(wordIn(w)) THEN 'swap words exit for
                        tail = MID$(tail, 1, l - 1) + wordOut(w) + MID$(tail, l + LEN(wordIn(w)))
                        EXIT FOR
                    END IF
                NEXT w
            NEXT l
            kFlag = -1
            EXIT FOR
        END IF
    NEXT
    IF kFlag = 0 THEN k = NoKeyFoundIndex
    answ = replies(INT((rEnds(k) - rStarts(k) + 1) * RND) + rStarts(k))
    'set pointer to next reply in rIndex array
    IF k = NoKeyFoundIndex THEN 'let's not get too predictable for most used set of replies
        rIndex(k) = INT((rEnds(k) - rStarts(k) + 1) * RND) + rStarts(k)
    'ELSE
    '    rIndex(k) = rIndex(k) + 1 'set next reply index then check it
    '    IF rIndex(k) > rEnds(k) THEN rIndex(k) = rStarts(k)
    END IF
    IF RIGHT$(answ, 1) <> "*" THEN GetReply$ = answ: EXIT FUNCTION 'oh so the * signal an append to reply!
    IF __TRIM(tail) = "" THEN
        GetReply$ = "Please elaborate on, " + keywords(k)
    ELSE
        tail = joinPunctuation$(tail)
        GetReply$ = MID$(answ, 1, LEN(answ) - 1) + tail
    END IF

END Function

FUNCTION GetReply2$ (rply AS STRING)
    DIM inpt2 AS STRING, tail2 AS STRING, answ2 AS STRING
    DIM kFlag2 AS INTEGER, k2 AS INTEGER, kFound2 AS INTEGER, l2 AS INTEGER, w2 AS INTEGER
    inpt2 = rply
    inpt2 = " " + inpt2 + " " '<< need this because keywords embedded in spaces to ID whole words only
    inpt2 = isolatePunctuation$(inpt2)
    FOR k2 = 1 TO kCnt2 'loop through key words until we find a match
        kFound2 = INSTR(LCASE$(inpt2), LCASE$(keywords2(k2)))
        IF kFound2 > 0 THEN '>>> need the following for * in some replies
            tail2 = " " + MID$(inpt2, kFound2 + LEN(keywords2(k2)))
            FOR l2 = 1 TO LEN(tail2) 'DO NOT USE INSTR
                FOR w2 = 1 TO wCnt2 'swap words in tail if used there
                    IF LCASE$(MID$(tail2, l2, LEN(wordIn2(w2)))) = LCASE$(wordIn2(w2)) THEN 'swap words exit for
                        tail2 = MID$(tail2, 1, l2 - 1) + wordOut2(w2) + MID$(tail2, l2 + LEN(wordIn2(w2)))
                        EXIT FOR
                    END IF
                NEXT w2
            NEXT l2
            kFlag2 = -1
            EXIT FOR
        END IF
    NEXT
    IF kFlag2 = 0 THEN k2 = NoKeyFoundIndex2
    answ2 = replies2(INT((rEnds2(k2) - rStarts2(k2) + 1) * RND) + rStarts2(k2))
    'set pointer to next reply in rIndex array
    IF k2 = NoKeyFoundIndex2 THEN 'let's not get too predictable for most used set of replies
        rIndex2(k2) = INT((rEnds2(k2) - rStarts2(k2) + 1) * RND) + rStarts2(k2)
    'ELSE
    '    rIndex2(k2) = rIndex2(k2) + 1 'set next reply index then check it
    '    IF rIndex2(k2) > rEnds2(k2) THEN rIndex2(k2) = rStarts2(k2)
    END IF
    IF RIGHT$(answ2, 1) <> "*" THEN GetReply2$ = answ2: EXIT FUNCTION 'oh so the * signal an append to reply!
    IF __TRIM(tail2) = "" THEN
        GetReply2$ = "Please elaborate on, " + keywords2(k2)
    ELSE
        tail2 = joinPunctuation$(tail2)
        GetReply2$ = MID$(answ2, 1, LEN(answ2) - 1) + tail2
    END IF

END FUNCTION

DIM rply2 AS STRING 'for main loop

DIM rply AS STRING '              for main loop
LoadArrays "Eliza Script.txt" '   check file load, OK checks out
LoadArrays2 "Parrany Script.txt"
PRINT Greeting: PRINT '           start testing main Eliza code
DO
    rply = GetReply$(rply2)
    PRINT Script + ": " + rply: PRINT
    Sleep (4)
    rply2 = GetReply2$(rply)
    PRINT "Parrany: " + rply2: PRINT
    Sleep (4)
LOOP UNTIL INKEY$ = CHR$(27)