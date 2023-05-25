#SingleInstance Force

; Variable instantiation
price := 100
discount := 20

; expression
netprice := price - price * discount / 100

; use format to display value of variable (My preferred way)
^l:: MsgBox Format("Netprice is {1}", netprice)

condition1 := netprice < 50
condition2 := IsSet(condition1)

^o:: {
    if (condition1 or condition2)
        ; you can concatenate to display value of variable also
        MsgBox netprice . " is pretty inexpensive." . condition2 . "is the value of condition2"
}