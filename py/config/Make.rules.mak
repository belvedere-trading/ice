# **********************************************************************
#
# Copyright (c) 2003-2007 ZeroC, Inc. All rights reserved.
#
# This copy of Ice is licensed to you under the terms described in the
# ICE_LICENSE file included in this distribution.
#
# **********************************************************************

!if "$(ICE_HOME)" == ""
!error ICE_HOME is not defined
!endif

#
# Select an installation base directory. The directory will be created
# if it does not exist.
#

prefix			= C:\IcePy-$(VERSION)

#
# Define OPTIMIZE as yes if you want to build with optimization.
# Otherwise the Ice extension is built with debug information.
#

OPTIMIZE		= yes

#
# Specify your C++ compiler. Supported values are:
# VC60, VC71, VC80, VC80_EXPRESS
#
!if "$(CPP_COMPILER)" == ""
CPP_COMPILER            = VC80
!endif

#
# Set PYTHON_HOME to your Python installation directory.
#

PYTHON_HOME		= C:\Python25

#
# Define if using STLPort. Required if using MSVC++ 6.0.
#
#STLPORT_HOME            = C:\Ice-$(VERSION)-ThirdParty-VC60

# ----------------------------------------------------------------------
# Don't change anything below this line!
# ----------------------------------------------------------------------

SHELL			= /bin/sh
VERSION			= 3.2b
SOVERSION		= 32b
libdir			= $(top_srcdir)\python

install_slicedir	= $(prefix)\slice
install_pythondir	= $(prefix)\python

!include $(top_srcdir)\config\Make.rules.msvc

!if "$(OPTIMIZE)" != "yes"
LIBSUFFIX       = $(LIBSUFFIX)d
PYLIBSUFFIX     = _$(LIBSUFFIX)
!endif

ICE_LIBS		= ice$(LIBSUFFIX).lib iceutil$(LIBSUFFIX).lib slice$(LIBSUFFIX).lib

ICE_CPPFLAGS		= -I"$(ICE_HOME)\include"
ICE_LDFLAGS		= /LIBPATH:"$(ICE_HOME)\lib"

!if exist ($(top_srcdir)\slice)
slicedir		= $(top_srcdir)\slice
!else
slicedir		= $(ICE_HOME)\slice
!endif

PYTHON_CPPFLAGS		= -I"$(PYTHON_HOME)\include"
PYTHON_LDFLAGS		= /LIBPATH:"$(PYTHON_HOME)\libs"

install_libdir		= $(prefix)\python
libsubdir		= lib

ICECPPFLAGS		= -I"$(slicedir)"
SLICE2PYFLAGS		= $(ICECPPFLAGS)

SLICE2PY		= "$(ICE_HOME)\bin\slice2py.exe"

EVERYTHING		= all clean install

.SUFFIXES:
.SUFFIXES:		.cpp .obj .py

all:: $(SRCS)

.cpp.obj::
	$(CXX) /c $(CPPFLAGS) $(CXXFLAGS) $<

clean::
	del /q $(TARGETS) *.obj *.pyc *.bak

all:: $(SRCS) $(TARGETS)

install::
