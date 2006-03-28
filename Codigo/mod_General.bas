Attribute VB_Name = "mod_General"
'**************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the GNU General Public License as published by
'the Free Software Foundation; either version 2 of the License, or
'any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU General Public License for more details.
'
'You should have received a copy of the GNU General Public License
'along with this program; if not, write to the Free Software
'Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'**************************************************************

Option Explicit

Public Type tSetupMods
    bDinamic    As Boolean
    byMemory    As Byte
    bUseVideo   As Boolean
    bNoMusic    As Boolean
    bNoSound    As Boolean
End Type

Public setupMod As tSetupMods

Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Public Const SW_NORMAL As Long = 1

Public Function FileExist(ByVal file As String, ByVal FileType As VbFileAttribute) As Boolean
'*************************************************
'Author: Ivan Leoni y Fernando Costa
'Last modified: ?/?/?
'Se fija si existe el archivo
'*************************************************
    FileExist = Dir(file, FileType) <> ""
End Function

Public Sub LeerSetup()
'*************************************************
'Author: ^[GS]^
'Last modified: 10/03/06
'*************************************************
On Error Resume Next
    If FileExist(App.Path & "\init\ao.dat", vbArchive) Then
        
        Dim handle As Integer
        handle = FreeFile
        
        Open App.Path & "\Init\AO.dat" For Binary As handle
            Get handle, , setupMod
        Close handle
        
        If setupMod.bDinamic Then
            frmAOSetup.chkDinamico.Value = True
            frmAOSetup.lCuantoVideo.ForeColor = vbBlack
            frmAOSetup.pMemoria.EnabledSlider = True
            frmAOSetup.pMemoria.picFillColor = &H8080FF
            frmAOSetup.pMemoria.picForeColor = &H80FF80
        Else
            frmAOSetup.chkDinamico.Value = False
            frmAOSetup.lCuantoVideo.ForeColor = &H808080
            frmAOSetup.pMemoria.EnabledSlider = False
            frmAOSetup.pMemoria.picFillColor = &H808080
            frmAOSetup.pMemoria.picForeColor = &HC0C0C0
        End If
        
        If setupMod.byMemory >= 4 And setupMod.byMemory <= 40 Then
            frmAOSetup.pMemoria.Value = setupMod.byMemory
        End If
        
        frmAOSetup.chkUserVideo = setupMod.bUseVideo
        
        frmAOSetup.chkMusica.Value = Not setupMod.bNoMusic
        
        frmAOSetup.chkSonido.Value = Not setupMod.bNoSound
    End If
End Sub
