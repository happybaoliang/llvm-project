; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -dse -enable-dse-partial-store-merging=false < %s | FileCheck %s
target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64-bgq-linux"

%"struct.std::complex" = type { { float, float } }

define void @_Z4testSt7complexIfE(%"struct.std::complex"* noalias nocapture sret %agg.result, i64 %c.coerce) {
; CHECK-LABEL: @_Z4testSt7complexIfE(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REF_TMP:%.*]] = alloca i64, align 8
; CHECK-NEXT:    [[TMPCAST:%.*]] = bitcast i64* [[REF_TMP]] to %"struct.std::complex"*
; CHECK-NEXT:    [[C_SROA_0_0_EXTRACT_SHIFT:%.*]] = lshr i64 [[C_COERCE:%.*]], 32
; CHECK-NEXT:    [[C_SROA_0_0_EXTRACT_TRUNC:%.*]] = trunc i64 [[C_SROA_0_0_EXTRACT_SHIFT]] to i32
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32 [[C_SROA_0_0_EXTRACT_TRUNC]] to float
; CHECK-NEXT:    [[C_SROA_2_0_EXTRACT_TRUNC:%.*]] = trunc i64 [[C_COERCE]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i32 [[C_SROA_2_0_EXTRACT_TRUNC]] to float
; CHECK-NEXT:    call void @_Z3barSt7complexIfE(%"struct.std::complex"* nonnull sret [[TMPCAST]], i64 [[C_COERCE]])
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, i64* [[REF_TMP]], align 8
; CHECK-NEXT:    [[_M_VALUE_REALP_I_I:%.*]] = getelementptr inbounds %"struct.std::complex", %"struct.std::complex"* [[AGG_RESULT:%.*]], i64 0, i32 0, i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP2]], 32
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i64 [[TMP3]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i32 [[TMP4]] to float
; CHECK-NEXT:    [[_M_VALUE_IMAGP_I_I:%.*]] = getelementptr inbounds %"struct.std::complex", %"struct.std::complex"* [[AGG_RESULT]], i64 0, i32 0, i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i32 [[TMP6]] to float
; CHECK-NEXT:    [[MUL_AD_I_I:%.*]] = fmul fast float [[TMP5]], [[TMP1]]
; CHECK-NEXT:    [[MUL_BC_I_I:%.*]] = fmul fast float [[TMP7]], [[TMP0]]
; CHECK-NEXT:    [[MUL_I_I_I:%.*]] = fadd fast float [[MUL_AD_I_I]], [[MUL_BC_I_I]]
; CHECK-NEXT:    [[MUL_AC_I_I:%.*]] = fmul fast float [[TMP5]], [[TMP0]]
; CHECK-NEXT:    [[MUL_BD_I_I:%.*]] = fmul fast float [[TMP7]], [[TMP1]]
; CHECK-NEXT:    [[MUL_R_I_I:%.*]] = fsub fast float [[MUL_AC_I_I]], [[MUL_BD_I_I]]
; CHECK-NEXT:    store float [[MUL_R_I_I]], float* [[_M_VALUE_REALP_I_I]], align 4
; CHECK-NEXT:    store float [[MUL_I_I_I]], float* [[_M_VALUE_IMAGP_I_I]], align 4
; CHECK-NEXT:    ret void
;
entry:

  %ref.tmp = alloca i64, align 8
  %tmpcast = bitcast i64* %ref.tmp to %"struct.std::complex"*
  %c.sroa.0.0.extract.shift = lshr i64 %c.coerce, 32
  %c.sroa.0.0.extract.trunc = trunc i64 %c.sroa.0.0.extract.shift to i32
  %0 = bitcast i32 %c.sroa.0.0.extract.trunc to float
  %c.sroa.2.0.extract.trunc = trunc i64 %c.coerce to i32
  %1 = bitcast i32 %c.sroa.2.0.extract.trunc to float
  call void @_Z3barSt7complexIfE(%"struct.std::complex"* nonnull sret %tmpcast, i64 %c.coerce)
  %2 = bitcast %"struct.std::complex"* %agg.result to i64*
  %3 = load i64, i64* %ref.tmp, align 8
  store i64 %3, i64* %2, align 4

  %_M_value.realp.i.i = getelementptr inbounds %"struct.std::complex", %"struct.std::complex"* %agg.result, i64 0, i32 0, i32 0
  %4 = lshr i64 %3, 32
  %5 = trunc i64 %4 to i32
  %6 = bitcast i32 %5 to float
  %_M_value.imagp.i.i = getelementptr inbounds %"struct.std::complex", %"struct.std::complex"* %agg.result, i64 0, i32 0, i32 1
  %7 = trunc i64 %3 to i32
  %8 = bitcast i32 %7 to float
  %mul_ad.i.i = fmul fast float %6, %1
  %mul_bc.i.i = fmul fast float %8, %0
  %mul_i.i.i = fadd fast float %mul_ad.i.i, %mul_bc.i.i
  %mul_ac.i.i = fmul fast float %6, %0
  %mul_bd.i.i = fmul fast float %8, %1
  %mul_r.i.i = fsub fast float %mul_ac.i.i, %mul_bd.i.i
  store float %mul_r.i.i, float* %_M_value.realp.i.i, align 4
  store float %mul_i.i.i, float* %_M_value.imagp.i.i, align 4
  ret void
}

declare void @_Z3barSt7complexIfE(%"struct.std::complex"* sret, i64)

define void @test1(i32 *%ptr) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    [[WPTR:%.*]] = bitcast i32* [[PTR]] to i16*
; CHECK-NEXT:    store i16 -30062, i16* [[WPTR]]
; CHECK-NEXT:    [[BPTR3:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 3
; CHECK-NEXT:    store i8 47, i8* [[BPTR3]]
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 1
; CHECK-NEXT:    [[WPTRP:%.*]] = bitcast i8* [[BPTR1]] to i16*
; CHECK-NEXT:    store i16 2020, i16* [[WPTRP]], align 1
; CHECK-NEXT:    ret void
;
entry:

  store i32 5, i32* %ptr
  %bptr = bitcast i32* %ptr to i8*
  store i8 7, i8* %bptr
  %wptr = bitcast i32* %ptr to i16*
  store i16 -30062, i16* %wptr
  %bptr2 = getelementptr inbounds i8, i8* %bptr, i64 2
  store i8 25, i8* %bptr2
  %bptr3 = getelementptr inbounds i8, i8* %bptr, i64 3
  store i8 47, i8* %bptr3
  %bptr1 = getelementptr inbounds i8, i8* %bptr, i64 1
  %wptrp = bitcast i8* %bptr1 to i16*
  store i16 2020, i16* %wptrp, align 1
  ret void


}

define void @test2(i32 *%ptr) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    [[BPTRM1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 -1
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 1
; CHECK-NEXT:    [[BPTR2:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 2
; CHECK-NEXT:    [[BPTR3:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 3
; CHECK-NEXT:    [[WPTR:%.*]] = bitcast i8* [[BPTR]] to i16*
; CHECK-NEXT:    [[WPTRM1:%.*]] = bitcast i8* [[BPTRM1]] to i16*
; CHECK-NEXT:    [[WPTR1:%.*]] = bitcast i8* [[BPTR1]] to i16*
; CHECK-NEXT:    [[WPTR2:%.*]] = bitcast i8* [[BPTR2]] to i16*
; CHECK-NEXT:    [[WPTR3:%.*]] = bitcast i8* [[BPTR3]] to i16*
; CHECK-NEXT:    store i16 1456, i16* [[WPTRM1]], align 1
; CHECK-NEXT:    store i16 1346, i16* [[WPTR]], align 1
; CHECK-NEXT:    store i16 1756, i16* [[WPTR1]], align 1
; CHECK-NEXT:    store i16 1126, i16* [[WPTR2]], align 1
; CHECK-NEXT:    store i16 5656, i16* [[WPTR3]], align 1
; CHECK-NEXT:    ret void
;
entry:

  store i32 5, i32* %ptr

  %bptr = bitcast i32* %ptr to i8*
  %bptrm1 = getelementptr inbounds i8, i8* %bptr, i64 -1
  %bptr1 = getelementptr inbounds i8, i8* %bptr, i64 1
  %bptr2 = getelementptr inbounds i8, i8* %bptr, i64 2
  %bptr3 = getelementptr inbounds i8, i8* %bptr, i64 3

  %wptr = bitcast i8* %bptr to i16*
  %wptrm1 = bitcast i8* %bptrm1 to i16*
  %wptr1 = bitcast i8* %bptr1 to i16*
  %wptr2 = bitcast i8* %bptr2 to i16*
  %wptr3 = bitcast i8* %bptr3 to i16*

  store i16 1456, i16* %wptrm1, align 1
  store i16 1346, i16* %wptr, align 1
  store i16 1756, i16* %wptr1, align 1
  store i16 1126, i16* %wptr2, align 1
  store i16 5656, i16* %wptr3, align 1



  ret void

}

define signext i8 @test3(i32 *%ptr) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 5, i32* [[PTR:%.*]]
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i32* [[PTR]] to i8*
; CHECK-NEXT:    [[BPTRM1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 -1
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 1
; CHECK-NEXT:    [[BPTR2:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 2
; CHECK-NEXT:    [[BPTR3:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 3
; CHECK-NEXT:    [[WPTR:%.*]] = bitcast i8* [[BPTR]] to i16*
; CHECK-NEXT:    [[WPTRM1:%.*]] = bitcast i8* [[BPTRM1]] to i16*
; CHECK-NEXT:    [[WPTR1:%.*]] = bitcast i8* [[BPTR1]] to i16*
; CHECK-NEXT:    [[WPTR2:%.*]] = bitcast i8* [[BPTR2]] to i16*
; CHECK-NEXT:    [[WPTR3:%.*]] = bitcast i8* [[BPTR3]] to i16*
; CHECK-NEXT:    [[V:%.*]] = load i8, i8* [[BPTR]], align 1
; CHECK-NEXT:    store i16 1456, i16* [[WPTRM1]], align 1
; CHECK-NEXT:    store i16 1346, i16* [[WPTR]], align 1
; CHECK-NEXT:    store i16 1756, i16* [[WPTR1]], align 1
; CHECK-NEXT:    store i16 1126, i16* [[WPTR2]], align 1
; CHECK-NEXT:    store i16 5656, i16* [[WPTR3]], align 1
; CHECK-NEXT:    ret i8 [[V]]
;
entry:

  store i32 5, i32* %ptr

  %bptr = bitcast i32* %ptr to i8*
  %bptrm1 = getelementptr inbounds i8, i8* %bptr, i64 -1
  %bptr1 = getelementptr inbounds i8, i8* %bptr, i64 1
  %bptr2 = getelementptr inbounds i8, i8* %bptr, i64 2
  %bptr3 = getelementptr inbounds i8, i8* %bptr, i64 3

  %wptr = bitcast i8* %bptr to i16*
  %wptrm1 = bitcast i8* %bptrm1 to i16*
  %wptr1 = bitcast i8* %bptr1 to i16*
  %wptr2 = bitcast i8* %bptr2 to i16*
  %wptr3 = bitcast i8* %bptr3 to i16*

  %v = load i8, i8* %bptr, align 1
  store i16 1456, i16* %wptrm1, align 1
  store i16 1346, i16* %wptr, align 1
  store i16 1756, i16* %wptr1, align 1
  store i16 1126, i16* %wptr2, align 1
  store i16 5656, i16* %wptr3, align 1


  ret i8 %v

}

%struct.foostruct = type {
i32 (i8*, i8**, i32, i8, i8*)*,
i32 (i8*, i8**, i32, i8, i8*)*,
i32 (i8*, i8**, i32, i8, i8*)*,
i32 (i8*, i8**, i32, i8, i8*)*,
void (i8*, i32, i32)*
}
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i1)
declare void @goFunc(%struct.foostruct*)
declare i32 @fa(i8*, i8**, i32, i8, i8*)

define void @test4()  {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BANG:%.*]] = alloca [[STRUCT_FOOSTRUCT:%.*]], align 8
; CHECK-NEXT:    [[V2:%.*]] = getelementptr inbounds [[STRUCT_FOOSTRUCT]], %struct.foostruct* [[BANG]], i64 0, i32 0
; CHECK-NEXT:    store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** [[V2]], align 8
; CHECK-NEXT:    [[V3:%.*]] = getelementptr inbounds [[STRUCT_FOOSTRUCT]], %struct.foostruct* [[BANG]], i64 0, i32 1
; CHECK-NEXT:    store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** [[V3]], align 8
; CHECK-NEXT:    [[V4:%.*]] = getelementptr inbounds [[STRUCT_FOOSTRUCT]], %struct.foostruct* [[BANG]], i64 0, i32 2
; CHECK-NEXT:    store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** [[V4]], align 8
; CHECK-NEXT:    [[V5:%.*]] = getelementptr inbounds [[STRUCT_FOOSTRUCT]], %struct.foostruct* [[BANG]], i64 0, i32 3
; CHECK-NEXT:    store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** [[V5]], align 8
; CHECK-NEXT:    [[V6:%.*]] = getelementptr inbounds [[STRUCT_FOOSTRUCT]], %struct.foostruct* [[BANG]], i64 0, i32 4
; CHECK-NEXT:    store void (i8*, i32, i32)* null, void (i8*, i32, i32)** [[V6]], align 8
; CHECK-NEXT:    call void @goFunc(%struct.foostruct* [[BANG]])
; CHECK-NEXT:    ret void
;
entry:

  %bang = alloca %struct.foostruct, align 8
  %v1 = bitcast %struct.foostruct* %bang to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %v1, i8 0, i64 40, i1 false)
  %v2 = getelementptr inbounds %struct.foostruct, %struct.foostruct* %bang, i64 0, i32 0
  store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** %v2, align 8
  %v3 = getelementptr inbounds %struct.foostruct, %struct.foostruct* %bang, i64 0, i32 1
  store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** %v3, align 8
  %v4 = getelementptr inbounds %struct.foostruct, %struct.foostruct* %bang, i64 0, i32 2
  store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** %v4, align 8
  %v5 = getelementptr inbounds %struct.foostruct, %struct.foostruct* %bang, i64 0, i32 3
  store i32 (i8*, i8**, i32, i8, i8*)* @fa, i32 (i8*, i8**, i32, i8, i8*)** %v5, align 8
  %v6 = getelementptr inbounds %struct.foostruct, %struct.foostruct* %bang, i64 0, i32 4
  store void (i8*, i32, i32)* null, void (i8*, i32, i32)** %v6, align 8
  call void @goFunc(%struct.foostruct* %bang)
  ret void

}

define signext i8 @test5(i32 *%ptr) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i32* [[PTR:%.*]] to i8*
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 1
; CHECK-NEXT:    [[BPTR2:%.*]] = getelementptr inbounds i8, i8* [[BPTR]], i64 2
; CHECK-NEXT:    [[WPTR:%.*]] = bitcast i8* [[BPTR]] to i16*
; CHECK-NEXT:    [[WPTR1:%.*]] = bitcast i8* [[BPTR1]] to i16*
; CHECK-NEXT:    [[WPTR2:%.*]] = bitcast i8* [[BPTR2]] to i16*
; CHECK-NEXT:    store i16 -1, i16* [[WPTR2]], align 1
; CHECK-NEXT:    store i16 1456, i16* [[WPTR1]], align 1
; CHECK-NEXT:    store i16 1346, i16* [[WPTR]], align 1
; CHECK-NEXT:    ret i8 0
;
entry:

  store i32 0, i32* %ptr

  %bptr = bitcast i32* %ptr to i8*
  %bptr1 = getelementptr inbounds i8, i8* %bptr, i64 1
  %bptr2 = getelementptr inbounds i8, i8* %bptr, i64 2
  %bptr3 = getelementptr inbounds i8, i8* %bptr, i64 3

  %wptr = bitcast i8* %bptr to i16*
  %wptr1 = bitcast i8* %bptr1 to i16*
  %wptr2 = bitcast i8* %bptr2 to i16*

  store i16 65535, i16* %wptr2, align 1
  store i16 1456, i16* %wptr1, align 1
  store i16 1346, i16* %wptr, align 1


  ret i8 0
}

define signext i8 @test6(i32 *%ptr) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i32* [[PTR:%.*]] to i16*
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 0
; CHECK-NEXT:    [[BPTR2:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 1
; CHECK-NEXT:    store i16 1456, i16* [[BPTR2]], align 1
; CHECK-NEXT:    store i16 -1, i16* [[BPTR1]], align 1
; CHECK-NEXT:    ret i8 0
;
entry:

  store i32 0, i32* %ptr

  %bptr = bitcast i32* %ptr to i16*
  %bptr1 = getelementptr inbounds i16, i16* %bptr, i64 0
  %bptr2 = getelementptr inbounds i16, i16* %bptr, i64 1

  store i16 1456, i16* %bptr2, align 1
  store i16 65535, i16* %bptr1, align 1


  ret i8 0
}

define signext i8 @test7(i64 *%ptr) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BPTR:%.*]] = bitcast i64* [[PTR:%.*]] to i16*
; CHECK-NEXT:    [[BPTR1:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 0
; CHECK-NEXT:    [[BPTR2:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 1
; CHECK-NEXT:    [[BPTR3:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 2
; CHECK-NEXT:    [[BPTR4:%.*]] = getelementptr inbounds i16, i16* [[BPTR]], i64 3
; CHECK-NEXT:    store i16 1346, i16* [[BPTR1]], align 1
; CHECK-NEXT:    store i16 1756, i16* [[BPTR3]], align 1
; CHECK-NEXT:    store i16 1456, i16* [[BPTR2]], align 1
; CHECK-NEXT:    store i16 5656, i16* [[BPTR4]], align 1
; CHECK-NEXT:    ret i8 0
;
entry:

  store i64 0, i64* %ptr

  %bptr = bitcast i64* %ptr to i16*
  %bptr1 = getelementptr inbounds i16, i16* %bptr, i64 0
  %bptr2 = getelementptr inbounds i16, i16* %bptr, i64 1
  %bptr3 = getelementptr inbounds i16, i16* %bptr, i64 2
  %bptr4 = getelementptr inbounds i16, i16* %bptr, i64 3

  store i16 1346, i16* %bptr1, align 1
  store i16 1756, i16* %bptr3, align 1
  store i16 1456, i16* %bptr2, align 1
  store i16 5656, i16* %bptr4, align 1


  ret i8 0
}
