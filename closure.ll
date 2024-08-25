%closure_context = type { i32 } ; Context structure holding one captured integer

declare i32 @printf(i8*, ...)
define void @print_int(i32 %a) {
    %fmt = alloca [13 x i8], align 1
    store [13 x i8] c"Result: %d\n\00", [13 x i8]* %fmt, align 1
    %fmt_ptr = getelementptr [13 x i8], [13 x i8]* %fmt, i32 0, i32 0
    call i32 @printf(i8* %fmt_ptr, i32 %a)
    ret void
}

define void @print_float(double %a) {
    %fmt = alloca [13 x i8], align 1
    store [13 x i8] c"Result: %f\n\00", [13 x i8]* %fmt, align 1
    %fmt_ptr = getelementptr [13 x i8], [13 x i8]* %fmt, i32 0, i32 0
    call i32 @printf(i8* %fmt_ptr, double %a)

    ret void
}

define void @closure_func(%closure_context* %ctx, i32 %arg) {
entry:
    %captured_value_ptr = getelementptr inbounds %closure_context, %closure_context* %ctx, i32 0, i32 0
    %captured_value = load i32, i32* %captured_value_ptr

    %result = add i32 %captured_value, %arg
    call void @print_int(i32 %result)

    ret void
}

define i32 @main() {
entry:
    %closure_context_ptr = alloca %closure_context
    %captured_value_ptr = getelementptr inbounds %closure_context, %closure_context* %closure_context_ptr, i32 0, i32 0
    store i32 5, i32* %captured_value_ptr

    call void @closure_func(%closure_context* %closure_context_ptr, i32 10)

    ret i32 0
}

