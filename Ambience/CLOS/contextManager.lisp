(in-package #:cl-user)
(defpackage #:scgs (:use #:org.tymoonnext.chirp)))
(in-package #:scgs)

(defclass @contextManger ()
	(currentLocation
	 currentDay
	 (currentLanguage :initform "EN"))

(defun base-update-location-strategy ((cm @contextManager))
	(setf 'currentLocation (location)))
	
(defun base-set-language-strategy ((cm @contextManager) (lang))
	(setf currentLanguage lang)
	(update-language cm))
	
(defun base-update-language-strategy ((cm @contextManager))
	(cond ((eq 'currentLanguage "EN") (setf *lang-context* "english-"))
		((eq 'currentLanguage "FR") (setf *lang-context* "french-"))
		((eq 'currentLanguage "NL") (setf *lang-context* "dutch-"))))
		
(defun base-update-audience-strategy ((cm @contextManager) (audinece))
	(cond ((eq audience "KID") (setf *kids-context* "kid-")
						(cond ((eq 'currentLanguage "EN") (setf *kidslang-context* "kidEnglish-"))
							((eq 'currentLanguage "FR") (setf *kidslang-context* "kidFrench-"))
							((eq 'currentLanguage "NL") (setf *kidslang-context* "kidDutch-"))))
		((t) (setf *lang-context* "base-"))))
		
(defun base-update-date-strategy ((cm @contextManager))
	(setf 'currentDay (get-decoded-time))
	(defvar *hour* (hour 'currentTime))
	(cond ((< *hour* 12) (setf *time-context* "morning-"))
		((< *hour* 18) (setf *time-context* "afternoon-"))
		((t) (setf *time-context* "night-"))))
		
(defun base-update-connectivity-status-strategy ((cm @contextManager) (type))
	(cond ((eq type "CELLULAR") (setf *connection-context* "3g-"))
		((eq type "WIFI") (setf *connection-context* "wifi-"))
		((eq type "NONE") (setf *connection-context* "base-"))))

(defun base-updae-memory-strategy ((cm @contextManger))
	(if (eq *memory-context* "lowMemory-") (setf *memory-context* "base-") (setf *memory-context* "lowMemory-")))
