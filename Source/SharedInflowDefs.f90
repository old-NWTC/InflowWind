!MODULARIZATION NOTES:
!  This file will eventually be replaced with an autogenerated one by the registry program
!  So, for now we will modify this as we develop, then setup the txt file for registry program to use
!     1) modify this to match new style
!     2) setup the InflowWind.txt file for the registry program
!     3) run the registry program to generate the InflowWind_Types.f90 file
!     4) verify that works correctly before removing this (compile with each and verify output)
!
!
!----------------------------------------------------------------------------------------------------
!FIXME: rename
MODULE SharedInflowDefs
! This module is used to define shared types and parameters that are used in the module InflowWind.
! 7 Oct 2009    B. Jonkman, NREL/NWTC
!----------------------------------------------------------------------------------------------------
!
!..................................................................................................................................
! LICENSING
! Copyright (C) 2012  National Renewable Energy Laboratory
!
!    This file is part of InflowWind.
!
!    InflowWind is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as
!    published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
!
!    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
!    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
!
!    You should have received a copy of the GNU General Public License along with InflowWind.
!    If not, see <http://www.gnu.org/licenses/>.
!
!**********************************************************************************************************************************

   USE NWTC_Library                                               ! Precision module
   IMPLICIT NONE
!   PRIVATE


      !---- Initialization data ---------------------------------------------------------------------
   TYPE, PUBLIC :: IfW_InitInputType
      ! Define inputs that the initialization routine may need here:
      ! e.g., the name of the input file, the file root name, etc.
         ! Filename and type
      CHARACTER(1024)               :: WindFileName
      INTEGER                       :: WindFileType
         ! Configuration Info
      REAL(ReKi)                    :: ReferenceHeight        ! reference height for HH and/or 4D winds (was hub height), in meters
      REAL(ReKi)                    :: Width                  ! width of the HH file (was 2*R), in meters
   END TYPE IfW_InitInputType


      ! ..... States ..............................................................................................................

   TYPE, PUBLIC :: IfW_ContinuousStateType
         ! Define continuous (differentiable) states here:
      REAL(ReKi) :: DummyContState                                            ! If you have continuous states, remove this variable
         ! If you have loose coupling with a variable-step integrator, store the actual time associated with the continuous states
         !    here (eg., REAL(DbKi) :: ContTime):
   END TYPE IfW_ContinuousStateType


   TYPE, PUBLIC :: IfW_DiscreteStateType
         ! Define discrete (nondifferentiable) states here:
      REAL(ReKi) :: DummyDiscState                                            ! If you have discrete states, remove this variable
   END TYPE IfW_DiscreteStateType


   TYPE, PUBLIC :: IfW_ConstraintStateType
         ! Define constraint states here:
      REAL(ReKi) :: DummyConstrState                                          !    If you have constraint states, remove this variable
   END TYPE IfW_ConstraintStateType


   TYPE, PUBLIC :: IfW_OtherStateType
         ! Define any data that are not considered actual "states" here:
         ! e.g. data used only for optimization purposes (indices for searching in an array, copies of previous calculations of output at a given time, etc.)
      INTEGER(IntKi) :: DummyOtherState                                       !    If you have other/optimzation states, remove this variable
   END TYPE IfW_OtherStateType


      ! ..... Parameters ..........................................................................................................

   TYPE, PUBLIC :: IfW_ParameterType

         ! Define parameters here that might need to be accessed from the outside world:

         ! Filename info
      CHARACTER(1024)               :: WindFileName
      CHARACTER(1024)               :: WindFileNameRoot
      CHARACTER(3)                  :: WindFileNameExt
      INTEGER                       :: WindFileType       = 0 ! This should be initially set to match the Undef_Wind parameter in the module

         ! Location
      REAL(ReKi)                    :: ReferenceHeight        ! reference height for HH and/or 4D winds (was hub height), in meters
      REAL(ReKi)                    :: Width                  ! width of the HH file, in meters
!NOTE: might be only for HH file
      REAL(ReKi)                    :: HalfWidth              ! half the width of the HH file (was 2*R), in meters

         ! Flags
      LOGICAL                       :: CT_Flag        = .FALSE.   ! determines if coherent turbulence is used
      LOGICAL                       :: Initialized    = .FALSE.   ! did we run the initialization?

      INTEGER( IntKi )              :: UnWind                 ! Unit number for wind files

   END TYPE IfW_ParameterType


      ! ..... Inputs ..............................................................................................................

   TYPE, PUBLIC :: IfW_InputType
         ! Define inputs that are contained on the mesh here:
!     TYPE(MeshType)                            ::
         ! Define inputs that are not on this mesh here:
      Real(ReKi),ALLOCATABLE        :: Position(:,:)
   END TYPE IfW_InputType


      ! ..... Outputs .............................................................................................................

   TYPE, PUBLIC :: IfW_OutputType
         ! Define outputs that are contained on the mesh here:
!     TYPE(MeshType)                            ::
         ! Define outputs that are not on this mesh here:
      REAL(ReKi),ALLOCATABLE        :: Velocity(:,:)
   END TYPE IfW_OutputType

!-=-=-=-=-=-=-=-=-=-=-
!-=-=-=-=-=-=-=-=-=-=-
!     Original stuff below that hasn't yet been moved.
!-=-=-=-=-=-=-=-=-=-=-
!-=-=-=-=-=-=-=-=-=-=-



!This was commented out before.
!   TYPE, PUBLIC :: InflLoc
!      REAL(ReKi)                    :: Position(3)                ! X, Y, Z
!   END TYPE InflLoc


!This was moved to the submodules types
!   TYPE, PUBLIC :: InflIntrpOut
!      REAL(ReKi)                    :: Velocity(3)                ! U, V, W
!   END TYPE InflIntrpOut

   !-------------------------------------------------------------------------------------------------
   ! Shared parameters, defining the wind types
   ! THEY MUST BE UNIQUE!
   !-------------------------------------------------------------------------------------------------




END MODULE SharedInflowDefs



!!FIXME: add these in at some point.
!      ! ..... Jacobians ...........................................................................................................
!
!   TYPE, PUBLIC :: IfW_PartialOutputPInputType
!
!         ! Define the Jacobian of the output equations (Y) with respect to the inputs (u), dY/du (or Partial Y / Partial u):
!
!      TYPE(IfW_InputType) :: DummyOutput                                    ! If you have output equations and input data, update this variable
!
!   END TYPE IfW_PartialOutputPInputType
!
!
!   TYPE, PUBLIC :: IfW_PartialContStatePInputType
!
!         ! Define the Jacobian of the continuous state equations (X) with respect to the inputs (u), dX/du (or Partial X / Partial u):
!
!      TYPE(IfW_InputType) :: DummyContState                                 ! If you have continuous state equations and input data, update this variable
!
!   END TYPE IfW_PartialContStatePInputType
!
!
!   TYPE, PUBLIC :: IfW_PartialDiscStatePInputType
!
!         ! Define the Jacobian of the discrete state equations (Xd) with respect to the inputs (u), dXd/du (or Partial Xd / Partial u):
!
!      TYPE(IfW_InputType) :: DummyDiscState                                 ! If you have discrete state equations and input data, update this variable
!
!   END TYPE IfW_PartialDiscStatePInputType
!
!
!   TYPE, PUBLIC :: IfW_PartialConstrStatePInputType
!
!         ! Define the Jacobian of the constraint state equations (Z) with respect to the inputs (u), dZ/du (or Partial Z / Partial u):
!
!      TYPE(IfW_InputType) :: DummyConstrState                                ! If you have constraint state equations and input data, update this variable
!
!   END TYPE IfW_PartialConstrStatePInputType
!
!
!   TYPE, PUBLIC :: IfW_PartialOutputPContStateType
!
!         ! Define the Jacobian of the output equations (Y) with respect to the continuous states (x), dY/dx (or Partial Y / Partial x):
!
!      TYPE(IfW_ContinuousStateType) :: DummyOutput                                    ! If you have output equations and continuous states, update this variable
!
!   END TYPE IfW_PartialOutputPContStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialContStatePContStateType
!
!         ! Define the Jacobian of the continuous state equations (X) with respect to the continuous states (x), dX/dx (or Partial X / Partial x):
!
!      TYPE(IfW_ContinuousStateType) :: DummyContState                                 ! If you have continuous state equations and continuous states, update this variable
!
!   END TYPE IfW_PartialContStatePContStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialDiscStatePContStateType
!
!         ! Define the Jacobian of the discrete state equations (Xd) with respect to the continuous states (x), dXd/dx (or Partial Xd / Partial x):
!
!      TYPE(IfW_ContinuousStateType) :: DummyDiscState                                 ! If you have discrete state equations and continuous states, update this variable
!
!   END TYPE IfW_PartialDiscStatePContStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialConstrStatePContStateType
!
!         ! Define the Jacobian of the constraint state equations (Z) with respect to the continuous states (x), dZ/dx (or Partial Z / Partial x):
!
!      TYPE(IfW_ContinuousStateType) :: DummyConstrState                                ! If you have constraint state equations and continuous states, update this variable
!
!   END TYPE IfW_PartialConstrStatePContStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialOutputPDiscStateType
!
!         ! Define the Jacobian of the output equations (Y) with respect to the discrete states (xd), dY/dxd (or Partial Y / Partial xd):
!
!      TYPE(IfW_DiscreteStateType) :: DummyOutput                                    ! If you have output equations and discrete states, update this variable
!
!   END TYPE IfW_PartialOutputPDiscStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialContStatePDiscStateType
!
!         ! Define the Jacobian of the continuous state equations (X) with respect to the discrete states (xd), dX/dxd (or Partial X / Partial xd):
!
!      TYPE(IfW_DiscreteStateType) :: DummyContState                                 ! If you have continuous state equations and discrete states, update this variable
!
!   END TYPE IfW_PartialContStatePDiscStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialDiscStatePDiscStateType
!
!         ! Define the Jacobian of the discrete state equations (Xd) with respect to the discrete states (xd), dXd/dxd (or Partial Xd / Partial xd):
!
!      TYPE(IfW_DiscreteStateType) :: DummyDiscState                                 ! If you have discrete state equations and discrete states, update this variable
!
!   END TYPE IfW_PartialDiscStatePDiscStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialConstrStatePDiscStateType
!
!         ! Define the Jacobian of the constraint state equations (Z) with respect to the discrete states (xd), dZ/dxd (or Partial Z / Partial xd):
!
!      TYPE(IfW_DiscreteStateType) :: DummyConstrState                                ! If you have constraint state equations and discrete states, update this variable
!
!   END TYPE IfW_PartialConstrStatePDiscStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialOutputPConstrStateType
!
!         ! Define the Jacobian of the output equations (Y) with respect to the constraint states (z), dY/dz (or Partial Y / Partial z):
!
!      TYPE(IfW_ConstraintStateType) :: DummyOutput                                    ! If you have output equations and constraint states, update this variable
!
!   END TYPE IfW_PartialOutputPConstrStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialContStatePConstrStateType
!
!         ! Define the Jacobian of the continuous state equations (X) with respect to the constraint states (z), dX/dz (or Partial X / Partial z):
!
!      TYPE(IfW_ConstraintStateType) :: DummyContState                                 ! If you have continuous state equations and constraint states, update this variable
!
!   END TYPE IfW_PartialContStatePConstrStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialDiscStatePConstrStateType
!
!         ! Define the Jacobian of the discrete state equations (Xd) with respect to the constraint states (z), dXd/dz (or Partial Xd / Partial z):
!
!      TYPE(IfW_ConstraintStateType) :: DummyDiscState                                 ! If you have discrete state equations and constraint states, update this variable
!
!   END TYPE IfW_PartialDiscStatePConstrStateType
!
!
!   TYPE, PUBLIC :: IfW_PartialConstrStatePConstrStateType
!
!         ! Define the Jacobian of the constraint state equations (Z) with respect to the constraint states (z), dZ/dz (or Partial Z / Partial z):
!
!      TYPE(IfW_ConstraintStateType) :: DummyConstrState                                ! If you have constraint state equations and constraint states, update this variable
!
!   END TYPE IfW_PartialConstrStatePConstrStateType
!
