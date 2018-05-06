.data
A:  .asciiz "Enter value for a:\n"
B:  .asciiz "Enter value for b:\n"
C:  .asciiz "Enter value for c:\n"
nd: .asciiz "and \n"
complex_msg: .asciiz "Complex roots please \n"
zero: .float 0
four: .float 4
two: .float 2
ans: .asciiz "The roots of the quadratic equation is"
.text
main:
l.s $f1,zero
l.s $f2,two
l.s $f3,four

#prompt user for value of a
li $v0,4
la $a0,A
syscall
li $v0,6
syscall
mov.s $f4,$f0

#prompt user for B
li $v0,4
la $a0,B
syscall
li $v0,6
syscall
mov.s $f5,$f0

#prompt user for C
li $v0,4
la $a0,C
syscall
li $v0,6
syscall
mov.s $f6,$f0


#b^2 = $f7
mul.s $f7,$f5,$f5 
#2a = $f8
mul.s $f8,$f2,$f4
#ac = $f4
mul.s $f4,$f4,$f6
#4ac = $f6
mul.s $f6,$f3,$f4
#compute d=b*b - 4ac and save it to $f9
sub.s $f9,$f7,$f6

#check the discriminant < 0
mfc1 $t1,$f9
blez $t1,complex_root
#get square root of d and save to $f9
sqrt.s $f9,$f9
#get -b
neg.s $f10,$f5

#compute x1 i.e -b+sqrt(d)
add.s $f20,$f10,$f9
div.s $f21,$f20,$f8
#compute x2 i.e -b-sqrt(d)
sub.s $f22,$f10,$f9
div.s $f23,$f22,$f8



#print the output to the user
li $v0,4
la $a0,ans
syscall

li $v0,2
mov.s $f12,$f21
syscall

li $v0,4
la $a0,nd
syscall

li $v0,2
mov.s $f12,$f23
syscall
b exit

complex_root:
li $v0,4
la $a0,complex_msg
syscall

exit:
li $v0,10
syscall