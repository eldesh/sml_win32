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
#define _In_opt_


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

HMODULE WINAPI GetModuleHandleA(
  _In_opt_  LPCTSTR lpModuleName
);

typedef struct _STARTUPINFO {
  DWORD  cb;
  LPTSTR lpReserved;
  LPTSTR lpDesktop;
  LPTSTR lpTitle;
  DWORD  dwX;
  DWORD  dwY;
  DWORD  dwXSize;
  DWORD  dwYSize;
  DWORD  dwXCountChars;
  DWORD  dwYCountChars;
  DWORD  dwFillAttribute;
  DWORD  dwFlags;
  WORD   wShowWindow;
  WORD   cbReserved2;
  LPBYTE lpReserved2;
  HANDLE hStdInput;
  HANDLE hStdOutput;
  HANDLE hStdError;
} STARTUPINFO, *LPSTARTUPINFO;

VOID WINAPI GetStartupInfoA(
  _Out_  LPSTARTUPINFO lpStartupInfo
);


#endif    /* WINAPI_KERNEL32_INCLUDED */

