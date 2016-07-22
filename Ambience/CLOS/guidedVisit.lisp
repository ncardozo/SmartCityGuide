(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @guidedVisit ()
	id
	itineraryList
	description
	annotations
	currentItinerary
	currentPoi)

(defun base-set-description-strategy ((gv @guidedVisit) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defun base-description-strategy ((gv @guidedVisit))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defun base-hide-itinerary-choice-strategy ((gv @guidedVisit) (hide))
	(if hide (format t "Displaying choice of itinerary option")
			(format t "No choice of itinerary option is display")))
			
(defun base-update-itineraries-strategy ((gv @guidedVisit) (itiList))
	(setf itineraryList itiList))
	
(defun base-add-poi-annotation-strategy ((gv @guidedVisit))
 	(defvar *pois* (itinerary-pois currentItinerary))
	(loop for x in pois
		do ((defvar *pos* (cons (latitude x) (longitude x)))
			(setf annotations (make-instance @annotation :poi (name x) :state (state x))))))
			
(defun base-set-itinerary-strategy ((gv @guidedVisit) (id))
	(defvar *iti* nil)
	(defvar *fun-set-description* (format nil "~dset-description-strategy" *lang-context*))
	(defvar *fun-description* (format nil "~ddescription-strategy" *lang-context*))
	(defvar *fun-kidslang-set-description* (format nil "~dset-description-strategy" *kidslang-context*))
	(defvar *fun-kidslang-description* (format nil "~ddescription-strategy" *kidslang-context*))
	(cond ((nilp (get-pos itineraryList id)) (setf *iti* (get-pos itineraryList id)))
		((t) (if (eq *kid-context* "kid-") (funcall (intern *fun-kidslang-set-description* (funcall (intenrn *fun-kidslang-description* *iti*)))) 
										(funcall (intern *fun-set-description* (funcall (intern *fun-description* *iti*)))))
			(format t "Itinerary count~d/~d" (1+ currentItinerary) (count itineraryList)))))
			
(defun base-check-nearest-poi-strategy ((gv @guidedVisit) (user @user))
	(defvar *location* (get-location user))
	(defvar *nearestPoi* nil)
	(defvar *minDistance* 0)
	(loop for poi in (get-itinerary-pois current-itinerary)
		do ((cond ((eq *nearesPoi* nil) (setf *nearestPoi* poi)
										(setf *minDistance* (distance-between poi *location*)))
					(t) (defvar *curDistance* (distance-between poi *location*))
						(cond ((< *curDistance* *minDistance*) (setf *nearesPoi* poi)
																(setf *minDistance* *curDistance*)))))))
																
(defun refresh-annotations ((gv @guidedVisit))
	(add-poi-annotations gv))

(defun next-poi ((gv @guidedVisit))
	(defvar *pois* (get-itinerary-pois currentItinerary))
	(cond ((eq currentItinerary (last *pois*)) (cancel-itinerary gv))
		((t) (setf currentPoi (1+ currentPoi))
			(refresh-annotations gv))))

(defun cancel-itinerary ((gv @guidedVisit))
	(setf currentItinerary 0)
	(set-itinerary gv)
	(format t "Choose itinerary"))

;;ADAPTATIONS
(defun english-description ((gv @guidedVisit))
	(sql-select :columns (list "description")
				:tables (list "GuidedVisit")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "EN"))))

(defun english-set-description ((gv @guidedVisit) (description))
	(sql-update :table "GuidedVisit"
				:columns (list "description")
				:values (list description)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "EN"))))
)

(defun french-description ((gv @guidedVisit))
	(sql-select :columns (list "description")
				:tables (list "GuidedVisit")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "FR"))))

(defun french-set-description ((gv @guidedVisit) (description))
	(sql-update :table "GuidedVisit"
				:columns (list "description")
				:values (list description)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "FR"))))

(defun dutch-description ((gv @guidedVisit))
	(sql-select :columns (list "description")
				:tables (list "GuidedVisit")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "NL"))))

(defun dutch-set-description ((gv @guidedVisit) (description))
	(sql-update :table "GuidedVisit"
				:columns (list "description")
				:values (list description)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
													:right (sql-identifier :name "NL"))))
