# Makefile for Microsoft Visual C++ 7.0 (or compatible)
# Originally by Ulrik Petersen
# Modified by Charlie Hull, Lemur Consulting Ltd.
# www.lemurconsulting.com
# 17th March 2006


# Will build a Win32 static library (non-debug) libinmemory.lib


!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!INCLUDE ..\..\win32\config.mak


CPP=cl.exe
RSC=rc.exe


OUTDIR=..\..\win32\Release\libs
INTDIR=.\

ALL : "$(OUTDIR)\libinmemory.lib" 

LIBINMEMORY_OBJS= \
                 $(INTDIR)\inmemory_database.obj \
                 $(INTDIR)\inmemory_document.obj \
                 $(INTDIR)\inmemory_positionlist.obj \
                 $(INTDIR)\inmemory_alltermslist.obj \

CLEAN :
	-@erase "$(OUTDIR)\libinmemory.lib"
	-@erase "*.pch"
    -@erase "$(INTDIR)\getopt.obj"
	-@erase $(LIBINMEMORY_OBJS)


"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=$(CPPFLAGS_EXTRA) /W3 /GX /O2 \
 /I "..\.." /I "..\..\include" /I"..\..\common" /I"..\..\languages" \
 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__WIN32__" /Fo"$(INTDIR)\\" \
 /c  /D "HAVE_VSNPRINTF" /D "HAVE_STRDUP"
CPP_OBJS=..\..\win32\Release
CPP_SBRS=.

LIB32=link.exe -lib
LIB32_FLAGS=/nologo  $(LIBFLAGS)


"$(OUTDIR)\LIBINMEMORY.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIBINMEMORY_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) /out:"$(OUTDIR)\libinmemory.lib" $(DEF_FLAGS) $(LIBINMEMORY_OBJS)
<<



"$(INTDIR)\inmemory_database.obj" : "inmemory_database.cc"
       $(CPP) @<<
   $(CPP_PROJ) $**
<<
   
"$(INTDIR)\inmemory_document.obj" : "inmemory_document.cc"
       $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\inmemory_positionlist.obj" : "inmemory_positionlist.cc"
       $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\inmemory_alltermslist.obj" : "inmemory_alltermslist.cc"
       $(CPP) @<<
   $(CPP_PROJ) $**
<<



{.}.cc{$(INTDIR)}.obj:
	$(CPP) @<<
	$(CPP_PROJ) $< 
<<

{.}.cc{$(CPP_SBRS)}.sbr:
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

