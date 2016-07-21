(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @toolsViewController)

(defun base-update-data-action-strategy ((tvc @toolsViewController))
	(format t "Displaying data regularly"))
	
(defun base-time-adaptation-toggled-strategy ((tvc @toolsViewController))
	(setf *time-context* "time-"))
	
(defun base-simple-interface-toggled-strategy ((tvc @toolsViewController))
	(setf *interface-context* "simple"))
	
(defun base-memory-adaptation-toggled-strategy ((tvc @toolsViewController))
	(setf *memory-context* "lowMemory-"))
	
(defun base-color-adaptation-toggled-strategy ((tvc @toolsViewController))
	(setf *color-context* "color-"))
	
;;ADAPTATIONS
(defun wifi-update-data-action-strategy ((tvc @toolsViewController))
	(format t "Wifi connection available"))
	
(defun 3g-update-data-action-strategy ((tvc @toolsViewController))
	(format t "3G connection available"))
	
(defun lowMemory-update-data-action-strategy ((tvc @toolsViewController))
	(format t "WARNING: the device's memory is low"))
	
(defun lowBattery-update-data-action-strategy ((tvc @tollsViewController))
	(format t "WARNING: the device's battery level is low"))
	
