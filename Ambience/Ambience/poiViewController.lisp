(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @poiViewController (clone @object))
(add-slot @poiViewController id -1)

(defmethod id ((pvc @poiViewController))
	id)
	
(defmethod pois-sort-list ((pvc @poiViewController))
	(error 'language-error :text "A language needs to be defined to sort pois"))
	
(defmethod display-poi ((pvc @poiViewController))
	(defvar *pois* (sql-select :columns (list "*")
	            :tables (list "Itinerary")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "id")
				                                     :right (sql-identifier :name id))))
	(loop for poi in *pois*
		do ((format t "~d" (print poi)))))
		
;;ADAPTATIONS
(with-context (@english)
	(defmethod poi-sort-list ((pvc @poiViewController))
		(sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "EN"))
								(sql-binary-operator :name '= :left (sql-identifier :name "id")														                                     :right (sql-identifier :name id)))))
)

(with-context (@french)
	(defmethod poi-sort-list ((pvc @poiViewController))
		(sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "FR"))
								(sql-binary-operator :name '= :left (sql-identifier :name "id")													                                     :right (sql-identifier :name id)))))
)

(with-context (@dutch)
	(defmethod poi-sort-list ((pvc @poiViewController))
		(sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (and (sql-binary-operator :name '= :left (sql-identifier :name "language")
					                                     :right (sql-identifier :name "NL"))
								(sql-binary-operator :name '= :left (sql-identifier :name "id")													                                     :right (sql-identifier :name id)))))
)

(with-context (@guidedTour)
	(defmethod display-poi ((pvc @poiViewController))
		(defvar *pois* (sql-select :columns (list "*")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "id")
					                                     :right (sql-identifier :name id))))
		(loop for poi in *pois*
			do ((format t "~d" (print poi))
				(format t "NEXT POI"))))
)

(with-context (@time)
	(defmethod display-poi ((pvc @poiViewController))
		(format t "Time Adaptation")
		(loop for poi in *pois*
			do ((format t "~d" (print poi)))))
)

(with-context (@kid)
	(defmethod display-poi ((pvc @poiViewController))
		(format t "Kid Adaptation")
		(loop for poi in *pois*
			do ((format t "~d" (print poi)))))
)
