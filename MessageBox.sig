(*
    Copyright (c) 2001
        David C.J. Matthews

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.
    
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*)
signature MESSAGE_BOX =
sig
    type HWND

    val IDABORT : int
    val IDCANCEL : int
    val IDCLOSE : int
    val IDHELP : int
    val IDIGNORE : int
    val IDNO : int
    val IDOK : int
    val IDRETRY : int
    val IDYES : int

    structure MessageBoxStyle :
      sig
        include BIT_FLAGS
        val MB_ABORTRETRYIGNORE : flags
        val MB_APPLMODAL : flags
        val MB_DEFAULT_DESKTOP_ONLY : flags
        val MB_DEFBUTTON1 : flags
        val MB_DEFBUTTON2 : flags
        val MB_DEFBUTTON3 : flags
        val MB_DEFBUTTON4 : flags
        val MB_HELP : flags
        val MB_ICONASTERISK : flags
        val MB_ICONERROR : flags
        val MB_ICONEXCLAMATION : flags
        val MB_ICONHAND : flags
        val MB_ICONINFORMATION : flags
        val MB_ICONQUESTION : flags
        val MB_ICONSTOP : flags
        val MB_ICONWARNING : flags
        val MB_NOFOCUS : flags
        val MB_OK : flags
        val MB_OKCANCEL : flags
        val MB_RETRYCANCEL : flags
        val MB_RIGHT : flags
        val MB_RTLREADING : flags
        val MB_SERVICE_NOTIFICATION : flags
        val MB_SERVICE_NOTIFICATION_NT3X : flags
        val MB_SETFOREGROUND : flags
        val MB_SYSTEMMODAL : flags
        val MB_TASKMODAL : flags
        val MB_TOPMOST : flags
        val MB_USERICON : flags
        val MB_YESNO : flags
        val MB_YESNOCANCEL : flags
      end

    val MessageBox : HWND option * string * string * MessageBoxStyle.flags -> int
    val MessageBeep: MessageBoxStyle.flags -> unit
end

