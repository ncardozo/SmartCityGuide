(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @toolsViewController (clone @object))

(defmethod update-data-action ((tvc @toolsViewController))
	(format t "Displaying data regularly"))
	
(defmethod time-adaptation-toggled ((tvc @toolsViewController))
	(setf *time-context* "time-"))
	
(defmethod simple-interface-toggled ((tvc @toolsViewController))
	(setf *interface-context* "simple"))
	
(defmethod memory-adaptation-toggled ((tvc @toolsViewController))
	(setf *memory-context* "lowMemory-"))
	
(defmethod color-adaptation-toggled ((tvc @toolsViewController))
	(setf *color-context* "color-"))
	
;;ADAPTATIONS
(with-contest (@wifi)
	(defmethod update-data-action ((tvc @toolsViewController))
		(format t "Wifi connection available"))
)

(with-context (@cellular)
	(defmethod update-data-action ((tvc @toolsViewController))
		(format t "3G connection available"))
)

(with-context (@lowMemory)
	(defmethod update-data-action ((tvc @toolsViewController))
		(format t "WARNING: the device's memory is low"))
)	

(with-context (@lowBattery)
	(defmethod update-data-action ((tvc @tollsViewController))
		(format t "WARNING: the device's battery level is low"))
)	
