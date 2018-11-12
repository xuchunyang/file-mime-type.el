;;; file-mime-type.el --- Get file's mime type via file(1)  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Xu Chunyang

;; Author: Xu Chunyang <mail@xuchunyang.me>
;; Version: 0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Get file's mime type via file(1):
;;
;; (file-mime-type user-init-file)
;; ;; => "text/x-lisp"
;;
;; (file-mime-type (expand-file-name "~/Pictures/org-mode-unicorn.svg"))
;; ;; => "image/svg+xml"

;;; Code:

(defun file-mime-type (file)
  "Return FILE mime type."
  ;; file(1) doesn't fail in such case
  (unless (file-readable-p file)
    (error "%s: No such file or no read permission" file))
  (with-temp-buffer
    (let ((exit (call-process "file" nil t nil "--brief" "--mime-type" file)))
      ;; Remove the final newline if any
      (when (eq (char-before) ?\n)
        (delete-char -1))
      (if (zerop exit)
          (buffer-string)
        (error "file: %s: %s" file (buffer-string))))))

(provide 'file-mime-type)
;;; file-mime-type.el ends here