$nyquist plug-in
$version 4
$type process
$preview linear
$name (_ "High-Pass Filter")
$debugbutton disabled
$author (_ "Dominic Mazzoni")
$release 2.3.0-1
$copyright (_ "GNU General Public License v2.0")

;; License: GPL v2
;; http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
;;
;; For information about writing and modifying Nyquist plug-ins:
;; https://wiki.audacityteam.org/wiki/Nyquist_Plug-ins_Reference


$control frequency (_ "Frequency (Hz)") float-text "" 1000 0 nil
$control rolloff (_ "Roll-off (dB per octave)") choice (("dB6" (_ "6 dB"))
                                                        ("dB12" (_ "12 dB"))
                                                        ("dB24" (_ "24 dB"))
                                                        ("dB36" (_ "36 dB"))
                                                        ("dB48" (_ "48 dB"))) 0


(cond
  ((< frequency 0.1) (_ "Frequency must be at least 0.1 Hz."))
  ((>= frequency (/ *sound-srate* 2.0))
      (format nil (_ "Error:~%~%Frequency (~a Hz) is too high for track sample rate.~%~%~
                   Track sample rate is ~a Hz~%~
                   Frequency must be less than ~a Hz.")
              frequency
              *sound-srate*
              (/ *sound-srate* 2.0)))
  (T  (funcall (nth rolloff '(hp highpass2 highpass4 highpass6 highpass8))
               *track* frequency)))
