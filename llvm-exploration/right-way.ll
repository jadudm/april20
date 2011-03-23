@.str = private constant [4 x i8] c"%d\0A\00", align 1

@t1 = global i32 3
@t2 = global i32 5

define i32 @add (i32 %a, i32 %b) {
  %result = add i32 %a, %b
  ret i32 %result
}

define i32 @ident (i32 %n) {
  ret i32 %n
}

define i32 @main () {
entry:
  ; declare variables
  ; %runResult = alloca i32
;  %t1     = alloca i32
;  %t2     = alloca i32
;
;  store i32 3, i32* %t1, align 4
;  store i32 5, i32* %t2, align 4
;
;  %0 = load i32* %t1, align 4
;  %1 = load i32* %t2, align 4

  %t1 = load i32* @t1, align 4
  %t2 = load i32* @t2, align 4

  %t3 = call i32 @ident (i32 3)
  %t4 = call i32 @ident (i32 5)

  ; call function
  ; nounwind means ... never comes back with exceptional behavior
  %result = call i32 @add(i32 %t1, i32 %t2) nounwind

  %printResult = call i32 (i8*, ...)*
       @printf (i8* noalias getelementptr inbounds
                  ([4 x i8]* @.str, i64 0, i64 0),
                  i32 %result) nounwind

  ; It turns out Unix return codes are modulo 256.
  ret i32 0
}

declare i32 @printf (i8* nocapture, ...) nounwind
