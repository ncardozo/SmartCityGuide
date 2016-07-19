(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @menuViewController ()
	pvc)

(defun base-load-tour-strategy ((mvc @menuViewController))
	(display-poi pvc 1))
	
;;ADAPTATIONS
(defun guidedTour-laod-tour-strategy ((mvc @menuViewController))
	(defvar *itineraryId*)
	(defvar *res* (sql-select :columns (list "id")
			            	:tables (list "Itinerary")
							:where (sql-binary-operator :name '= :left (sql-identifier :name "user")
					                                     	:right (sql-identifier :name (get-id user)))))
		(setf *itineraryId* (read-line t))
		(funcall (intern("GUIDEDTOUR-DISPLAY-POI-STRATEGY" num) 1 *itineraryId*)))

(defun freeVisit-load-tour-strategy ((mvc @menuViewController))
	(funcall (intern("BASE-DISPLAY-POI-STRATEGY" num) *itineraryId*)))
