%MyStruct = type { i32, double }

declare i8* @malloc(i64)
declare void @free(i8*)
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

define %MyStruct* @allocate_struct() {
entry:
  %struct_size = getelementptr %MyStruct, %MyStruct* null, i32 1
  %size = ptrtoint %MyStruct* %struct_size to i64

  %mem = call i8* @malloc(i64 %size)
  %struct_ptr = bitcast i8* %mem to %MyStruct*
  ret %MyStruct* %struct_ptr
}

define void @set_struct_fields(%MyStruct* %struct_ptr) {
entry:
  %field1_ptr = getelementptr %MyStruct, %MyStruct* %struct_ptr, i32 0, i32 0

  store i32 42, i32* %field1_ptr

  %field2_ptr = getelementptr %MyStruct, %MyStruct* %struct_ptr, i32 0, i32 1

  store double 3.140000e+00, double* %field2_ptr

  ret void
}

define void @free_struct(%MyStruct* %ptr) {
entry:
  %mem = bitcast %MyStruct* %ptr to i8*

  call void @free(i8* %mem)

  ret void
}

define i32 @main() {
entry:
  %struct_ptr = call %MyStruct* @allocate_struct()

  call void @set_struct_fields(%MyStruct* %struct_ptr)

  call void @read_struct_fields(%MyStruct* %struct_ptr)

  call void @free_struct(%MyStruct* %struct_ptr)

  ret i32 0
}


define void @read_struct_fields(%MyStruct* %struct_ptr) {
entry:
    %field1_ptr = getelementptr %MyStruct, %MyStruct* %struct_ptr, i32 0, i32 0

    %field1_val = load i32, i32* %field1_ptr

    %field2_ptr = getelementptr %MyStruct, %MyStruct* %struct_ptr, i32 0, i32 1

    %field2_val = load double, double* %field2_ptr


    call void @print_int(i32 %field1_val)
    call void @print_float(double %field2_val)

    ret void
}

