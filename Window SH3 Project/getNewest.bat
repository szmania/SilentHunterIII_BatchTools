@if (true==false) /*
@echo off

cscript //nologo //e:JScript "%~f0" %*

pause

goto :eof
*/
@end

function getNewerFile (file1, file2) {
   return (file1 == null) ? file2 :
      (file2 == null) ? file1 :
      (file1.dateLastModified < file2.dateLastModified) ? file2 :
      file1;
}

function getNewestFile (folder) {
   var newestFile = null;

   for (var subDirs = new Enumerator (folder.SubFolders); !subDirs.atEnd (); subDirs.moveNext ()) {
      newestFile = getNewerFile (newestFile, getNewestFile (subDirs.item ()));
   }

   for (var files = new Enumerator (folder.files); !files.atEnd (); files.moveNext ()) {
      newestFile = getNewerFile (newestFile, files.item ());
   }

   return newestFile;
}

var dir = (WScript.Arguments.Unnamed.Length == 1) ? WScript.Arguments.Unnamed.Item (0) : ".";
var fso = new ActiveXObject ("Scripting.FileSystemObject");
var newestFile = getNewestFile (fso.GetFolder ((fso.FolderExists (dir)) ? dir : "."));

if (newestFile != null) {
   WScript.Echo ("" + newestFile.Path);
   WScript.Quit (0);
} else {
   WScript.Quit (1);
}

