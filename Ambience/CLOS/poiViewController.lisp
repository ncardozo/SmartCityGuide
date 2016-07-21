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
		do ((format t "~d" (print poi)))))
		
;;ADAPTATIONS
(defun englishpoi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "EN"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")														                                     	
														:right (sql-identifier :name id)))))

(defun poi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "FR"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")
                                     					:right (sql-identifier :name id)))))

(defun poi-sort-list-strategy ((pvc @poiViewController))
	(sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "NL"))
							(sql-binary-operator :name '= :left (sql-identifier :name "id")
					                                     :right (sql-identifier :name id)))))

(defun display-poi-strategy ((pvc @poiViewController))
	(defvar *pois* (sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "id")
					                                     :right (sql-identifier :name id))))
	(loop for poi in *pois*
		do ((format t "~d" (print poi))
			(format t "NEXT POI"))))

(defun display-poi-strategy ((pvc @poiViewController))
	(format t "Time Adaptation")
	(loop for poi in *pois*
		do ((format t "~d" (print poi)))))

(defun display-poi-strategy ((pvc @poiViewController))
	(format t "Kid Adaptation")
	(loop for poi in *pois*
		do ((format t "~d" (print poi)))))
