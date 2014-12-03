#if !defined WINAPI_KERNEL32_INCLUDED
#define      WINAPI_KERNEL32_INCLUDED

#define WINAPI
#define __in_opt
#define __in
#define __out
#define _In_
#define _In_
#define _Out_
#define _Inout_


// Windows7
// http://msdn.microsoft.com/en-us/library/windows/desktop/aa383745%28v=vs.85%29.aspx
#define WIN_VER 0x0601 

#include "wintype.h"

// WinBase.h
// ============================================

__out
LPSTR
WINAPI
lstrcpyA(
    __out LPSTR lpString1,
    __in  LPCSTR lpString2
    );

LPTSTR WINAPI lstrcpy(
  _Out_  LPTSTR lpString1,
  _In_   LPTSTR lpString2
);

int WINAPI lstrlen(
  _In_  LPCTSTR lpString
);

LPTSTR WINAPI lstrcpyn(
  _Out_  LPTSTR lpString1,
  _In_   LPCTSTR lpString2,
  _In_   int iMaxLength
);

LPTSTR WINAPI lstrcat(
  _Inout_  LPTSTR lpString1,
  _In_     LPTSTR lpString2
);

LPTSTR WINAPI GetCommandLineA(void);

#endif    /* WINAPI_KERNEL32_INCLUDED */

