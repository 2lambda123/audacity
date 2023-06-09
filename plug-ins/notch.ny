$nyquist plug-in
$version 4
$type process
$preview linear
$name (_ "Notch Filter")
$debugbutton false
$author (_ "Steve Daulton and Bill Wharrie")
$release 2.3.0-1
$copyright (_ "GNU General Public License v2.0 or later")


;; License: GPL v2+
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
;;
;; For information about writing and modifying Nyquist plug-ins:
;; https://wiki.audacityteam.org/wiki/Nyquist_Plug-ins_Reference


$control frequency (_ "Frequency (Hz)") float-text "" 60 0 nil
$control q (_ "Q (higher value reduces width)") float-text "" 1 0.1 1000

(cond
  ((< frequency 0.1) (_ "Frequency must be at least 0.1 Hz."))
  ((>= frequency (/ *sound-srate* 2.0))
    (format nil (_ "Error:~%~%Frequency (~a Hz) is too high for track sample rate.~%~%~
                 Track sample rate is ~a Hz.~%~
                 Frequency must be less than ~a Hz.")
            frequency
            *sound-srate*
            (/ *sound-srate* 2.0)))
  (T  (notch2 *track* frequency q)))
