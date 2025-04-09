#!/usr/bin/env roseus

(require :jedy-interface)

(defun connect-and-reset ()
  (unless (boundp '*jedy*)
    (format t "jedy-init%")
    (jedy-init)
    )
  (send *ri* :servo-on)
  (unix:usleep (* 1000 1000))
  (send *jedy* :reset-pose)
  (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
  (send *ri* :wait-interpolation)
  )

(defun demo-loop()
  (do-until-key
   (format t "reset-pose~%")
   (send *jedy* :reset-pose)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)

   (format t "head~%")
   (send *jedy* :head_joint0 :joint-angle 90)
   (send *jedy* :head_joint1 :joint-angle 90)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)
   
   (format t "gripper-open~%")
   (send *jedy* :rarm_gripper_joint :joint-angle -70)
   (send *jedy* :larm_gripper_joint :joint-angle 70)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)

   (format t "gripper-close~%")
   (send *jedy* :rarm_gripper_joint :joint-angle 20)
   (send *jedy* :larm_gripper_joint :joint-angle -20)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)

   (format t "shoulder1~%")
   (send *jedy* :rarm_joint0 :joint-angle 135)
   (send *jedy* :larm_joint0 :joint-angle 0)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)
   
   (format t "shoulder2~%")
   (send *jedy* :rarm_joint0 :joint-angle 0)
   (send *jedy* :larm_joint0 :joint-angle -135)
   (send *ri* :angle-vector (send *jedy* :angle-vector) 3000)
   (send *ri* :wait-interpolation)
   
   )
  
  (format t "finish:reset-pose~%")
  (send *jedy* :reset-pose)
  (send *ri* :angle-vector (send *jedy* :angle-vector) 1000)
  (send *ri* :wait-interpolation)
  
  )

(defun demo-all()
  (connect-and-reset)
  (send *ri* :send-stretch :value 30)
  (unix:usleep (* 1000 3000))
  (demo-loop)
  )

(demo-all)
