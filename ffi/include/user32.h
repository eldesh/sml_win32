#if !defined WINAPI_USER32_INCLUDED
#define      WINAPI_USER32_INCLUDED

#define WINAPI

//#define __cdecl
//#define __stdcall
#define CALLBACK

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

// WinUser.h
// ============================================

int
WINAPI
MessageBoxA(
    __in_opt HWND hWnd,
    __in_opt LPCSTR lpText,
    __in_opt LPCSTR lpCaption,
    __in UINT uType);

BOOL WINAPI MessageBeep(
  _In_  UINT uType
);

/*
HWND WINAPI CreateWindowA(
  _In_opt_  LPCTSTR lpClassName,
  _In_opt_  LPCTSTR lpWindowName,
  _In_      DWORD dwStyle,
  _In_      int x,
  _In_      int y,
  _In_      int nWidth,
  _In_      int nHeight,
  _In_opt_  HWND hWndParent,
  _In_opt_  HMENU hMenu,
  _In_opt_  HINSTANCE hInstance,
  _In_opt_  LPVOID lpParam
);
*/

HWND WINAPI CreateWindowExA(
  _In_      DWORD dwExStyle,
  _In_opt_  LPCTSTR lpClassName,
  _In_opt_  LPCTSTR lpWindowName,
  _In_      DWORD dwStyle,
  _In_      int x,
  _In_      int y,
  _In_      int nWidth,
  _In_      int nHeight,
  _In_opt_  HWND hWndParent,
  _In_opt_  HMENU hMenu,
  _In_opt_  HINSTANCE hInstance,
  _In_opt_  LPVOID lpParam
);

BOOL WINAPI ShowWindow(
  _In_  HWND hWnd,
  _In_  int nCmdShow
);


typedef LRESULT (CALLBACK *WNDPROC)(HWND,UINT,WPARAM,LPARAM);

// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633576%28v=vs.85%29.aspx
typedef struct tagWNDCLASS {
  UINT      style;
  WNDPROC   lpfnWndProc;
  int       cbClsExtra;
  int       cbWndExtra;
  HINSTANCE hInstance;
  HICON     hIcon;
  HCURSOR   hCursor;
  HBRUSH    hbrBackground;
  LPCTSTR   lpszMenuName;
  LPCTSTR   lpszClassName;
} WNDCLASS, *PWNDCLASS;


// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633577%28v=vs.85%29.aspx
typedef struct tagWNDCLASSEX {
  UINT      cbSize;
  UINT      style;
  WNDPROC   lpfnWndProc;
  int       cbClsExtra;
  int       cbWndExtra;
  HINSTANCE hInstance;
  HICON     hIcon;
  HCURSOR   hCursor;
  HBRUSH    hbrBackground;
  LPCTSTR   lpszMenuName;
  LPCTSTR   lpszClassName;
  HICON     hIconSm;
} WNDCLASSEX, *PWNDCLASSEX;

#define DLGWINDOWEXTRA 30

LRESULT WINAPI DefWindowProcA(HWND hWnd,UINT Msg,WPARAM wParam,LPARAM lParam);

ATOM WINAPI RegisterClassA(
  _In_  const WNDCLASS *lpWndClass
);

BOOL WINAPI UnregisterClassA(
  _In_      LPCSTR lpClassName,
  _In_opt_  HINSTANCE hInstance
);

#endif    /* WINAPI_USER32_INCLUDED */

