(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @freeVisitViewController (clone @object))
(add-slot @freeVisitViewController annotations ())
(add-slot @freeVisitViewController poisList ())

(defmethod get-pin-look ((fvvc @freeVisitViewController) (poi @poi))
	"green_pin")

(defmethod add-poi-locations ((fvvc @freeVisitViewController))
	(setf 'annotations ())
	(loop for x in 'poisList
		do (cons x 'annotations)))
		
(with-context (@colored)
	(defmethod get-pin-color ((fvvc @freeVisitViewController) (poi @poi))
		(defvar *image* nil)
		(defvar *category* (category poi))
		(cond ((eq *category* "Culture") (setf *image* "green_pin"))
			((eq *category* "Diversion") (setf *image* "blue_pin"))
			((eq *category* "Shopping") (setf *image* "pink_pin"))
			((t) (setf *image* "yello_pin"))))
)
