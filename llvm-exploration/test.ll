@.str = private constant [4 x i8] c"%d\0A\00", align 1

define i32 @add (i32 %a, i32 %b) {
  %result = add i32 %a, %b
  ret i32 %result
}

define i32 @main () {
  ; declare variables
  ; %runResult = alloca i32

  ; call function
  ; nounwind means ... never comes back with exceptional behavior
  %runResult = call i32 @add(i32 3, i32 5) nounwind

  %printResult = call i32 (i8*, ...)*
       @printf (i8* noalias getelementptr inbounds
                  ([4 x i8]* @.str, i64 0, i64 0),
                  i32 %runResult) nounwind

  ; It turns out Unix return codes are modulo 256.
  ret i32 0
}

declare i32 @printf (i8* nocapture, ...) nounwind
