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
	(setf currentLangiage lang)
	(update-language cm))
	
(defun base-update-language-strategy ((cm @contextManager))
	(cond ((eq 'currentLanguage "EN") (activate @english))
		((eq 'currentLanguage "FR") (activate @french))
		((eq 'currentLanguage "NL") (activate @dutch))))
		
(defun base-update-audience-strategy ((cm @contextManager) (audinece))
	(cond ((eq audience "KID") (activate @kid))
		((t) (deactivate @kid))))
		
(defun base-update-date-strategy ((cm @contextManager))
	(setf 'currentDay (get-decoded-time))
	(defvar *hour* (hour 'currentTime))
	(cond ((< *hour* 12) (activate @morning))
		((< *hour* 18) (activate @afternoon))
		((t) (activate @night))))
		
(defun base-update-connectivity-status-strategy ((cm @contextManager) (type))
	(cond ((eq type "CELLULAR") (activate @cellular))
		((eq type "WIFI") (activate @wifi))
		((eq type "NONE") (deactivate @wifi)
						(deactivate @cellular))))

(defun base-updae-memory-strategy ((cm @contextManger))
	)
