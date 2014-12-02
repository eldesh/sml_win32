
#define WINAPI
#define __in_opt
#define __in
#define __out

// Windows7
// http://msdn.microsoft.com/en-us/library/windows/desktop/aa383745%28v=vs.85%29.aspx
#define WIN_VER 0x0601 


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

typedef struct HWND__{int i;}*HWND;
typedef char CCHAR, *PCCHAR;
typedef unsigned char UCHAR,*PUCHAR;
typedef unsigned short USHORT,*PUSHORT;
typedef unsigned long ULONG,*PULONG;
typedef char *PSZ;
typedef void *PVOID,*LPVOID;
typedef unsigned int UINT,*PUINT,*LPUINT;

// WinBase.h
// ============================================

__out
LPSTR
WINAPI
lstrcpyA(
    __out LPSTR lpString1,
    __in  LPCSTR lpString2
    );

