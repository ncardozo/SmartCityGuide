(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @guidedVisitViewController ()
	(itineraryList
	currentItinerary
	mapView
	currentPoi)
	
(defun base-next-poi-strategy ((gvvc @guidedVisitViewController) (currentPoi)) 
	(defvar *itiPois* nil)
	(cond ((eq *guidedTour-context* "guidedTour-") (base-get-itinerary-pois-strategy currentItinerary)
		(cond ((eq currentPoi (list-length *itiPois*)) (base-cancel-itinerary-strategy gvvc))
			((t) (setf currentPoi (1+ currentPoi))
				(setf activeItineraryPoiNb (1+ activeItineraryPoiNb))
				(refresh-annotations gvvc))))
		((t) (error 'tour-error :text "Not part of a tour"))))
			
(defun base-set-itinerary-strategy ((gvvc @guidedVisitViewController))
	(format t "~d" (description currentPoi))
	(remove-annotations mapView)
	(base-add-poi-annotations-strategy gvvc)
	(format t "~d/~d" (1+ currentItinerary) (list-length itineraryList)))
	
(defun base-cancel-itinerary-strategy ((gvvc @guidedVisitViewController))
	(cond ((eq *guidedTour-context* "guidedTour-") (set-itinerary gvvc)
												(format t "choose itinerary"))
		((t) (error 'tour-error :text "Not part of a tour"))))
	
(defun base-add-poi-annotations-strategy ((gvvc @guidedVisitViewController))	
	(defvar *poiList* (get-itinerary-pois currentItinerary))
	(setf annotations ())
	(loop for x in *poiList*
			i from 0 until (list-length *poiList*)
		do ((defvar *annotationPoi* (make-instance @annotation :poi x :index i))
			(add-annotations mapView *annotationpoi*)
			(cons *annodationPoi* annotations))))
			
(defun base-map-view-strategy ((gvvc @guidedVisitViewController) (annotation @annotation))
	(cond ((suptypep annotation 'MKUserLocation) (nil))
		((t) (defvar *pinView* (deque-reusable-annotation mapView "AnnotationIentifier"))
			(cond ((nilp *pinView*) (setf *pinView* (make-instance @annotation :annotation annotation :id "AnnotationIdentifier"))))
			(image *pinView* "number~d" (1+ (index annotation)))
			*pinView*)))

(defun guidedTour-check-nearest-poi-strategy ((gvvc @guidedVisitViewController))
	(defvar *location* (location (userLocation mapView)))
	(defvar *nearestPoi* nil)
	(defvar *nearestDistance* 0)
	(defvar *itineraryPois* (base-get-itinerary-pois-strategy currentItinerary))
	(loop for x in *itineraryPois*
		do ((cond ((*nearestPoi*) (setf *nearestpoi* x)
								(setf *nearestDistance* (base-distance-between-strategy x posX posY)))
				((t) (defvar *distance* (base-distance-between-strategy x posX posY))
					(cond ((< *distance* nearestDistance) (setf nearestPoi x)
														(setf *nearestDistance* *distance*))))))))
															
(defun guidedTour-map-view-strategy ((gvvc @guidedVisitViewController) (annotation @annotation))
	(cond ((suptypep annotation 'MKUserLocation) (nil))
		((t) (defvar *pinView* (deque-reusable-annotation mapView "AnnotationIentifier"))
			(if (nilp *pinView* (setf *pinView* (make-instance @annotation :id"AnnotationIdentifier")))
			(defvar *index* (1+ (index-itinerary annotation)))
			(defvar *image* "")
			(setf (show-calloutp *pinView*) t)
			(if (eq currentPoi *index*) (setf *image* "number~d" *index*) (setf *image* "number~d_grey" *index*))
			(setf (image *poiView*) *image*)
			*poiView*))))
