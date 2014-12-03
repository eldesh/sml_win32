#if !defined WINAPI_USER32_INCLUDED
#define      WINAPI_USER32_INCLUDED

#define WINAPI

//#define __cdecl
//#define __stdcall

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

// WinUser.h
// ============================================

int
WINAPI
MessageBoxA(
    __in_opt HWND hWnd,
    __in_opt LPCSTR lpText,
    __in_opt LPCSTR lpCaption,
    __in UINT uType);


#endif    /* WINAPI_USER32_INCLUDED */

