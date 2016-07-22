(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @poiViewController
	id)

(defun base-id-strategy ((pvc @poiViewController))
	id)
	
(defun base-pois-sort-list-strategy ((pvc @poiViewController))
	(error 'language-error :text "A language needs to be defined to sort pois"))
	
(defun base-display-poi-strategy ((pvc @poiViewController))
	(defvar *pois* (sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "id")
				                                     :right (sql-identifier :name id))))
	(loop for poi in *pois*
		do ((format t "~d" (base-print-strategy poi)))))
		
;;ADAPTATIONS
(defun english-poi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "EN"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")														                                     	
														:right (sql-identifier :name id)))))

(defun french-poi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "FR"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")
                                     					:right (sql-identifier :name id)))))

(defun dutch-poi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "NL"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")
					                                     :right (sql-identifier :name id)))))

(defun guidedTour-display-poi-strategy ((pvc @poiViewController))
	(defvar *pois* (sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "id")
					                                     :right (sql-identifier :name id))))
	(loop for poi in *pois*
		do ((format t "~d" (guidedTour-print-strategy poi))
			(format t "NEXT POI"))))

(defun time-display-poi-strategy ((pvc @poiViewController))
	(format t "Time Adaptation")
	(loop for poi in *pois*
		do ((format t "~d" (time-print-strategy poi)))))

(defun kid-display-poi-strategy ((pvc @poiViewController))
	(format t "Kid Adaptation")
	(loop for poi in *pois*
		do ((format t "~d" (kids-print-strategy poi)))))
