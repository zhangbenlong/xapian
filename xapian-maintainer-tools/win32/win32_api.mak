# Makefile for Microsoft Visual C++ 7.0 (or compatible)
# Originally by Ulrik Petersen
# Modified by Charlie Hull, Lemur Consulting Ltd.
# www.lemurconsulting.com
# 17th March 2006

# Will build a Win32 static library (non-debug) libapi.lib


!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!INCLUDE ..\win32\config.mak


CPP=cl.exe
RSC=rc.exe


OUTDIR=..\win32\Release\libs
INTDIR=.\

ALL : "$(OUTDIR)\libapi.lib" 

LIBAPI_OBJS= \
             $(INTDIR)\omenquire.obj  \
             $(INTDIR)\omquery.obj  \
             $(INTDIR)\omqueryinternal.obj  \
             $(INTDIR)\omdatabase.obj  \
             $(INTDIR)\omstem.obj  \
             $(INTDIR)\omdocument.obj  \
             $(INTDIR)\omerror.obj  \
             $(INTDIR)\ompostlistiterator.obj  \
             $(INTDIR)\ompositionlistiterator.obj  \
             $(INTDIR)\omtermlistiterator.obj  \
             $(INTDIR)\omvalueiterator.obj \
			 $(INTDIR)\version.obj


CLEAN :
	-@erase "$(OUTDIR)\libapi.lib"
	-@erase "*.pch"
    -@erase $(LIBAPI_OBJS)


"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=$(CPPFLAGS_EXTRA) /W3 /GX /O2 \
 /I ".." /I "..\include" /I"..\common" /I"..\languages" \
 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__WIN32__" /Fo"$(INTDIR)\\" \
 /c  /D "HAVE_VSNPRINTF" /D "HAVE_STRDUP" /Tp$(INPUTNAME)
CPP_OBJS=..\win32\Release
CPP_SBRS=.

LIB32=link.exe -lib
LIB32_FLAGS=/nologo  $(LIBFLAGS)


"$(OUTDIR)\LIBAPI.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIBAPI_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) /out:"$(OUTDIR)\libapi.lib" $(DEF_FLAGS) $(LIBAPI_OBJS)
<<

"$(INTDIR)\omenquire.obj" : ".\omenquire.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omquery.obj" : ".\omquery.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omqueryinternal.obj" : ".\omqueryinternal.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omdatabase.obj" : ".\omdatabase.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omstem.obj" : ".\omstem.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omdocument.obj" : ".\omdocument.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omerror.obj" : ".\omerror.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\ompostlistiterator.obj" : ".\ompostlistiterator.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\ompositionlistiterator.obj" : ".\ompositionlistiterator.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omtermlistiterator.obj" : ".\omtermlistiterator.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<


"$(INTDIR)\omvalueiterator.obj" : ".\omvalueiterator.cc"
        $(CPP) @<<
   $(CPP_PROJ) $**
<<

"$(INTDIR)\version.obj" : ".\version.cc"
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

