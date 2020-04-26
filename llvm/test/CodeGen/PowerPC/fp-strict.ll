; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s -mtriple=powerpc64-unknown-linux -mcpu=pwr8 | FileCheck %s
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s -mtriple=powerpc64le-unknown-linux -mcpu=pwr9 | FileCheck %s
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s -mtriple=powerpc64le-unknown-linux -mcpu=pwr8 -mattr=-vsx | FileCheck %s -check-prefix=NOVSX

declare float @llvm.experimental.constrained.fadd.f32(float, float, metadata, metadata)
declare double @llvm.experimental.constrained.fadd.f64(double, double, metadata, metadata)
declare <4 x float> @llvm.experimental.constrained.fadd.v4f32(<4 x float>, <4 x float>, metadata, metadata)
declare <2 x double> @llvm.experimental.constrained.fadd.v2f64(<2 x double>, <2 x double>, metadata, metadata)

declare float @llvm.experimental.constrained.fsub.f32(float, float, metadata, metadata)
declare double @llvm.experimental.constrained.fsub.f64(double, double, metadata, metadata)
declare <4 x float> @llvm.experimental.constrained.fsub.v4f32(<4 x float>, <4 x float>, metadata, metadata)
declare <2 x double> @llvm.experimental.constrained.fsub.v2f64(<2 x double>, <2 x double>, metadata, metadata)

declare float @llvm.experimental.constrained.fmul.f32(float, float, metadata, metadata)
declare double @llvm.experimental.constrained.fmul.f64(double, double, metadata, metadata)
declare <4 x float> @llvm.experimental.constrained.fmul.v4f32(<4 x float>, <4 x float>, metadata, metadata)
declare <2 x double> @llvm.experimental.constrained.fmul.v2f64(<2 x double>, <2 x double>, metadata, metadata)

declare float @llvm.experimental.constrained.fdiv.f32(float, float, metadata, metadata)
declare double @llvm.experimental.constrained.fdiv.f64(double, double, metadata, metadata)
declare <4 x float> @llvm.experimental.constrained.fdiv.v4f32(<4 x float>, <4 x float>, metadata, metadata)
declare <2 x double> @llvm.experimental.constrained.fdiv.v2f64(<2 x double>, <2 x double>, metadata, metadata)

define float @fadd_f32(float %f1, float %f2) {
; CHECK-LABEL: fadd_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsaddsp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fadd_f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fadds f1, f1, f2
; NOVSX-NEXT:    blr
  %res = call float @llvm.experimental.constrained.fadd.f32(
                        float %f1, float %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret float %res
}

define double @fadd_f64(double %f1, double %f2) {
; CHECK-LABEL: fadd_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsadddp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fadd_f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fadd f1, f1, f2
; NOVSX-NEXT:    blr
  %res = call double @llvm.experimental.constrained.fadd.f64(
                        double %f1, double %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret double %res
}

define <4 x float> @fadd_v4f32(<4 x float> %vf1, <4 x float> %vf2) {
; CHECK-LABEL: fadd_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvaddsp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fadd_v4f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    addi r3, r1, -32
; NOVSX-NEXT:    addi r4, r1, -48
; NOVSX-NEXT:    stvx v3, 0, r3
; NOVSX-NEXT:    stvx v2, 0, r4
; NOVSX-NEXT:    addi r3, r1, -16
; NOVSX-NEXT:    lfs f0, -20(r1)
; NOVSX-NEXT:    lfs f1, -36(r1)
; NOVSX-NEXT:    fadds f0, f1, f0
; NOVSX-NEXT:    lfs f1, -40(r1)
; NOVSX-NEXT:    stfs f0, -4(r1)
; NOVSX-NEXT:    lfs f0, -24(r1)
; NOVSX-NEXT:    fadds f0, f1, f0
; NOVSX-NEXT:    lfs f1, -44(r1)
; NOVSX-NEXT:    stfs f0, -8(r1)
; NOVSX-NEXT:    lfs f0, -28(r1)
; NOVSX-NEXT:    fadds f0, f1, f0
; NOVSX-NEXT:    lfs f1, -48(r1)
; NOVSX-NEXT:    stfs f0, -12(r1)
; NOVSX-NEXT:    lfs f0, -32(r1)
; NOVSX-NEXT:    fadds f0, f1, f0
; NOVSX-NEXT:    stfs f0, -16(r1)
; NOVSX-NEXT:    lvx v2, 0, r3
; NOVSX-NEXT:    blr
  %res = call <4 x float> @llvm.experimental.constrained.fadd.v4f32(
                        <4 x float> %vf1, <4 x float> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <4 x float> %res
}

define <2 x double> @fadd_v2f64(<2 x double> %vf1, <2 x double> %vf2) {
; CHECK-LABEL: fadd_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvadddp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fadd_v2f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fadd f2, f2, f4
; NOVSX-NEXT:    fadd f1, f1, f3
; NOVSX-NEXT:    blr
  %res = call <2 x double> @llvm.experimental.constrained.fadd.v2f64(
                        <2 x double> %vf1, <2 x double> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <2 x double> %res
}

define float @fsub_f32(float %f1, float %f2) {
; CHECK-LABEL: fsub_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xssubsp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fsub_f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fsubs f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call float @llvm.experimental.constrained.fsub.f32(
                        float %f1, float %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret float %res;
}

define double @fsub_f64(double %f1, double %f2) {
; CHECK-LABEL: fsub_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xssubdp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fsub_f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fsub f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call double @llvm.experimental.constrained.fsub.f64(
                        double %f1, double %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret double %res;
}

define <4 x float> @fsub_v4f32(<4 x float> %vf1, <4 x float> %vf2) {
; CHECK-LABEL: fsub_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvsubsp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fsub_v4f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    addi r3, r1, -32
; NOVSX-NEXT:    addi r4, r1, -48
; NOVSX-NEXT:    stvx v3, 0, r3
; NOVSX-NEXT:    stvx v2, 0, r4
; NOVSX-NEXT:    addi r3, r1, -16
; NOVSX-NEXT:    lfs f0, -20(r1)
; NOVSX-NEXT:    lfs f1, -36(r1)
; NOVSX-NEXT:    fsubs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -40(r1)
; NOVSX-NEXT:    stfs f0, -4(r1)
; NOVSX-NEXT:    lfs f0, -24(r1)
; NOVSX-NEXT:    fsubs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -44(r1)
; NOVSX-NEXT:    stfs f0, -8(r1)
; NOVSX-NEXT:    lfs f0, -28(r1)
; NOVSX-NEXT:    fsubs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -48(r1)
; NOVSX-NEXT:    stfs f0, -12(r1)
; NOVSX-NEXT:    lfs f0, -32(r1)
; NOVSX-NEXT:    fsubs f0, f1, f0
; NOVSX-NEXT:    stfs f0, -16(r1)
; NOVSX-NEXT:    lvx v2, 0, r3
; NOVSX-NEXT:    blr
  %res = call <4 x float> @llvm.experimental.constrained.fsub.v4f32(
                        <4 x float> %vf1, <4 x float> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <4 x float> %res;
}

define <2 x double> @fsub_v2f64(<2 x double> %vf1, <2 x double> %vf2) {
; CHECK-LABEL: fsub_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvsubdp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fsub_v2f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fsub f2, f2, f4
; NOVSX-NEXT:    fsub f1, f1, f3
; NOVSX-NEXT:    blr
  %res = call <2 x double> @llvm.experimental.constrained.fsub.v2f64(
                        <2 x double> %vf1, <2 x double> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <2 x double> %res;
}

define float @fmul_f32(float %f1, float %f2) {
; CHECK-LABEL: fmul_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsmulsp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fmul_f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fmuls f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call float @llvm.experimental.constrained.fmul.f32(
                        float %f1, float %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret float %res;
}

define double @fmul_f64(double %f1, double %f2) {
; CHECK-LABEL: fmul_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsmuldp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fmul_f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fmul f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call double @llvm.experimental.constrained.fmul.f64(
                        double %f1, double %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret double %res;
}

define <4 x float> @fmul_v4f32(<4 x float> %vf1, <4 x float> %vf2) {
; CHECK-LABEL: fmul_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvmulsp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fmul_v4f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    addi r3, r1, -32
; NOVSX-NEXT:    addi r4, r1, -48
; NOVSX-NEXT:    stvx v3, 0, r3
; NOVSX-NEXT:    stvx v2, 0, r4
; NOVSX-NEXT:    addi r3, r1, -16
; NOVSX-NEXT:    lfs f0, -20(r1)
; NOVSX-NEXT:    lfs f1, -36(r1)
; NOVSX-NEXT:    fmuls f0, f1, f0
; NOVSX-NEXT:    lfs f1, -40(r1)
; NOVSX-NEXT:    stfs f0, -4(r1)
; NOVSX-NEXT:    lfs f0, -24(r1)
; NOVSX-NEXT:    fmuls f0, f1, f0
; NOVSX-NEXT:    lfs f1, -44(r1)
; NOVSX-NEXT:    stfs f0, -8(r1)
; NOVSX-NEXT:    lfs f0, -28(r1)
; NOVSX-NEXT:    fmuls f0, f1, f0
; NOVSX-NEXT:    lfs f1, -48(r1)
; NOVSX-NEXT:    stfs f0, -12(r1)
; NOVSX-NEXT:    lfs f0, -32(r1)
; NOVSX-NEXT:    fmuls f0, f1, f0
; NOVSX-NEXT:    stfs f0, -16(r1)
; NOVSX-NEXT:    lvx v2, 0, r3
; NOVSX-NEXT:    blr
  %res = call <4 x float> @llvm.experimental.constrained.fmul.v4f32(
                        <4 x float> %vf1, <4 x float> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <4 x float> %res;
}

define <2 x double> @fmul_v2f64(<2 x double> %vf1, <2 x double> %vf2) {
; CHECK-LABEL: fmul_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvmuldp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fmul_v2f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fmul f2, f2, f4
; NOVSX-NEXT:    fmul f1, f1, f3
; NOVSX-NEXT:    blr
  %res = call <2 x double> @llvm.experimental.constrained.fmul.v2f64(
                        <2 x double> %vf1, <2 x double> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <2 x double> %res;
}

define float @fdiv_f32(float %f1, float %f2) {
; CHECK-LABEL: fdiv_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsdivsp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fdiv_f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fdivs f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call float @llvm.experimental.constrained.fdiv.f32(
                        float %f1, float %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret float %res;
}

define double @fdiv_f64(double %f1, double %f2) {
; CHECK-LABEL: fdiv_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsdivdp f1, f1, f2
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fdiv_f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fdiv f1, f1, f2
; NOVSX-NEXT:    blr

  %res = call double @llvm.experimental.constrained.fdiv.f64(
                        double %f1, double %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret double %res;
}

define <4 x float> @fdiv_v4f32(<4 x float> %vf1, <4 x float> %vf2) {
; CHECK-LABEL: fdiv_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvdivsp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fdiv_v4f32:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    addi r3, r1, -32
; NOVSX-NEXT:    addi r4, r1, -48
; NOVSX-NEXT:    stvx v3, 0, r3
; NOVSX-NEXT:    stvx v2, 0, r4
; NOVSX-NEXT:    addi r3, r1, -16
; NOVSX-NEXT:    lfs f0, -20(r1)
; NOVSX-NEXT:    lfs f1, -36(r1)
; NOVSX-NEXT:    fdivs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -40(r1)
; NOVSX-NEXT:    stfs f0, -4(r1)
; NOVSX-NEXT:    lfs f0, -24(r1)
; NOVSX-NEXT:    fdivs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -44(r1)
; NOVSX-NEXT:    stfs f0, -8(r1)
; NOVSX-NEXT:    lfs f0, -28(r1)
; NOVSX-NEXT:    fdivs f0, f1, f0
; NOVSX-NEXT:    lfs f1, -48(r1)
; NOVSX-NEXT:    stfs f0, -12(r1)
; NOVSX-NEXT:    lfs f0, -32(r1)
; NOVSX-NEXT:    fdivs f0, f1, f0
; NOVSX-NEXT:    stfs f0, -16(r1)
; NOVSX-NEXT:    lvx v2, 0, r3
; NOVSX-NEXT:    blr
  %res = call <4 x float> @llvm.experimental.constrained.fdiv.v4f32(
                        <4 x float> %vf1, <4 x float> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <4 x float> %res
}

define <2 x double> @fdiv_v2f64(<2 x double> %vf1, <2 x double> %vf2) {
; CHECK-LABEL: fdiv_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvdivdp v2, v2, v3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: fdiv_v2f64:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fdiv f2, f2, f4
; NOVSX-NEXT:    fdiv f1, f1, f3
; NOVSX-NEXT:    blr
  %res = call <2 x double> @llvm.experimental.constrained.fdiv.v2f64(
                        <2 x double> %vf1, <2 x double> %vf2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret <2 x double> %res
}

define double @no_fma_fold(double %f1, double %f2, double %f3) {
; CHECK-LABEL: no_fma_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xsmuldp f0, f1, f2
; CHECK-NEXT:    xsadddp f1, f0, f3
; CHECK-NEXT:    blr
;
; NOVSX-LABEL: no_fma_fold:
; NOVSX:       # %bb.0:
; NOVSX-NEXT:    fmul f0, f1, f2
; NOVSX-NEXT:    fadd f1, f0, f3
; NOVSX-NEXT:    blr
  %mul = call double @llvm.experimental.constrained.fmul.f64(
                        double %f1, double %f2,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  %add = call double @llvm.experimental.constrained.fadd.f64(
                        double %mul, double %f3,
                        metadata !"round.dynamic",
                        metadata !"fpexcept.strict")
  ret double %add
}
