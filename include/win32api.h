
#define WINAPI
#define __in_opt
#define __in

// Windows7
// http://msdn.microsoft.com/en-us/library/windows/desktop/aa383745%28v=vs.85%29.aspx
#define WIN_VER 0x0601 

typedef struct HWND__{int i;}*HWND;
typedef char CHAR;
typedef short SHORT;
typedef long LONG;
typedef char CCHAR, *PCCHAR;
typedef unsigned char UCHAR,*PUCHAR;
typedef unsigned short USHORT,*PUSHORT;
typedef unsigned long ULONG,*PULONG;
typedef char *PSZ;
typedef void *PVOID,*LPVOID;
typedef int INT;
typedef unsigned int UINT,*PUINT,*LPUINT;

typedef const CHAR *LPCCH,*PCSTR,*LPCSTR;


// WinUser.h
// ============================================

/*
 * MessageBox() Flags
 */
int
WINAPI
MessageBoxA(
    __in_opt HWND hWnd,
    __in_opt LPCSTR lpText,
    __in_opt LPCSTR lpCaption,
    __in UINT uType);

