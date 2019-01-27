; ModuleID = 'Tiger jit'
source_filename = "Tiger jit"

@0 = private unnamed_addr constant [47 x i8] c"test/bubble_sort.tig::41.4: Array out of bound\00"
@1 = private unnamed_addr constant [49 x i8] c"test/bubble_sort.tig::41.437: Array out of bound\00"
@2 = private unnamed_addr constant [49 x i8] c"test/bubble_sort.tig::41.484: Array out of bound\00"
@3 = private unnamed_addr constant [49 x i8] c"test/bubble_sort.tig::41.635: Array out of bound\00"
@4 = private unnamed_addr constant [49 x i8] c"test/bubble_sort.tig::41.683: Array out of bound\00"
@5 = private unnamed_addr constant [49 x i8] c"test/bubble_sort.tig::41.996: Array out of bound\00"
@6 = private unnamed_addr constant [10 x i8] c"something\00"

declare void @tig_print_int(i32)

declare void @tig_print(i8*)

declare i32* @tig_init_array(i32, i32)

declare i32* @tig_init_record(i32)

declare i32 @tig_array_length(i8*)

declare i32 @tig_nillable(i8*)

declare void @tig_exit(i32)

declare void @tig_flush()

declare i8* @tig_getchar()

declare i32 @tig_ord(i8*)

declare i8* @tig_chr(i32)

declare i32 @tig_string_cmp(i8*, i8*)

declare i32 @tig_size(i8*)

declare i8* @tig_substring(i8*, i32, i32)

declare i8* @tig_concat(i8*, i8*)

declare i32 @tig_not(i32)

define i32 @main() {
entry:
  %_limit = alloca i32
  %i = alloca i32
  %arr = alloca { i32, i32* }*
  %frame_pointer = alloca { i32 }
  %0 = call { i32, i32* }* @create_array({ i32 }* %frame_pointer)
  store { i32, i32* }* %0, { i32, i32* }** %arr
  %arr1 = load { i32, i32* }*, { i32, i32* }** %arr
  call void @bubble_sort({ i32 }* %frame_pointer, { i32, i32* }* %arr1)
  %arr2 = load { i32, i32* }*, { i32, i32* }** %arr
  %1 = bitcast { i32, i32* }* %arr2 to i8*
  %2 = call i32 @tig_array_length(i8* %1)
  %minus_tmp = sub i32 %2, 1
  store i32 0, i32* %i
  %arr3 = load { i32, i32* }*, { i32, i32* }** %arr
  %3 = bitcast { i32, i32* }* %arr3 to i8*
  %4 = call i32 @tig_array_length(i8* %3)
  %minus_tmp4 = sub i32 %4, 1
  store i32 %minus_tmp4, i32* %_limit
  br label %test

break_loop:                                       ; No predecessors!
  ret i32 0

test:                                             ; preds = %continue, %entry
  %_limit5 = load i32, i32* %_limit
  %i6 = load i32, i32* %i
  %ge_tmp = icmp sge i32 %_limit5, %i6
  %bool_tmp = zext i1 %ge_tmp to i32
  %cond = icmp eq i32 %bool_tmp, 1
  br i1 %cond, label %loop, label %end

loop:                                             ; preds = %test
  %arr7 = load { i32, i32* }*, { i32, i32* }** %arr
  %i8 = load i32, i32* %i
  %array_size_ptr = getelementptr { i32, i32* }, { i32, i32* }* %arr7, i32 0, i32 0
  %arr_size = load i32, i32* %array_size_ptr
  %cond9 = icmp sge i32 %i8, %arr_size
  br i1 %cond9, label %error, label %continue

end:                                              ; preds = %test
  call void @tig_print(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @6, i32 0, i32 0))
  ret i32 0

error:                                            ; preds = %loop
  call void @tig_print(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @5, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue

continue:                                         ; preds = %error, %loop
  %array_pointer = getelementptr { i32, i32* }, { i32, i32* }* %arr7, i32 0, i32 1
  %arr_addr = load i32*, i32** %array_pointer
  %arr_ele_addr = getelementptr i32, i32* %arr_addr, i32 %i8
  %arr_ele = load i32, i32* %arr_ele_addr
  call void @tig_print_int(i32 %arr_ele)
  %i10 = load i32, i32* %i
  %add_tmp = add i32 %i10, 1
  store i32 %add_tmp, i32* %i
  br label %test
}

define { i32, i32* }* @create_array({ i32 }*) {
entry:
  %_limit = alloca i32
  %i7 = alloca i32
  %arr = alloca { i32, i32* }*
  %i = alloca i32
  %size = alloca i32
  %frame_pointer = alloca { { i32 }* }
  %arg_address = getelementptr { { i32 }* }, { { i32 }* }* %frame_pointer, i32 0, i32 0
  store { i32 }* %0, { i32 }** %arg_address
  store i32 8, i32* %size
  %size1 = load i32, i32* %size
  %mallocsize = mul i32 %size1, ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32)
  %malloccall = tail call i8* @malloc(i32 %mallocsize)
  %array_init = bitcast i8* %malloccall to i32*
  store i32 0, i32* %i
  br label %test

test:                                             ; preds = %loop, %entry
  %i2 = load i32, i32* %i
  %lt_tmp = icmp slt i32 %i2, %size1
  %bool_tmp = zext i1 %lt_tmp to i32
  %cond = icmp eq i32 %bool_tmp, 1
  br i1 %cond, label %loop, label %end

loop:                                             ; preds = %test
  %i3 = load i32, i32* %i
  %Element = getelementptr i32, i32* %array_init, i32 %i3
  store i32 1, i32* %Element
  %add_tmp = add i32 %i3, 1
  store i32 %add_tmp, i32* %i
  br label %test

end:                                              ; preds = %test
  %malloccall4 = tail call i8* @malloc(i32 ptrtoint ({ i32, i32* }* getelementptr ({ i32, i32* }, { i32, i32* }* null, i32 1) to i32))
  %array_wrapper = bitcast i8* %malloccall4 to { i32, i32* }*
  %array_info = getelementptr { i32, i32* }, { i32, i32* }* %array_wrapper, i32 0, i32 0
  store i32 %size1, i32* %array_info
  %array_info5 = getelementptr { i32, i32* }, { i32, i32* }* %array_wrapper, i32 0, i32 1
  store i32* %array_init, i32** %array_info5
  store { i32, i32* }* %array_wrapper, { i32, i32* }** %arr
  %size6 = load i32, i32* %size
  %minus_tmp = sub i32 %size6, 1
  store i32 0, i32* %i7
  %size8 = load i32, i32* %size
  %minus_tmp9 = sub i32 %size8, 1
  store i32 %minus_tmp9, i32* %_limit
  br label %test10

test10:                                           ; preds = %continue, %end
  %_limit13 = load i32, i32* %_limit
  %i14 = load i32, i32* %i7
  %ge_tmp = icmp sge i32 %_limit13, %i14
  %bool_tmp15 = zext i1 %ge_tmp to i32
  %cond16 = icmp eq i32 %bool_tmp15, 1
  br i1 %cond16, label %loop11, label %end12

loop11:                                           ; preds = %test10
  %i17 = load i32, i32* %i7
  %load_left = load { i32, i32* }*, { i32, i32* }** %arr
  %array_size_ptr = getelementptr { i32, i32* }, { i32, i32* }* %load_left, i32 0, i32 0
  %arr_size = load i32, i32* %array_size_ptr
  %cond18 = icmp sge i32 %i17, %arr_size
  br i1 %cond18, label %error, label %continue

end12:                                            ; preds = %test10
  %arr24 = load { i32, i32* }*, { i32, i32* }** %arr
  ret { i32, i32* }* %arr24

error:                                            ; preds = %loop11
  call void @tig_print(i8* getelementptr inbounds ([47 x i8], [47 x i8]* @0, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue

continue:                                         ; preds = %error, %loop11
  %array_addr_ptr = getelementptr { i32, i32* }, { i32, i32* }* %load_left, i32 0, i32 1
  %arr_addr = load i32*, i32** %array_addr_ptr
  %arr_ele_addr = getelementptr i32, i32* %arr_addr, i32 %i17
  %size19 = load i32, i32* %size
  %i20 = load i32, i32* %i7
  %minus_tmp21 = sub i32 %size19, %i20
  store i32 %minus_tmp21, i32* %arr_ele_addr
  %i22 = load i32, i32* %i7
  %add_tmp23 = add i32 %i22, 1
  store i32 %add_tmp23, i32* %i7
  br label %test10
}

define void @bubble_sort({ i32 }*, { i32, i32* }*) {
entry:
  %if_result_addr = alloca i32
  %next = alloca i32
  %current = alloca i32
  %_limit = alloca i32
  %i = alloca i32
  %is_sorted = alloca i32
  %arr_size = alloca i32
  %should_stop = alloca i32
  %arr = alloca { i32, i32* }*
  %frame_pointer = alloca { { i32 }* }
  %arg_address = getelementptr { { i32 }* }, { { i32 }* }* %frame_pointer, i32 0, i32 0
  store { i32 }* %0, { i32 }** %arg_address
  store { i32, i32* }* %1, { i32, i32* }** %arr
  store i32 0, i32* %should_stop
  %arr1 = load { i32, i32* }*, { i32, i32* }** %arr
  %2 = bitcast { i32, i32* }* %arr1 to i8*
  %3 = call i32 @tig_array_length(i8* %2)
  store i32 %3, i32* %arr_size
  br label %test

test:                                             ; preds = %end8, %entry
  %should_stop2 = load i32, i32* %should_stop
  %4 = call i32 @tig_not(i32 %should_stop2)
  %cond = icmp eq i32 %4, 1
  br i1 %cond, label %loop, label %end

loop:                                             ; preds = %test
  store i32 1, i32* %is_sorted
  %arr_size3 = load i32, i32* %arr_size
  %minus_tmp = sub i32 %arr_size3, 2
  store i32 0, i32* %i
  %arr_size4 = load i32, i32* %arr_size
  %minus_tmp5 = sub i32 %arr_size4, 2
  store i32 %minus_tmp5, i32* %_limit
  br label %test6

end:                                              ; preds = %test
  ret void

test6:                                            ; preds = %merge, %loop
  %_limit9 = load i32, i32* %_limit
  %i10 = load i32, i32* %i
  %ge_tmp = icmp sge i32 %_limit9, %i10
  %bool_tmp = zext i1 %ge_tmp to i32
  %cond11 = icmp eq i32 %bool_tmp, 1
  br i1 %cond11, label %loop7, label %end8

loop7:                                            ; preds = %test6
  %arr12 = load { i32, i32* }*, { i32, i32* }** %arr
  %i13 = load i32, i32* %i
  %array_size_ptr = getelementptr { i32, i32* }, { i32, i32* }* %arr12, i32 0, i32 0
  %arr_size14 = load i32, i32* %array_size_ptr
  %cond15 = icmp sge i32 %i13, %arr_size14
  br i1 %cond15, label %error, label %continue

end8:                                             ; preds = %test6
  %is_sorted55 = load i32, i32* %is_sorted
  store i32 %is_sorted55, i32* %should_stop
  br label %test

error:                                            ; preds = %loop7
  call void @tig_print(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @1, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue

continue:                                         ; preds = %error, %loop7
  %array_pointer = getelementptr { i32, i32* }, { i32, i32* }* %arr12, i32 0, i32 1
  %arr_addr = load i32*, i32** %array_pointer
  %arr_ele_addr = getelementptr i32, i32* %arr_addr, i32 %i13
  %arr_ele = load i32, i32* %arr_ele_addr
  store i32 %arr_ele, i32* %current
  %arr16 = load { i32, i32* }*, { i32, i32* }** %arr
  %i17 = load i32, i32* %i
  %add_tmp = add i32 %i17, 1
  %array_size_ptr18 = getelementptr { i32, i32* }, { i32, i32* }* %arr16, i32 0, i32 0
  %arr_size19 = load i32, i32* %array_size_ptr18
  %cond22 = icmp sge i32 %add_tmp, %arr_size19
  br i1 %cond22, label %error20, label %continue21

error20:                                          ; preds = %continue
  call void @tig_print(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @2, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue21

continue21:                                       ; preds = %error20, %continue
  %array_pointer23 = getelementptr { i32, i32* }, { i32, i32* }* %arr16, i32 0, i32 1
  %arr_addr24 = load i32*, i32** %array_pointer23
  %arr_ele_addr25 = getelementptr i32, i32* %arr_addr24, i32 %add_tmp
  %arr_ele26 = load i32, i32* %arr_ele_addr25
  store i32 %arr_ele26, i32* %next
  br label %test27

test27:                                           ; preds = %continue21
  %current28 = load i32, i32* %current
  %next29 = load i32, i32* %next
  %gt_tmp = icmp sgt i32 %current28, %next29
  %bool_tmp30 = zext i1 %gt_tmp to i32
  %cond31 = icmp eq i32 %bool_tmp30, 1
  br i1 %cond31, label %then, label %else

then:                                             ; preds = %test27
  %i32 = load i32, i32* %i
  %load_left = load { i32, i32* }*, { i32, i32* }** %arr
  %array_size_ptr33 = getelementptr { i32, i32* }, { i32, i32* }* %load_left, i32 0, i32 0
  %arr_size34 = load i32, i32* %array_size_ptr33
  %cond37 = icmp sge i32 %i32, %arr_size34
  br i1 %cond37, label %error35, label %continue36

else:                                             ; preds = %test27
  store i32 0, i32* %if_result_addr
  br label %merge

merge:                                            ; preds = %else, %continue47
  %if_result = load i32, i32* %if_result_addr
  %i53 = load i32, i32* %i
  %add_tmp54 = add i32 %i53, 1
  store i32 %add_tmp54, i32* %i
  br label %test6

error35:                                          ; preds = %then
  call void @tig_print(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @3, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue36

continue36:                                       ; preds = %error35, %then
  %array_addr_ptr = getelementptr { i32, i32* }, { i32, i32* }* %load_left, i32 0, i32 1
  %arr_addr38 = load i32*, i32** %array_addr_ptr
  %arr_ele_addr39 = getelementptr i32, i32* %arr_addr38, i32 %i32
  %next40 = load i32, i32* %next
  store i32 %next40, i32* %arr_ele_addr39
  %i41 = load i32, i32* %i
  %add_tmp42 = add i32 %i41, 1
  %load_left43 = load { i32, i32* }*, { i32, i32* }** %arr
  %array_size_ptr44 = getelementptr { i32, i32* }, { i32, i32* }* %load_left43, i32 0, i32 0
  %arr_size45 = load i32, i32* %array_size_ptr44
  %cond48 = icmp sge i32 %add_tmp42, %arr_size45
  br i1 %cond48, label %error46, label %continue47

error46:                                          ; preds = %continue36
  call void @tig_print(i8* getelementptr inbounds ([49 x i8], [49 x i8]* @4, i32 0, i32 0))
  call void @tig_exit(i32 1)
  br label %continue47

continue47:                                       ; preds = %error46, %continue36
  %array_addr_ptr49 = getelementptr { i32, i32* }, { i32, i32* }* %load_left43, i32 0, i32 1
  %arr_addr50 = load i32*, i32** %array_addr_ptr49
  %arr_ele_addr51 = getelementptr i32, i32* %arr_addr50, i32 %add_tmp42
  %current52 = load i32, i32* %current
  store i32 %current52, i32* %arr_ele_addr51
  store i32 0, i32* %is_sorted
  store i32 0, i32* %if_result_addr
  br label %merge
}

declare noalias i8* @malloc(i32)
