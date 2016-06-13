(print "What is your name?")

(defvar *name* (read))

(print "What is your quest?")

(set *quest* (read))

(print "What is the air-speed velocity of an unladen swallow?")

(set *air-speed-velocit-of-an-unladen-swallow* (read))

(format t (*name* "~%"
		  *quest "~%"
		  *air-speed-velocit-of-an-unladen-swallow*))

