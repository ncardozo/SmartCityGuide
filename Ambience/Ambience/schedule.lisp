(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @schedule (clone @object))
(add-slot @schedule openingTimes ())

(defmethod set-opening-times ((s @schedule) (times))
	(loop for ot in openingTimes 
			ti in times
			day in ("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Staurday" "Sunday")
		do ((if (and (eq (car ti) day) (eq (car ot) day)) (setf (cdr ot) (cdr ti))))))
		
(defmethod change-opening-times ((s @schedule) (day) (start) (end))
	(defvar *s* (cdr (nth day openingTimes)))
	(setf (car *s*) start)
	(setf (cdr *s*) end))
	
(defmethod in-schedule-p ((s @schedule) (date))
	(defvar *times* (cdr (nth (nth 4 date))))
	(if (and (<= (hours (car *times*)) (nth 3 date)) (>= (hours (cdr *times*)) (nth 3 date))) t nil))
	