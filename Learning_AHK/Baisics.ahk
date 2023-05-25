#SingleInstance, Force


; For multiline HK u need return  
; For singleline HK u don't 
; return works as a pause


; win c p := open explorer to code prectise
#c::
Run, D:\path\to\CodePractise
return


; win c d := open dotfiles folder in vs code 
#d::
Run, D:\path\to\CodePractise\dotfile
return


