(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @freeVisitViewController ()
	(annotations
	 poisList)

(defun base-get-pin-look-strategy ((fvvc @freeVisitViewController) (poi @poi))
	"green_pin")

(defun base-add-poi-locations-strategy ((fvvc @freeVisitViewController))
	(setf 'annotations ())
	(loop for x in 'poisList
		do (cons x 'annotations)))
		
(defun colored-get-pin-color-strategy ((fvvc @freeVisitViewController) (poi @poi))
	(defvar *image* nil)
	(defvar *category* (category poi))
	(cond ((eq *category* "Culture") (setf *image* "green_pin"))
		((eq *category* "Diversion") (setf *image* "blue_pin"))
		((eq *category* "Shopping") (setf *image* "pink_pin"))
		((t) (setf *image* "yello_pin"))))
