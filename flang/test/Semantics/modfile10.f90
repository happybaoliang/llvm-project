! RUN: %S/test_modfile.sh %s %f18 %t
! Test writing procedure bindings in a derived type.

module m
  interface
    subroutine a(i, j)
      integer :: i, j
    end subroutine
  end interface
  type, abstract :: t
    integer :: i
  contains
    procedure(a), deferred, nopass :: q
    procedure(b), deferred, nopass :: p, r
  end type
  type t2
    integer :: x
  contains
    private
    final :: c
    procedure, non_overridable :: d
  end type
  type, abstract :: t2a
  contains
    procedure(a), deferred, public, nopass :: e
  end type
  type t3
    sequence
    integer i
    real x
    double precision y
    double complex z
  end type
contains
  subroutine b()
  end subroutine
  subroutine c(x)
    type(t2) :: x
  end subroutine
  subroutine d(x)
    class(t2) :: x
  end subroutine
  subroutine test
    type(t2) :: x
    call x%d()
  end subroutine
end module

!Expect: m.mod
!module m
!  interface
!    subroutine a(i,j)
!      integer(4)::i
!      integer(4)::j
!    end
!  end interface
!  type,abstract::t
!    integer(4)::i
!  contains
!    procedure(a),deferred,nopass::q
!    procedure(b),deferred,nopass::p
!    procedure(b),deferred,nopass::r
!  end type
!  type::t2
!    integer(4)::x
!  contains
!    final::c
!    procedure,non_overridable,private::d
!  end type
!  type,abstract::t2a
!  contains
!    procedure(a),deferred,nopass::e
!  end type
!  type::t3
!    sequence
!    integer(4)::i
!    real(4)::x
!    real(8)::y
!    complex(8)::z
!  end type
!contains
!  subroutine b()
!  end
!  subroutine c(x)
!    type(t2)::x
!  end
!  subroutine d(x)
!    class(t2)::x
!  end
!  subroutine test()
!  end
!end
