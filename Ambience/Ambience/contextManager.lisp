(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl #:org.tymoonnext.chirp))
(in-package #:scg)

(defproto @contextManager (clone @object))
(add-slot @contextManager currentLocation ())
(add-slot @contextManager currentDay (get-decoded-time))
(add-slot @contextManager currentLanguage "EN")

(defmethod update-location ((cm @contextManager))
	(setf 'currentLocation (location)))
	
(defmethod set-language ((cm @contextManager) (lang))
	(setf currentLangiage lang)
	(update-language cm))
	
(defmethod update-language ((cm @contextManager))
	(cond ((eq 'currentLanguage "EN") (activate @english))
		((eq 'currentLanguage "FR") (activate @french))
		((eq 'currentLanguage "NL") (activate @dutch))))
		
(defmethod update-audience ((cm @contextManager) (audinece))
	(cond ((eq audience "KID") (activate @kid))
		((t) (deactivate @kid))))
		
(defmethod update-date ((cm @contextManager))
	(setf 'currentDay (get-decoded-time))
	(defvar *hour* (hour 'currentTime))
	(cond ((< *hour* 12) (activate @morning))
		((< *hour* 18) (activate @afternoon))
		((t) (activate @night))))
		
(defmethod update-connectivity-status ((cm @contextManager) (type))
	(cond ((eq type "CELLULAR") (activate @cellular))
		((eq type "WIFI") (activate @wifi))
		((eq type "NONE") (deactivate @wifi)
						(deactivate @cellular))))

(defmethod updae-memory ((cm @contextManger))
	)
	