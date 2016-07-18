(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @guidedVisit (clone @object))
(add-slot @guidedVisit id -1)
(add-slot @guidedVisit itineraryList ())
(add-slot @guidedVisit description "")
(add-slot @guidedVisit annotations ())
(add-slot @guidedVisit currentItinerary nil)
(add-slot @guidedVisit currentPoi nil)

(defmethod set-description ((gv @guidedVisit) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defmethod description ((gv @guidedVisit))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defmethod hide-itinerary-choice ((gv @guidedVisit) (hide))
	(if hide (format t "Displaying choice of itinerary option")
			(format t "No choice of itinerary option is display")))
			
(defmethod update-itineraries ((gv @guidedVisit) (itiList))
	(setf itineraryList itiList))
	
(defmethod add-poi-annotation ((gv @guidedVisit))
 	(defvar *pois* (itinerary-pois currentItinerary))
	(loop for x in pois
		do ((defvar *pos* (cons (latitude x) (longitude x)))
			(setf annotations (make-instance @annotation :poi (name x) :state (state x))))))
			
(defmethod set-itinerary ((gv @guidedVisit) (id))
	(defvar *iti* nil)
	(cond ((nilp (get-pos itineraryList id)) (setf *iti* (get-pos itineraryList id)))
		((t) (set-description strategy (get-description *iti*))
			(format t "Itinerary count~d/~d" (1+ currentItinerary) (count itineraryList)))))
			
(defmethod check-nearest-poi ((gv @guidedVisit) (user @user))
	(defvar *location* (get-location user))
	(defvar *nearestPoi* nil)
	(defvar *minDistance* 0)
	(loop for poi in (get-itinerary-pois current-itinerary)
		do ((cond ((eq *nearesPoi* nil) (setf *nearestPoi* poi)
										(setf *minDistance* (distance-between poi *location*)))
					(t) (defvar *curDistance* (distance-between poi *location*))
						(cond ((< *curDistance* *minDistance*) (setf *nearesPoi* poi)
																(setf *minDistance* *curDistance*)))))))
																
(defmethod refresh-annotations ((gv @guidedVisit))
	(add-poi-annotations gv))
	
(defmethod next-poi ((gv @guidedVisit))
	(defvar *pois* (get-itinerary-pois currentItinerary))
	(cond ((eq currentItinerary (last *pois*)) (cancel-itinerary gv))
			((t) (setf currentPoi (1+ currentPoi))
				(refresh-annotations gv))))

(defmethod cancel-itinerary ((gv @guidedVisit))
	(setf currentItinerary 0)
	(set-itinerary gv)
	(format t "Choose itinerary"))
	
;;ADAPTATIONS
(with-context (@englis)
	(defmethod description ((gv @guidedVisit))
		(sql-select :columns (list "description")
		            :tables (list "GuidedVisit")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
					
	(defmethod set-description ((gv @guidedVisit) (description))
		(sql-update :table "GuidedVisit"
              		:columns (list "description")
              		:values (list description)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))
)

(with-context (@french)
	(defmethod description ((gv @guidedVisit))
		(sql-select :columns (list "description")
		            :tables (list "GuidedVisit")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR"))))
					
	(defmethod set-description ((gv @guidedVisit) (description))
		(sql-update :table "GuidedVisit"
              		:columns (list "description")
              		:values (list description)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))
)

(with-context (@dutch)
	(defmethod description ((gv @guidedVisit))
		(sql-select :columns (list "description")
		            :tables (list "GuidedVisit")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL"))))
					
	(defmethod set-description ((gv @guidedVisit) (description))
		(sql-update :table "GuidedVisit"
              		:columns (list "description")
              		:values (list description)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))
)
