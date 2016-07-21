(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @schedule
	openingTimes)

(defun base-set-opening-times-strategy ((s @schedule) (times))
	(loop for ot in openingTimes 
			ti in times
			day in ("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Staurday" "Sunday")
		do ((if (and (eq (car ti) day) (eq (car ot) day)) (setf (cdr ot) (cdr ti))))))
		
(defun base-change-opening-times-strategy ((s @schedule) (day) (start) (end))
	(defvar *s* (cdr (nth day openingTimes)))
	(setf (car *s*) start)
	(setf (cdr *s*) end))
	
(defun base-in-schedule-p-strategy ((s @schedule) (date))
	(defvar *times* (cdr (nth (nth 4 date))))
	(if (and (<= (hours (car *times*)) (nth 3 date)) (>= (hours (cdr *times*)) (nth 3 date))) t nil))
