#if !defined WINAPI_WINTYPE_INCLUDED
#define      WINAPI_WINTYPE_INCLUDED

#include <stdint.h>

// WinNT.h
// ============================================

//
// Void
//

//typedef void *PVOID;
//typedef void * POINTER_64 PVOID64;


//
// Basics
//

#define VOID void
typedef char CHAR;
typedef short SHORT;
typedef long LONG;
typedef int INT;

//
// ANSI (Multi-byte Character) types
//
typedef CHAR *PCHAR, *LPCH, *PCH;
typedef const CHAR *LPCCH, *PCCH;

typedef CHAR *NPSTR, *LPSTR, *PSTR;
typedef PSTR *PZPSTR;
typedef const PSTR *PCZPSTR;
typedef const CHAR *LPCSTR, *PCSTR;
typedef PCSTR *PZPCSTR;

typedef char CCHAR, *PCCHAR;
typedef unsigned char UCHAR,*PUCHAR;
typedef unsigned short USHORT,*PUSHORT;
typedef unsigned long ULONG,*PULONG;
typedef char *PSZ;
typedef void *PVOID,*LPVOID;
typedef unsigned int UINT,*PUINT,*LPUINT;

typedef int BOOL;

typedef unsigned long DWORD;
typedef uint64_t DWORDLONG;
typedef unsigned int DWORD32;
typedef uint64_t DWORD64;
typedef unsigned short WORD;

typedef unsigned char BYTE;
typedef BYTE *PBYTE;
typedef BYTE *LPBYTE;

// http://msdn.microsoft.com/en-us/library/windows/desktop/dd374131%28v=vs.85%29.aspx
typedef unsigned char TCHAR;
typedef TCHAR *LPTSTR, *LPTCH;

// http://msdn.microsoft.com/en-us/library/windows/desktop/aa383751%28v=vs.85%29.aspx
typedef LPCSTR LPCTSTR;

// winnt.h
typedef void *HANDLE;

// #define DECLARE_HANDLE(name) struct name##__ { int unused; }; typedef struct name##__ *name
#define DECLARE_HANDLE(name) typedef HANDLE name

typedef HANDLE *PHANDLE;
typedef BYTE FCHAR;
typedef WORD FSHORT;
typedef DWORD FLONG;
typedef LONG HRESULT;

// windef.h
DECLARE_HANDLE (HWND);
DECLARE_HANDLE (HHOOK);
DECLARE_HANDLE (HGDIOBJ);

DECLARE_HANDLE(HACCEL);
DECLARE_HANDLE(HBITMAP);
DECLARE_HANDLE(HBRUSH);
DECLARE_HANDLE(HCOLORSPACE);
DECLARE_HANDLE(HDC);
DECLARE_HANDLE(HGLRC);
DECLARE_HANDLE(HDESK);
DECLARE_HANDLE(HENHMETAFILE);
DECLARE_HANDLE(HFONT);
DECLARE_HANDLE(HICON);
DECLARE_HANDLE(HMENU);
DECLARE_HANDLE(HPALETTE);
DECLARE_HANDLE(HPEN);
DECLARE_HANDLE(HMONITOR);
DECLARE_HANDLE(HWINEVENTHOOK);

typedef HICON HCURSOR;
typedef DWORD COLORREF;

typedef DWORD *LPCOLORREF;

DECLARE_HANDLE(HINSTANCE);
typedef HINSTANCE HMODULE;

typedef struct tagRECT {
  LONG left;
  LONG top;
  LONG right;
  LONG bottom;
} RECT,*PRECT,*NPRECT,*LPRECT;

typedef const RECT *LPCRECT;

typedef struct _RECTL {
  LONG left;
  LONG top;
  LONG right;
  LONG bottom;
} RECTL,*PRECTL,*LPRECTL;

typedef const RECTL *LPCRECTL;

typedef struct tagPOINT {
  LONG x;
  LONG y;
} POINT,*PPOINT,*NPPOINT,*LPPOINT;

typedef struct _POINTL {
  LONG x;
  LONG y;
} POINTL,*PPOINTL;

typedef struct tagSIZE {
  LONG cx;
  LONG cy;
} SIZE,*PSIZE,*LPSIZE;

typedef SIZE SIZEL;
typedef SIZE *PSIZEL,*LPSIZEL;

typedef struct tagPOINTS {
  SHORT x;
  SHORT y;
} POINTS,*PPOINTS,*LPPOINTS;


#endif    /* WINAPI_WINTYPE_INCLUDED */

